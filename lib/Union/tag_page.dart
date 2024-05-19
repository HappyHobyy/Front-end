import 'package:flutter/material.dart';
import 'package:korea_regexp/korea_regexp.dart'; // 검색 기능
import 'package:hobbyhobby/Union/tag_page_grid.dart';

class TagPage extends StatefulWidget {
  const TagPage({Key? key}) : super(key: key);

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  final List<String> selectedTags = [];
  final List<String> allHobbies = [
    "영화",
    "낚시",
    "등산",
    "풋살",
    "러닝",
    "사진",
    "클라이밍",
    "음악",
    "자전거",
    "배드민턴",
  ];
  bool isSearchTermEmpty = true;
  String searchTerm = '';

  void onSearchTermChanged(String term) {
    setState(() {
      searchTerm = term;
      isSearchTermEmpty = term.isEmpty;
    });
  }

  void toggleTag(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
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
                  ...selectedTags.map((tag) {
                    return FilterChip(
                      label: Text(tag),
                      selected: true,
                      onSelected: (_) => toggleTag(tag),
                    );
                  }).toList(),
                  // Display unselected tags
                  ...allHobbies
                      .where((tag) => !selectedTags.contains(tag))
                      .map((tag) {
                    return FilterChip(
                      label: Text(tag),
                      selected: false,
                      onSelected: (_) => toggleTag(tag),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: isSearchTermEmpty
                ? SearchEmptyState(
                    selectedTags: selectedTags,
                    toggleTag: toggleTag,
                    allHobbies: allHobbies,
                  )
                : SearchResultState(
                    selectedTags: selectedTags,
                    allHobbies: allHobbies,
                    searchTerm: searchTerm,
                    onSearchTermChanged: (term) {
                      setState(() {
                        searchTerm = term;
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
  final List<String> popularHobbies = const [
    "영화",
    "낚시",
    "등산",
    "풋살",
    "러닝",
    "사진",
    "클라이밍",
    "음악"
  ];
  final List<String> myHobbies = const ["자전거", "풋살", "배드민턴"];
  final List<String> selectedTags;
  final void Function(String) toggleTag;
  final List<String> allHobbies;

  const SearchEmptyState({
    Key? key,
    required this.selectedTags,
    required this.toggleTag,
    required this.allHobbies,
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
  final void Function(String) onSearchTermChanged;
  final List<String> allHobbies;
  final List<String> selectedTags;
  final void Function(String) toggleTag;

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
    final displayedHobbies = [
      for (final hobby in allHobbies)
        if (hobby.contains(getRegExp(searchTerm, const RegExpOptions()))) hobby,
    ];
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
