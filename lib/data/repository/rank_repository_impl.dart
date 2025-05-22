import 'package:gangaji_pul/data/data_source/rank_data_source.dart';
import 'package:gangaji_pul/domain/entity/rank_entity.dart';
import 'package:gangaji_pul/domain/repository/rank_repository.dart';

class RankRepositoryImpl implements RankRepository {
  final RankDataSource _dataSource;

  RankRepositoryImpl(this._dataSource);

  @override
  Stream<List<RankEntity>?> getChatRank() {
    return _dataSource.getChatRank().map((userList) {
      if (userList == null) return null;
      return userList.map((user) {
        return RankEntity(user: user, value: user.chatCount);
      }).toList();
    });
  }

  @override
  Stream<List<RankEntity>?> getLikeRank() {
    return _dataSource.getLikeRank().map((userList) {
      if (userList == null) return null;
      return userList.map((user) {
        return RankEntity(user: user, value: user.likeCount);
      }).toList();
    });
  }

  @override
  Stream<List<RankEntity>?> getPostRank() {
    return _dataSource.getPostRank().map((userList) {
      if (userList == null) return null;
      return userList.map((user) {
        return RankEntity(user: user, value: user.postCount);
      }).toList();
    });
  }
}
