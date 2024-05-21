import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';

class HobbiesGrid extends StatelessWidget {
  final List<String> items;
  final List<String> selectedTags;
  final void Function(String) toggleTag;

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
        final String item = items[index];
        final AssetImage image = Constants.hobbyImageMap[item] ??
            const AssetImage('assets/icon.jpg');

        return GestureDetector(
          onTap: () {
            toggleTag(item); // Call toggleTag function from TagPage
          },
          child: Column(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: image,
              ),
              const SizedBox(height: 2),
              Text(
                item,
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
