import 'package:flutter/material.dart';

class ReviewDetailPage extends StatefulWidget {
  const ReviewDetailPage({super.key});

  @override
  State<ReviewDetailPage> createState() => _ReviewDetailPageState();
}

class _ReviewDetailPageState extends State<ReviewDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.width,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    "assets/장비리뷰예시1.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '지냑 찰리 TF',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            '풋살화',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              for (var i = 0; i < 4; i++)
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 40,
                                ),
                              Stack(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                  ClipRect(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      widthFactor: 0.5,
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '4.9',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          _buildTag('# 풋살'),
                          SizedBox(width: 10),
                          _buildTag('# 숙련자'),
                          SizedBox(width: 10),
                          _buildTag('# 태그'),
                        ],
                      ),
                      SizedBox(height: 50),
                      Divider(
                        color: Colors.grey.withOpacity(0.4),
                        height: 10,
                        thickness: 1,
                      ),
                      ListTile(
                        title: Text('상품리뷰'),
                        trailing: const Icon(Icons.navigate_next),
                        onTap: () {
                          // Handle Edit Profile tap
                        },
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.4),
                        height: 10,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    if (index == 0) {
                      return ReviewItem(
                        image: Image.asset(
                          'assets/장비리뷰예시1.png',
                          fit: BoxFit.cover,
                        ),
                        productName: '드리블마스터',
                        reviewText: '호기심과 궁금함에 유혹을 참지 못하고 구매했습니다...',
                        rating: 5,
                        date: '2024.05.04. 09:41',
                      );
                    } else if (index == 1) {
                      return ReviewItem(
                        image: Image.asset(
                          'assets/장비리뷰예시2.png',
                          fit: BoxFit.cover,
                        ),
                        productName: '터치마에스트로',
                        reviewText: '리뷰 보고 구매했습니다. 내구성이 좋고 발에 딱 붙어서 ...',
                        rating: 5,
                        date: '2024.05.04. 09:41',
                      );
                    } else if (index == 2) {
                      return SizedBox(height: 50,); // Empty container added here
                    }
                    return null;
                  },
                  childCount: 3, // Increase the child count to 3
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      height: 20,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Text(text),
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final Image image;
  final String productName;
  final String reviewText;
  final int rating;
  final String date;

  ReviewItem({
    required this.image,
    required this.productName,
    required this.reviewText,
    required this.rating,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 8.0, right: 8.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              width: 70,
              height: 70,
              child: image,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  reviewText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: List.generate(rating, (index) {
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
