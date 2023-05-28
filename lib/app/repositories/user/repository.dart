import 'package:presmaflix/app/models/user.dart';


abstract class Repository {
  Future<void> createUser(User user) async {}

  Future<User> getUserById(String id);

  Stream<User> getUser();

  Future<void> updateUser(User user);
}
