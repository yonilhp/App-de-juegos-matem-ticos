import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:num_num/features/profile_setup/domain/entities/category.dart';
import 'package:num_num/features/profile_setup/domain/entities/progress.dart';

/// Provider para manejar las categorías y el progreso
class CategoryProvider extends ChangeNotifier {
  static const String _progressKey = 'child_progress';

  List<Category> _categories = [];
  Map<String, CategoryStatus> _categoryStatuses = {};
  ChildProgress? _progress;
  bool _isLoading = true;

  List<Category> get categories => _categories;
  Map<String, CategoryStatus> get categoryStatuses => _categoryStatuses;
  ChildProgress? get progress => _progress;
  bool get isLoading => _isLoading;

  CategoryProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    _isLoading = true;
    notifyListeners();

    // Cargar categorías predefinidas
    _categories = AppCategories.all;

    // Cargar progreso guardado
    await _loadProgress();

    // Calcular estados de categorías
    _updateCategoryStatuses();

    _isLoading = false;
    notifyListeners();
  }

  /// Cargar progreso desde SharedPreferences
  Future<void> _loadProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final progressJson = prefs.getString(_progressKey);

      if (progressJson != null) {
        final Map<String, dynamic> data = jsonDecode(progressJson);
        _progress = ChildProgress.fromJson(data);
      } else {
        // Crear progreso inicial vacío
        _progress = ChildProgress(
          childId: '',
          categories: {},
          lastPlayedAt: DateTime.now(),
        );
      }
    } catch (e) {
      debugPrint('Error loading progress: $e');
      _progress = ChildProgress(
        childId: '',
        categories: {},
        lastPlayedAt: DateTime.now(),
      );
    }
  }

  /// Guardar progreso
  Future<void> _saveProgress() async {
    if (_progress == null) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_progressKey, jsonEncode(_progress!.toJson()));
    } catch (e) {
      debugPrint('Error saving progress: $e');
    }
  }

  /// Actualizar estados de las categorías basado en el progreso
  void _updateCategoryStatuses() {
    _categoryStatuses = {};

    for (var category in _categories) {
      final categoryProgress = _progress?.getProgress(category.id);

      if (categoryProgress != null && categoryProgress.isCompleted) {
        // Categoría completada
        _categoryStatuses[category.id] = CategoryStatus.completed;
      } else if (_shouldBeActive(category)) {
        // Categoría activa
        _categoryStatuses[category.id] = CategoryStatus.active;
      } else {
        // Categoría bloqueada
        _categoryStatuses[category.id] = CategoryStatus.locked;
      }
    }
  }

  /// Determinar si una categoría debe estar activa
  bool _shouldBeActive(Category category) {
    // La primera categoría siempre está activa si no está completada
    if (category.order == 1) return true;

    // Las demás categorías se activan cuando la anterior está completada
    final previousCategory = AppCategories.getByOrder(category.order - 1);
    if (previousCategory == null) return false;

    return _progress?.isCategoryCompleted(previousCategory.id) ?? false;
  }

  /// Obtener el estado de una categoría
  CategoryStatus getCategoryStatus(String categoryId) {
    return _categoryStatuses[categoryId] ?? CategoryStatus.locked;
  }

  /// Verificar si una categoría está disponible para jugar
  bool canPlay(String categoryId) {
    final status = getCategoryStatus(categoryId);
    return status == CategoryStatus.active ||
        status == CategoryStatus.completed;
  }

  /// Marcar una categoría como completada y desbloquear la siguiente
  Future<void> completeCategory(String categoryId) async {
    if (_progress == null) return;

    final updatedCategories = Map<String, CategoryProgress>.from(
      _progress!.categories,
    );
    final currentProgress =
        updatedCategories[categoryId] ??
        CategoryProgress(categoryId: categoryId);

    updatedCategories[categoryId] = currentProgress.copyWith(
      isCompleted: true,
      completedAt: DateTime.now(),
    );

    _progress = _progress!.copyWith(
      categories: updatedCategories,
      lastPlayedAt: DateTime.now(),
    );

    await _saveProgress();
    _updateCategoryStatuses();
    notifyListeners();
  }

  /// Actualizar progreso de una categoría (después de responder una pregunta)
  Future<void> updateCategoryProgress({
    required String categoryId,
    required bool isCorrect,
    required int totalQuestionsRequired,
  }) async {
    if (_progress == null) return;

    final updatedCategories = Map<String, CategoryProgress>.from(
      _progress!.categories,
    );
    final currentProgress =
        updatedCategories[categoryId] ??
        CategoryProgress(categoryId: categoryId);

    final newQuestionsAnswered = currentProgress.questionsAnswered + 1;
    final newCorrectAnswers =
        currentProgress.correctAnswers + (isCorrect ? 1 : 0);
    final newWrongAnswers = currentProgress.wrongAnswers + (isCorrect ? 0 : 1);
    final isNowCompleted = newQuestionsAnswered >= totalQuestionsRequired;

    updatedCategories[categoryId] = currentProgress.copyWith(
      questionsAnswered: newQuestionsAnswered,
      correctAnswers: newCorrectAnswers,
      wrongAnswers: newWrongAnswers,
      isCompleted: isNowCompleted,
      completedAt: isNowCompleted ? DateTime.now() : null,
    );

    _progress = _progress!.copyWith(
      categories: updatedCategories,
      totalScore: _progress!.totalScore + (isCorrect ? 10 : 0),
      lastPlayedAt: DateTime.now(),
    );

    await _saveProgress();
    _updateCategoryStatuses();
    notifyListeners();
  }

  /// Reiniciar todo el progreso
  Future<void> resetProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_progressKey);

      _progress = ChildProgress(
        childId: '',
        categories: {},
        lastPlayedAt: DateTime.now(),
      );

      _updateCategoryStatuses();
      notifyListeners();
    } catch (e) {
      debugPrint('Error resetting progress: $e');
    }
  }
}
