import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gangaji_pul/domain/repository/ai_image_repository.dart';

class WritingViewModel extends ChangeNotifier {
  final AiImageRepository aiRepo;

  WritingViewModel(this.aiRepo);

  Future<bool> validateImage(File image) async {
    final result = await aiRepo.analyze(image);

    final isDog = result['dog'] ?? false;
    final isGrass = result['grass'] ?? false;
    final isPerson = result['person'] ?? false;

    return isDog && isGrass && !isPerson;
  }
}
