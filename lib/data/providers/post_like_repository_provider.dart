import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/providers/post_like_data_source_provider.dart';
import 'package:gangaji_pul/data/repository/post_like_repository_impl.dart';
import 'package:gangaji_pul/domain/repository/post_like_repository.dart';

final postLikeRepositoryProvider = Provider<PostLikeRepository>((ref) {
  final dataSource = ref.read(postlikeDataSourceProvider);
  return PostLikeRepositoryImpl(dataSource);
});
