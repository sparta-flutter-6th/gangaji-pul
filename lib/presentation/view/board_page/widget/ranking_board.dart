import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/const/color_const.dart';
import 'package:gangaji_pul/presentation/providers/rank_stream_provider.dart';
import 'package:gangaji_pul/presentation/view/board_page/widget/ranking_profile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RankingBoard extends ConsumerStatefulWidget {
  const RankingBoard({super.key});

  @override
  ConsumerState<RankingBoard> createState() => _RankingBoardState();
}

class _RankingBoardState extends ConsumerState<RankingBoard> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final chatRankAsync = ref.watch(chatRankProvider);
    final likeRankAsync = ref.watch(likeRankProvider);
    final postRankAsync = ref.watch(postRankProvider);

    final isLoading = chatRankAsync.isLoading || likeRankAsync.isLoading || postRankAsync.isLoading;
    final isError = chatRankAsync.hasError || likeRankAsync.hasError || postRankAsync.hasError;
    if (isError) {
      return _buildLoadingOrError("랭킹 정보를 불러오는 중 오류가 발생했습니다.");
    }

    if (isLoading) {
      return _buildLoading();
    }

    final chatRank = chatRankAsync.asData!.value;
    final likeRank = likeRankAsync.asData!.value;
    final postRank = postRankAsync.asData!.value;

    final pageData = [(title: "오늘의 채팅왕", rankEntries: chatRank), (title: "좋아요왕", rankEntries: likeRank), (title: "산책왕", rankEntries: postRank)];

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
              pageData.map((entry) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(color: normalBrownColor, borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.all(16),
                    child: RankingProfile(entry: entry),
                  ),
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
          effect: JumpingDotEffect(dotHeight: 6, dotWidth: 6, activeDotColor: Colors.white, dotColor: Colors.white.withAlpha(150)),
        ),
      ),
    );
  }

  Widget _buildLoadingOrError(String message) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 270, // 높이 고정
        decoration: BoxDecoration(color: normalBrownColor, borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(16),
        child: Center(child: Text(message, style: const TextStyle(color: Colors.white))),
      ),
    );
  }

  Widget _buildLoading() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 270, // 높이 고정
        decoration: BoxDecoration(color: normalBrownColor, borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(16),
        child: const Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
    );
  }
}
