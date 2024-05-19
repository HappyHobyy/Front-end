import 'package:flutter/material.dart';

class HobbiesGrid extends StatelessWidget {
  final List<String> items;
  final List<String> selectedTags;
  final void Function(String) toggleTag;
  final Map<String, String> itemImages = const {
    "영화": "assets/hobby/영화.jpg",
    "낚시": "assets/hobby/낚시.jpg",
    "등산": "assets/hobby/등산.jpg",
    "풋살": "assets/hobby/풋살.jpg",
    "러닝": "assets/hobby/러닝.jpg",
    "사진": "assets/hobby/사진.jpg",
    "클라이밍": "assets/hobby/클라이밍.jpg",
    "음악": "assets/hobby/음악.jpg",
  };

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
        final String imagePath = itemImages[item] ?? 'assets/default.jpg';

        return GestureDetector(
          onTap: () {
            toggleTag(item); // Call toggleTag function from TagPage
          },
          child: Column(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(imagePath),
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
