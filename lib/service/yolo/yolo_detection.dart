import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:yolo_helper/yolo_helper.dart';

class YoloDetection {
  Interpreter? _interpreter;
  List<String>? _labels;
  int? _numClasses;

  bool get isInitialized => _interpreter != null && _labels != null;

  /// 모델과 라벨 초기화
  Future<void> init() async {
    _interpreter = await Interpreter.fromAsset('assets/models/yolov8n.tflite');
    final labelData = await rootBundle.loadString('assets/models/labels.txt');
    _labels = labelData.trim().split('\n');
    _numClasses = _labels!.length;
    print("YOLO 초기화 완료: classes=$_numClasses");
  }

  /// 사람(person)이 없고, 강아지(dog)가 있으면 true 반환
  Future<bool> validateImage(File imageFile) async {
  if (!isInitialized) return false;

  final imageBytes = await imageFile.readAsBytes();
  final oriImage = img.decodeImage(imageBytes)!;

  // 640x640 사이즈로 resize
  final resized = img.copyResize(oriImage, width: 640, height: 640);

  // 정규화된 입력 생성
  final input = List.generate(
    640,
    (y) => List.generate(640, (x) {
      final pixel = resized.getPixel(x, y);
      return [
        img.getRed(pixel) / 255.0,
        img.getBlue(pixel) / 255.0,
        img.getGreen(pixel) / 255.0,
      ];
    }),
  );

  // YOLOv8 output buffer
  final output = [
    List<List<double>>.generate(
      4 + _numClasses!,
      (_) => List.filled(8400, 0),
    ),
  ];

  // 추론 실행
  _interpreter!.run([input], output);

  // 결과 파싱
  final results = YoloHelper.parse(
    output[0],
    oriImage.width,
    oriImage.height,
  );

  // 클래스 기준 분석
  bool hasDog = false;
  bool hasPerson = false;

  for (final result in results) {
    final label = _labels![result.labelIndex].toLowerCase();
    print("감지됨: $label (${result.score.toStringAsFixed(2)})");

    if (label == 'dog') hasDog = true;
    if (label == 'person') hasPerson = true;
  }

  print("최종 판정: 강아지=$hasDog / 사람=$hasPerson");

  return hasDog && !hasPerson;
}

}
