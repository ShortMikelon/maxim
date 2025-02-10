class Profile {
  final String password;
  final String prof;

  const Profile({
    required this.password,
    required this.prof,
  });

  Profile copyWith({
    String? password,
    String? prof,
  }) {
    return Profile(
      password: password ?? this.password,
      prof: prof ?? this.prof,
    );
  }

  factory Profile.fromMap(Map<String, String> map) {
    return Profile(
      password: map['password'] as String,
      prof: map['prof'] as String,
    );
  }
}