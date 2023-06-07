import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.id,
    this.avatar,
    this.name = '',
    this.description = '',
    this.email = '',
  });

  final dynamic id;
  final String? avatar;
  final String name;
  final String description;
  final String email;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  User copyWith({
    String? id,
    String? avatar,
    String? name,
    String? description,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      description: description ?? this.description,
      email: email ?? this.email,
    );
  }

  factory User.fromSnapshot(
    DocumentSnapshot snapshot,
  ) {
    final data = snapshot;
    return User(
      id: data.id,
      avatar: data['avatar'],
      name: data['name'],
      description: data['description'],
      email: data['email'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'avatar': avatar,
      'name': name,
      'description': description,
      'email': email,
    };
  }

  @override
  List<Object?> get props => [id, avatar, name, description, email];

  static List<User> users = const [
    User(
      id: '1',
      avatar: 'https://ui-avatars.com/api/?name=Yanu',
      name: 'Yanuu',
      description: 'Software Engineer at Google',
      email: 'yanuarrizki165@gmail.com',
    ),
  ];
}
