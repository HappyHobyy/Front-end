import 'package:flutter/material.dart';
import 'package:hobbyhobby/Union/tag_page.dart';

import '../Auth/auth_manager.dart';
import '../communitys/models.dart';

class TagButton extends StatefulWidget {
  final Function(Community?) onPressed;
  final String? tagName;
  final AuthManager authManager;

  TagButton({required this.onPressed, this.tagName,required this.authManager});

  @override
  _TagButtonState createState() => _TagButtonState();
}

class _TagButtonState extends State<TagButton> {
  String? _tagName;
  late AuthManager _authManager;

  @override
  void initState() {
    super.initState();
    _tagName = widget.tagName;
    _authManager = widget.authManager;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ElevatedButton(
          onPressed: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return TagPage(
                    authManager: _authManager,
                    isMaxOne: true,
                  );
                },
              ),
            );
            if (result != null) {
              List<Community> communities = result;
              setState(() {
                _tagName = communities.first.communityName;
              });
              widget.onPressed(communities.first);
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          ),
          child: Text(_tagName ?? ""),
        ),
      ),
    );
  }
}
