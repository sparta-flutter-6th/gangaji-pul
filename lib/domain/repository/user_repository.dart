abstract interface class UserRepository {
  Future<void> saveUser(String uid, String email, String name);
  Future<void> getUser(String uid);
}
