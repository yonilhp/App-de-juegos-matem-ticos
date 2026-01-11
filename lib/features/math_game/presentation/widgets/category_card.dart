import 'package:flutter/material.dart';
import 'package:num_num/features/math_game/domain/entities/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final CategoryStatus status;
  final VoidCallback onTap;
  const CategoryCard({
    super.key,
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
                  ? Colors.black.withValues(alpha: 0.05)
                  : color.withValues(alpha: 0.3),
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
