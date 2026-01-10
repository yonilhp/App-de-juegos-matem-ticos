/// Perfil del niño
class ChildProfile {
  final String id;
  final String firstName;
  final String lastName;
  final String avatar; // emoji del animalito
  final DateTime createdAt;

  ChildProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.createdAt,
  });

  String get fullName => '$firstName $lastName';

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'avatar': avatar,
    'createdAt': createdAt.toIso8601String(),
  };

  factory ChildProfile.fromJson(Map<String, dynamic> json) => ChildProfile(
    id: json['id'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    avatar: json['avatar'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

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
}
