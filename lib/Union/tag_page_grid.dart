import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';

import '../communitys/models.dart';

class HobbiesGrid extends StatelessWidget {
  final List<Community> items;
  final List<Community> selectedTags;
  final void Function(Community) toggleTag;

  const HobbiesGrid({
    Key? key,
    required this.items,
    required this.selectedTags,
    required this.toggleTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (BuildContext context, int index) {
        final Community item = items[index];
        final AssetImage image = items[index].getHobbyImage();
        return GestureDetector(
          onTap: () {

            toggleTag(item);
          },
          child: Column(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: image,
              ),
              const SizedBox(height: 2),
              Text(
                item.communityName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      selectedTags.contains(item) ? Colors.blue : Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
