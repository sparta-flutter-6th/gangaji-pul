import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String get bannerAdUnitId {
  if (kReleaseMode) {
    if (Platform.isAndroid) {
      //Android + 릴리즈
      return dotenv.env['BANNER_AD_UNIT_ID_ANDROID_RELEASE']!;
    } else if (Platform.isIOS) {
      //IOS + 릴리즈
      return dotenv.env['BANNER_AD_UNIT_ID_IOS_RELEASE']!;
    }
  }
  // 디버그 모드면 테스트용 ID
  return dotenv.env['BANNER_AD_UNIT_ID_DEBUG']!;
}
