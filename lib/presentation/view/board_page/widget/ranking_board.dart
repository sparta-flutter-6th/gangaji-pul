import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gangaji_pul/const/color_const.dart';
import 'package:gangaji_pul/presentation/view/board_page/widget/ranking_profile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RankingBoard extends StatefulWidget {
  const RankingBoard({super.key});

  @override
  State<RankingBoard> createState() => _RankingBoardState();
}

class _RankingBoardState extends State<RankingBoard> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            height: 270,
            viewportFraction: 1,
            onPageChanged: (index, _) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
          items:
              [1, 2, 3].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color: normalBrownColor, borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text("이달의 산책왕", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                RankingProfile(ranking: 2, userName: "abc", value: 20),
                                RankingProfile(ranking: 1, userName: "abc", value: 20),
                                RankingProfile(ranking: 3, userName: "abc", value: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
        ),
        _dotIndicator(),
      ],
    );
  }

  Align _dotIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        alignment: Alignment.bottomCenter,
        child: AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: 3,
          effect: JumpingDotEffect(dotHeight: 6, dotWidth: 6, activeDotColor: Colors.white, dotColor: Colors.white.withValues(alpha: 0.6)),
        ),
      ),
    );
  }
}
