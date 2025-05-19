import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/presentation/providers/post_view_model_provider.dart';
import 'package:gangaji_pul/presentation/view/bottom_nav_bar.dart';
import 'package:gangaji_pul/data/dto/post_dto.dart';

import 'package:gangaji_pul/presentation/view/home_page/widget/favorite_button.dart';
import 'package:gangaji_pul/presentation/view/home_page/widget/post_info_column.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  List<PostDto> posts = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final postViewmodel = ref.read(postViewModelProvider.notifier);
      await postViewmodel.fetchPost();
      await postViewmodel.fetchPost();
    });

    _pageController.addListener(() {
      final next = _pageController.page?.round() ?? 0;
      if (_currentIndex != next) {
        setState(() => _currentIndex = next);
        final posts = ref.read(postViewModelProvider);
        if (next >= posts.length - 1) {
          ref.read(postViewModelProvider.notifier).fetchPost();
        }
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
    final postsProvider = ref.watch(postViewModelProvider);

    if (postsProvider.length < 2) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: postsProvider.length,
        itemBuilder: (context, index) {
          final post = postsProvider[index];
          final imageUrl = 'https://picsum.photos/200/300?random=$index';
          return Stack(
            children: [
              SizedBox.expand(
                child: Image.network(post.imageUrl, fit: BoxFit.cover),
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
                        id: post.userId,
                        dateTime:
                            "${post.createdAt.month}월 ${post.createdAt.day}일",
                        content: post.content,
                        hashTag: post.tags,
                      ),
                      const Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FavoriteButton(isFavorite: false),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              //바텀시트 오픈
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
          colors: [Colors.transparent, Colors.black.withAlpha(180)],
        ),
      ),
    );
  }
}
