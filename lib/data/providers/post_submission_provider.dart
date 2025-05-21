import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/providers/post_repository_provider.dart';
import 'package:gangaji_pul/data/providers/user_data_source_provider.dart';
import 'package:gangaji_pul/presentation/view_model/post_submission_view_model.dart';

final postSubmissionViewModelProvider = Provider<PostSubmissionViewModel>((
  ref,
) {
  final postRepository = ref.read(postRepositoryProvider);
  final userDataSource = ref.read(userDataSourceProvider);
  return PostSubmissionViewModel(
    repository: postRepository,
    userRemoteDataSource: userDataSource,
  );
});
