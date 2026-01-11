import 'package:num_num/features/profile_setup/domain/entities/child_profile.dart';

/// Model para serialización de ChildProfile
/// Se usa para comunicación con API/Firebase/SharedPreferences
class ChildProfileModel {
  final String id;
  final String firstName;
  final String lastName;
  final String avatar;
  final DateTime createdAt;

  const ChildProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.createdAt,
  });

  /// Convertir desde JSON (API/Firebase/Storage)
  factory ChildProfileModel.fromJson(Map<String, dynamic> json) {
    return ChildProfileModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String? ?? '',
      avatar: json['avatar'] as String,
      createdAt: json['createdAt'] is String
          ? DateTime.parse(json['createdAt'] as String)
          : (json['createdAt'] as DateTime),
    );
  }

  /// Convertir a JSON para guardar
  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'avatar': avatar,
    'createdAt': createdAt.toIso8601String(),
  };

  /// Crear Model desde Entity
  factory ChildProfileModel.fromEntity(ChildProfile entity) {
    return ChildProfileModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      avatar: entity.avatar,
      createdAt: entity.createdAt,
    );
  }

  /// Convertir a Entity para usar en la app
  ChildProfile toEntity() {
    return ChildProfile(
      id: id,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      createdAt: createdAt,
    );
  }
}
