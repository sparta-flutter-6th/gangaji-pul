import 'package:gangaji_pul/domain/entity/user_model.dart';

abstract interface class RankDataSource {
  Stream<List<UserModel>?> getPostRank();
  Stream<List<UserModel>?> getLikeRank();
  Stream<List<UserModel>?> getChatRank();
}
