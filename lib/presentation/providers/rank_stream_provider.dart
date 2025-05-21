import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/providers/rank_repository_provider.dart';
import 'package:gangaji_pul/domain/entity/rank_entity.dart';

final chatRankProvider = StreamProvider<List<RankEntity>?>((ref) => ref.watch(rankRepositoryProvider).getChatRank());

final postRankProvider = StreamProvider<List<RankEntity>?>((ref) => ref.watch(rankRepositoryProvider).getChatRank());

final likeRankProvider = StreamProvider<List<RankEntity>?>((ref) => ref.watch(rankRepositoryProvider).getLikeRank());
