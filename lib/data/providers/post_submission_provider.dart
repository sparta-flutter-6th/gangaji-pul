import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/data_source/user_remote_data_source.dart';
import 'package:gangaji_pul/data/providers/post_repository_provider.dart';
import 'package:gangaji_pul/presentation/view_model/post_submission_view_model.dart';

final postSubmissionViewModelProvider = Provider<PostSubmissionViewModel>((ref) {
  final postRepository = ref.read(postRepositoryProvider);
  final userDataSource = UserRemoteDataSource(FirebaseFirestore.instance);
  return PostSubmissionViewModel(
    repository: postRepository,
    userRemoteDataSource: userDataSource,
  );
});
