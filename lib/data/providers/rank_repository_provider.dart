import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/providers/rank_data_source_provider.dart';
import 'package:gangaji_pul/data/repository/rank_repository_impl.dart';
import 'package:gangaji_pul/domain/repository/rank_repository.dart';

final rankRepositoryProvider = Provider<RankRepository>((ref) {
  final dataSource = ref.read(rankDataSourceProvider);
  return RankRepositoryImpl(dataSource);
});
