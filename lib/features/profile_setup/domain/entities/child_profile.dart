/// Perfil del niño - Entity pura de dominio
class ChildProfile {
  final String id;
  final String firstName;
  final String lastName;
  final String avatar;
  final DateTime createdAt;

  const ChildProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.createdAt,
  });

  String get fullName => '$firstName $lastName'.trim();

  ChildProfile copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? avatar,
    DateTime? createdAt,
  }) {
    return ChildProfile(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChildProfile &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
