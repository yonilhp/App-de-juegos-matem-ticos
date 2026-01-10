import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:num_num/features/profile_setup/domain/entities/category.dart';
import 'package:num_num/features/profile_setup/presentation/providers/profile_provider.dart';
import 'package:num_num/features/math_game/presentation/providers/category_provider.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final categoryProvider = context.watch<CategoryProvider>();
    final profile = profileProvider.profile;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF3a47d5), Color(0xFF00d2ff)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header con perfil
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Text(
                        profile?.avatar ?? '🎓',
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Nombre y saludo
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '¡Hola, ${profile?.firstName ?? 'Amigo'}!',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            '¿Qué quieres aprender hoy?',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Puntaje
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Text('⭐', style: TextStyle(fontSize: 20)),
                          const SizedBox(width: 4),
                          Text(
                            '${categoryProvider.progress?.totalScore ?? 0}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Título de sección
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      '📚 Categorías',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Grid de categorías
              Expanded(
                child: categoryProvider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.9,
                            ),
                        itemCount: categoryProvider.categories.length,
                        itemBuilder: (context, index) {
                          final category = categoryProvider.categories[index];
                          final status = categoryProvider.getCategoryStatus(
                            category.id,
                          );
                          return _CategoryCard(
                            category: category,
                            status: status,
                            onTap: () {
                              if (categoryProvider.canPlay(category.id)) {
                                context.go('/game/${category.id}');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '🔒 Completa ${_getPreviousCategoryName(category.order)} primero',
                                    ),
                                    backgroundColor: Colors.orange,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPreviousCategoryName(int order) {
    final previous = AppCategories.getByOrder(order - 1);
    return previous?.name ?? 'la categoría anterior';
  }
}

class _CategoryCard extends StatelessWidget {
  final Category category;
  final CategoryStatus status;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLocked = status == CategoryStatus.locked;
    final isCompleted = status == CategoryStatus.completed;
    final color = Color(int.parse(category.color.replaceFirst('#', '0xFF')));

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isLocked ? Colors.grey[300] : Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: isLocked
                  ? Colors.black.withOpacity(0.05)
                  : color.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Contenido principal
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Emoji
                  Text(
                    isLocked ? '🔒' : category.emoji,
                    style: TextStyle(fontSize: isLocked ? 40 : 50),
                  ),
                  const SizedBox(height: 12),
                  // Nombre
                  Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isLocked ? Colors.grey : Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Estado
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _getStatusText(status),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(status),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Badge de completado
            if (isCompleted)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(CategoryStatus status) {
    switch (status) {
      case CategoryStatus.locked:
        return Colors.grey;
      case CategoryStatus.active:
        return Colors.blue;
      case CategoryStatus.completed:
        return Colors.green;
    }
  }

  String _getStatusText(CategoryStatus status) {
    switch (status) {
      case CategoryStatus.locked:
        return 'Bloqueado';
      case CategoryStatus.active:
        return '¡Jugar!';
      case CategoryStatus.completed:
        return 'Completado';
    }
  }
}
