import 'package:flutter/material.dart';
import 'package:hobbyhobby/Community/community_remote_api.dart';
import 'package:hobbyhobby/Community/community_repository.dart';
import 'package:hobbyhobby/Union/tag_view_model.dart';
import 'package:korea_regexp/korea_regexp.dart'; // 검색 기능
import 'package:hobbyhobby/Union/tag_page_grid.dart';

import '../Auth/auth_manager.dart';
import '../communitys/models.dart';
import '../constants.dart';

class TagPage extends StatefulWidget {
  final AuthManager authManager;
  final bool isMaxOne;

  const TagPage(
      {super.key, required this.authManager, required this.isMaxOne});

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  final List<Community> allHobbies = Constants.communitiesList;
  final List<Community> selectedTags = [];
  late AuthManager _authManager;
  late CommunityRepository _communityRepository;
  late TagViewModel _tagViewModel;
  late List<Community> popularHobbies;
  late List<Community> myHobbies;
  late bool _isSingleMeeting;

  bool isSearchTermEmpty = true;
  String searchTerm = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _authManager = widget.authManager;
    _communityRepository = CommunityRepository(CommunityRemoteApi());
    _tagViewModel = TagViewModel(_communityRepository, _authManager);
    _isSingleMeeting = widget.isMaxOne;
    loadCommunityList();
  }

  void loadCommunityList() async {
    try {
      popularHobbies = await _tagViewModel.getPopularCommunityList();
      myHobbies = await _tagViewModel.getUserCommunityList();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load meetings: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void onSearchTermChanged(String term) {
    setState(() {
      searchTerm = term;
      isSearchTermEmpty = term.isEmpty;
    });
  }

  void toggleTag(Community community) {
    setState(() {
      if (selectedTags.contains(community)) {
        selectedTags.remove(community);
      } else {
        if (_isSingleMeeting && selectedTags.isEmpty) {
          selectedTags.add(community);
        }
        if (!_isSingleMeeting && selectedTags.length < 2) {
          selectedTags.add(community);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "모임",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, selectedTags);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0),
            child: SizedBox(
              height: 40,
              child: TextField(
                onChanged: onSearchTermChanged,
                decoration: const InputDecoration(
                  hintText: '태그를 검색하세요',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 8.0,
                children: [
                  // Display selected tags
                  ...selectedTags.map((community) {
                    return FilterChip(
                      label: Text(community.communityName),
                      selected: true,
                      onSelected: (_) => toggleTag(community),
                    );
                  }).toList(),
                  // Display unselected tags
                  ...allHobbies
                      .where((community) =>
                          !selectedTags.contains(community.communityName))
                      .map((community) {
                    return FilterChip(
                      label: Text(community.communityName),
                      selected: false,
                      onSelected: (_) => toggleTag(community),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : isSearchTermEmpty
                    ? SearchEmptyState(
                        selectedTags: selectedTags,
                        toggleTag: toggleTag,
                        allHobbies: allHobbies,
                        myHobbies: myHobbies,
                        popularHobbies: popularHobbies,
                      )
                    : SearchResultState(
                        selectedTags: selectedTags,
                        allHobbies: allHobbies,
                        searchTerm: searchTerm,
                        onSearchTermChanged: (community) {
                          setState(() {
                            searchTerm = community.communityName;
                            isSearchTermEmpty = searchTerm.isEmpty;
                          });
                        },
                        toggleTag: toggleTag,
                      ),
          ),
        ],
      ),
    );
  }
}

class SearchEmptyState extends StatelessWidget {
  final List<Community> myHobbies;
  final List<Community> popularHobbies;
  final List<Community> selectedTags;
  final void Function(Community) toggleTag;
  final List<Community> allHobbies;

  const SearchEmptyState({
    Key? key,
    required this.selectedTags,
    required this.toggleTag,
    required this.allHobbies,
    required this.myHobbies,
    required this.popularHobbies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          const Text(
            '인기모임',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          HobbiesGrid(
            items: popularHobbies,
            selectedTags: selectedTags,
            toggleTag: toggleTag,
          ),
          const Text(
            '내 취미 모임',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          HobbiesGrid(
            items: myHobbies,
            selectedTags: selectedTags,
            toggleTag: toggleTag,
          ),
        ],
      ),
    );
  }
}

class SearchResultState extends StatelessWidget {
  final String searchTerm;
  final void Function(Community) onSearchTermChanged;
  final List<Community> allHobbies;
  final List<Community> selectedTags;
  final void Function(Community) toggleTag;

  const SearchResultState({
    Key? key,
    required this.searchTerm,
    required this.onSearchTermChanged,
    required this.allHobbies,
    required this.selectedTags,
    required this.toggleTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayedHobbies = allHobbies.where((hobby) {
      final regExp = getRegExp(searchTerm, const RegExpOptions());
      return regExp.hasMatch(hobby.communityName);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          HobbiesGrid(
            items: displayedHobbies,
            selectedTags: selectedTags,
            toggleTag: toggleTag,
          ),
        ],
      ),
    );
  }
}
