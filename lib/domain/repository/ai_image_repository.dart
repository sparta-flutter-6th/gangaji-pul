import 'dart:io';

abstract class AiImageRepository {
  Future<Map<String, bool>> analyze(File image);
}
