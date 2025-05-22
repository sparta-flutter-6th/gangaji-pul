import 'package:gangaji_pul/domain/entity/rank_entity.dart';

abstract interface class RankRepository {
  Stream<List<RankEntity>?> getChatRank();
  Stream<List<RankEntity>?> getLikeRank();
  Stream<List<RankEntity>?> getPostRank();
}
