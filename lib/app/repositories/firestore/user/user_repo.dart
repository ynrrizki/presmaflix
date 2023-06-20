import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:presmaflix/app/models/user/user.dart';
import 'package:presmaflix/app/repositories/firestore/user/repository.dart';

class UserRepository extends Repository {
  final auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({
    FirebaseFirestore? firebaseFirestore,
    auth.FirebaseAuth? firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Future<void> createUser(User user) async {
    final userRef = _firebaseFirestore.collection('users').doc(user.id);
    final userExist = (await userRef.get()).exists;

    if (!userExist) {
      await userRef.set(user.toDocument());
    }
  }

  @override
  Future<User> getUserById(String id) async {
    try {
      final snapshot =
          await _firebaseFirestore.collection('users').doc(id).get();
      final userData = snapshot.data() as Map<String, dynamic>;

      return User(
        id: id,
        avatar: userData['avatar'],
        name: userData['name'],
        description: userData['description'],
        email: userData['email'],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<User> getUser({String? uid}) {
    final currentUserUid = uid ?? _firebaseAuth.currentUser!.uid;

    return _firebaseFirestore
        .collection('users')
        .doc(currentUserUid)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  Stream<User> getUserByEmail({String? email}) {
    log(email!, name: 'user_repo');
    return _firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: email)
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs.map((e) => User.fromSnapshot(e)).first;
      },
    );
  }

  Stream<String?> getUserAvatarByEmail({required String email}) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .snapshots()
        .map((snapshot) {
      String? avatar;
      for (var doc in snapshot.docs) {
        avatar = doc.data()['avatar'];
      }
      return avatar;
    });
  }

  @override
  Future<void> updateUser(User user) async {
    log('Ini adalah id: ${user.id}');
    final userRef = _firebaseFirestore.collection('users').doc(user.id);

    return userRef.update(user.toDocument());
  }
}
