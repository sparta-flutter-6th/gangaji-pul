import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gangaji_pul/service/yolo/yolo_detection.dart';

class WritingViewModel {
  final YoloDetection aiService = YoloDetection();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  File? selectedImage;
  bool isImageValid = false;
  bool isLoading = false;

  Future<void> init() async {
    await aiService.init();
  }

  Future<bool> pickAndValidateImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return false;

    final image = File(picked.path);
    final isValid = await aiService.validateImage(image);

    isImageValid = isValid;
    selectedImage = isValid ? image : null;
    return isValid;
  }
}
