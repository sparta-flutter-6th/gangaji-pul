import 'package:flutter/material.dart';
import 'package:gangaji_pul/presentation/view/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool isFavorite = false;
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

  void _precacheNextImage(int index) {
    final nextImage = NetworkImage('https://picsum.photos/200/300?random=$index');
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
          return Stack(
            children: [
              SizedBox.expand(child: Image.network(imageUrl, fit: BoxFit.cover)),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7), // 아래로 갈수록 어두워짐
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("아이디", style: TextStyle(color: Colors.white, fontSize: 30)),
                        Text("내용", style: TextStyle(color: Colors.white, fontSize: 25)),
                        Text("#해시태그#태그", style: TextStyle(color: Colors.white, fontSize: 18)),
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // 좋아요 api 요청
                              isFavorite = !isFavorite;
                            });
                          },
                          child:
                              isFavorite
                                  ? Icon(Icons.favorite, size: 50, color: Colors.red)
                                  : Icon(Icons.favorite_border, size: 50, color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            //바텀시트 오픈
                          },
                          child: Icon(Icons.chat_outlined, size: 50, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
