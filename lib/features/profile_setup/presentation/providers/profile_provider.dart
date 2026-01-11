import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:num_num/features/profile_setup/domain/entities/child_profile.dart';
import 'package:num_num/features/profile_setup/data/models/child_profile_model.dart';

/// Provider para manejar el perfil del niño
class ProfileProvider extends ChangeNotifier {
  static const String _profileKey = 'child_profile';

  ChildProfile? _profile;
  bool _isLoading = true;
  String? _error;

  ChildProfile? get profile => _profile;
  bool get isLoading => _isLoading;
  bool get hasProfile => _profile != null;
  String? get error => _error;

  ProfileProvider() {
    _loadProfile();
  }

  /// Cargar perfil desde SharedPreferences
  Future<void> _loadProfile() async {
    try {
      _isLoading = true;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final profileJson = prefs.getString(_profileKey);

      if (profileJson != null) {
        final Map<String, dynamic> data = jsonDecode(profileJson);
        _profile = ChildProfileModel.fromJson(data).toEntity();
      }

      _error = null;
    } catch (e) {
      _error = 'Error al cargar perfil: $e';
      debugPrint(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Crear un nuevo perfil
  Future<bool> createProfile({
    required String firstName,
    required String lastName,
    required String avatar,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final profile = ChildProfile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        firstName: firstName,
        lastName: lastName,
        avatar: avatar,
        createdAt: DateTime.now(),
      );

      final prefs = await SharedPreferences.getInstance();
      final model = ChildProfileModel.fromEntity(profile);
      await prefs.setString(_profileKey, jsonEncode(model.toJson()));

      _profile = profile;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Error al crear perfil: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Actualizar perfil existente
  Future<bool> updateProfile({
    String? firstName,
    String? lastName,
    String? avatar,
  }) async {
    if (_profile == null) return false;

    try {
      final updatedProfile = _profile!.copyWith(
        firstName: firstName,
        lastName: lastName,
        avatar: avatar,
      );

      final prefs = await SharedPreferences.getInstance();
      final model = ChildProfileModel.fromEntity(updatedProfile);
      await prefs.setString(_profileKey, jsonEncode(model.toJson()));

      _profile = updatedProfile;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Error al actualizar perfil: $e';
      notifyListeners();
      return false;
    }
  }

  /// Eliminar perfil (para reiniciar la app)
  Future<void> deleteProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_profileKey);
      _profile = null;
      notifyListeners();
    } catch (e) {
      _error = 'Error al eliminar perfil: $e';
      notifyListeners();
    }
  }
}

/// Lista de avatares disponibles
class AvailableAvatars {
  static const List<Map<String, dynamic>> all = [
    {'name': 'León', 'emoji': '🦁', 'color': 0xFFFF9800},
    {'name': 'Panda', 'emoji': '🐼', 'color': 0xFF424242},
    {'name': 'Unicornio', 'emoji': '🦄', 'color': 0xFFE91E63},
    {'name': 'Delfín', 'emoji': '🐬', 'color': 0xFF2196F3},
    {'name': 'Búho', 'emoji': '🦉', 'color': 0xFF795548},
    {'name': 'Gatito', 'emoji': '🐱', 'color': 0xFF9C27B0},
    {'name': 'Perrito', 'emoji': '🐶', 'color': 0xFFFFC107},
    {'name': 'Conejo', 'emoji': '🐰', 'color': 0xFF9E9E9E},
    {'name': 'Pollito', 'emoji': '🐥', 'color': 0xFFFFEB3B},
    {'name': 'Mariposa', 'emoji': '🦋', 'color': 0xFF00BCD4},
    {'name': 'Abejita', 'emoji': '🐝', 'color': 0xFFFF9800},
    {'name': 'Ranita', 'emoji': '🐸', 'color': 0xFF4CAF50},
  ];
}
