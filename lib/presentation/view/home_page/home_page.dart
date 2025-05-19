import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gangaji_pul/data/dto/post_dto.dart';
import 'package:gangaji_pul/presentation/view/bottom_nav_bar.dart';
import 'package:gangaji_pul/presentation/view/home_page/widget/comment_bottom_sheet.dart';
import 'package:gangaji_pul/presentation/view/home_page/widget/favorite_button.dart';
import 'package:gangaji_pul/presentation/view/home_page/widget/post_info_column.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool isFavorite = false;
  List<PostDto> posts = [];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precacheNextImage(1);
    });

    _pageController.addListener(() {
      int next = _pageController.page?.round() ?? 0;
      if (_currentIndex != next) {
        setState(() {
          _currentIndex = next;
          isFavorite = false;
        });
        _precacheNextImage(next + 1);
      }
    });
  }

  Future<void> fetchPosts() async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('posts')
            .orderBy('createdAt', descending: true)
            .get();

    setState(() {
      posts =
          snapshot.docs
              .map((doc) => PostDto.fromFirebase(doc.data(), doc.id))
              .toList();
    });
  }

  void _precacheNextImage(int index) {
    final nextImage = NetworkImage(
      'https://picsum.photos/200/300?random=$index',
    );
    precacheImage(nextImage, context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final imageUrl = 'https://picsum.photos/200/300?random=$index';
          final post = posts[index]; //추가한거
          return Stack(
            children: [
              SizedBox.expand(
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
              _shadeBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      PostInfoColumn(
                        id: "아이디",
                        dateTime: "5월 16일",
                        content: "강아지산책완료",
                        hashTag: ["해쉬", "해쉬태그", "해시태그"],
                      ),
                      Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FavoriteButton(isFavorite: false),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              //바텀 시트 오픈
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder:
                                    (context) =>
                                        CommentBottomSheet(postId: post.postId),
                              );
                            },
                            child: Icon(
                              Icons.chat_outlined,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Container _shadeBox() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
        ),
      ),
    );
  }
}
