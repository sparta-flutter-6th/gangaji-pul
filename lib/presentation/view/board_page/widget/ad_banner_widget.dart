import 'package:flutter/material.dart';
import 'package:gangaji_pul/core/banner_ad_unit_id.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// 배너 광고를 표시하는 커스텀 위젯.
// 광고가 성공적으로 로드되면 화면에 보여짐.
class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({super.key});

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false; // 광고 로딩 여부 상태

  @override
  void initState() {
    super.initState();
    // 광고 객체 생성 및 초기화
    _bannerAd = BannerAd(
      adUnitId: bannerAdUnitId, // 테스트용 배너 광고 단위 ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        // 광고 로드 성공 시
        onAdLoaded: (_) => setState(() => _isLoaded = true),
        // 광고 로드 실패 시
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('Ad failed to load: $error');
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 광고가 아직 로드되지 않았거나 null이면 아무것도 보여주지 않음
    if (!_isLoaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }
    // 화면 출력
    return SizedBox(
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
