import 'package:flutter/material.dart';
import 'package:gangaji_pul/presentation/view/home_page/home_page.dart';
import 'package:gangaji_pul/presentation/view/my_page/my_page.dart';
import 'package:gangaji_pul/presentation/view/post_page.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Color(0xFFB1D182),
          notchMargin: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: currentIndex == 0 ? Colors.green : Colors.grey),
                onPressed: () {
                  if (currentIndex != 0) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
                  }
                },
              ),
              const SizedBox(width: 48),
              IconButton(
                icon: Icon(Icons.person, color: currentIndex == 2 ? Colors.green : Colors.grey),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MyPage()));
                },
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 30, //위치수정
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const PostPage()));
            },

            backgroundColor: Color(0xFF688F4E),

            child: const Icon(Icons.edit, color: Color(0xFFF4F1E9)),
          ),
        ),
      ],
    );
  }
}
