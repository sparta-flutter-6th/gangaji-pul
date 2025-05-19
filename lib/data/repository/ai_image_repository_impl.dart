import 'dart:io';
import 'package:gangaji_pul/data/data_source/ai_image_analyzer.dart';
import 'package:gangaji_pul/domain/repository/ai_image_repository.dart';

class AiImageRepositoryImpl implements AiImageRepository {
  final AiImageAnalyzer analyzer;

  AiImageRepositoryImpl(this.analyzer);

  @override
  Future<Map<String, bool>> analyze(File image) {
    return analyzer.analyzeImage(image);
  }
}
