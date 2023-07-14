import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.id,
    this.avatar,
    this.name = '',
    this.email = '',
    this.description = '',
  });

  final dynamic id;
  final String? avatar;
  final String? name;
  final String? email;
  final String? description;

  static const empty = User(id: '', email: null);

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  String get avatarDefault =>
      Uri.encodeFull('https://ui-avatars.com/api/?name=$name').toString();

  User copyWith({
    String? id,
    String? avatar,
    String? name,
    String? email,
    String? description,
  }) {
    return User(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      email: email ?? this.email,
      description: description ?? this.description,
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
      email: data['email'],
      description: data['description'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'avatar': avatar,
      'name': name,
      'email': email,
      'description': description,
    };
  }

  @override
  List<Object?> get props => [id, avatar, name, email, description];

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
