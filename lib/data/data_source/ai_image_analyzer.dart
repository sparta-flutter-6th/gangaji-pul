import 'dart:io';

class AiImageAnalyzer {
  Future<Map<String, bool>> analyzeImage(File image) async {
    // 추후 HTTP로 YOLO 서버와 통신하는 부분으로 대체 가능
    await Future.delayed(Duration(seconds: 1));
    return {
      'dog': true,
      'grass': true,
      'person': false,
    };
  }
}
