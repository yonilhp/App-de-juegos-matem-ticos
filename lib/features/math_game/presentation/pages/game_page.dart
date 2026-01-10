import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:num_num/features/profile_setup/domain/entities/category.dart';
import 'package:num_num/features/math_game/presentation/providers/game_provider.dart';
import 'package:num_num/features/math_game/presentation/providers/category_provider.dart';

class GamePage extends StatefulWidget {
  final String categoryId;

  const GamePage({super.key, required this.categoryId});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().startGame(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();
    final category = AppCategories.getById(widget.categoryId);
    final color = Color(
      int.parse(category?.color.replaceFirst('#', '0xFF') ?? '0xFF2196F3'),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color, color.withOpacity(0.7)],
          ),
        ),
        child: SafeArea(
          child: gameProvider.state == GameState.completed
              ? _buildCompletedScreen(gameProvider, color)
              : _buildGameScreen(gameProvider, category, color),
        ),
      ),
    );
  }

  Widget _buildGameScreen(
    GameProvider gameProvider,
    Category? category,
    Color color,
  ) {
    final question = gameProvider.currentQuestion;

    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Botón de regreso
              IconButton(
                onPressed: () {
                  gameProvider.resetGame();
                  context.go('/categories');
                },
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 8),
              // Nombre de categoría
              Text(
                category?.name ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              // Contador de preguntas
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${gameProvider.currentQuestionIndex + 1}/${gameProvider.questions.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Barra de progreso
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: gameProvider.progressPercent,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 8,
            ),
          ),
        ),

        const SizedBox(height: 30),

        // Imagen de la pregunta
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: question != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Placeholder de imagen (después vendrán de Firebase)
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            _getEmojiForAnswer(question.correctAnswer),
                            style: const TextStyle(fontSize: 80),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '¿Qué es esto?',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Feedback de respuesta
        if (gameProvider.state == GameState.correct ||
            gameProvider.state == GameState.wrong)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: gameProvider.state == GameState.correct
                  ? Colors.green
                  : Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  gameProvider.state == GameState.correct
                      ? Icons.check_circle
                      : Icons.cancel,
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Text(
                  gameProvider.state == GameState.correct
                      ? '¡Correcto! 🎉'
                      : '¡Inténtalo de nuevo!',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 20),

        // Opciones de respuesta
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: question != null
                ? Column(
                    children: question.options.map((option) {
                      return Expanded(
                        child: _buildOptionButton(
                          option: option,
                          gameProvider: gameProvider,
                          color: color,
                        ),
                      );
                    }).toList(),
                  )
                : const SizedBox(),
          ),
        ),

        // Botón de siguiente (solo si ya respondió)
        if (gameProvider.state == GameState.correct)
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  gameProvider.nextQuestion();
                  _checkCompletion(gameProvider);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: color,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Siguiente →',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

        if (gameProvider.state == GameState.wrong)
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => gameProvider.retryQuestion(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Intentar de nuevo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildOptionButton({
    required String option,
    required GameProvider gameProvider,
    required Color color,
  }) {
    final isSelected = gameProvider.selectedAnswer == option;
    final isCorrect = option == gameProvider.currentQuestion?.correctAnswer;
    final showResult =
        gameProvider.state == GameState.correct ||
        gameProvider.state == GameState.wrong;

    Color buttonColor = Colors.white;
    Color textColor = Colors.black87;

    if (showResult && isSelected) {
      buttonColor = isCorrect ? Colors.green : Colors.red;
      textColor = Colors.white;
    } else if (showResult && isCorrect) {
      buttonColor = Colors.green.withOpacity(0.5);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: gameProvider.state == GameState.playing
              ? () => gameProvider.selectAnswer(option)
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: textColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected ? color : Colors.transparent,
                width: 3,
              ),
            ),
            elevation: isSelected ? 8 : 2,
          ),
          child: Text(
            option,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedScreen(GameProvider gameProvider, Color color) {
    final result = gameProvider.getResult();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(result.emoji, style: const TextStyle(fontSize: 100)),
            const SizedBox(height: 20),
            Text(
              result.message,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Estadísticas
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  _buildStatRow(
                    '✅ Correctas',
                    '${result.correctAnswers}',
                    Colors.green,
                  ),
                  const SizedBox(height: 12),
                  _buildStatRow(
                    '❌ Incorrectas',
                    '${result.wrongAnswers}',
                    Colors.red,
                  ),
                  const SizedBox(height: 12),
                  _buildStatRow(
                    '📊 Precisión',
                    '${result.accuracy.toStringAsFixed(0)}%',
                    color,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Botones
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Actualizar progreso
                  final categoryProvider = context.read<CategoryProvider>();
                  await categoryProvider.completeCategory(widget.categoryId);

                  if (mounted) {
                    gameProvider.resetGame();
                    context.go('/categories');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: color,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  '¡Continuar! 🚀',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextButton(
              onPressed: () => gameProvider.restartGame(),
              child: const Text(
                'Jugar de nuevo',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, color: Colors.black54),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  void _checkCompletion(GameProvider gameProvider) {
    if (gameProvider.state == GameState.completed) {
      // El juego ya se completó, la UI se actualizará automáticamente
    }
  }

  // Emoji temporal para las respuestas (después vendrán imágenes reales)
  String _getEmojiForAnswer(String answer) {
    final emojis = {
      // Animales
      'Perro': '🐕', 'Gato': '🐱', 'León': '🦁', 'Elefante': '🐘',
      'Pájaro': '🐦', 'Pez': '🐟', 'Conejo': '🐰', 'Oso': '🐻',
      'Mono': '🐵', 'Tortuga': '🐢',
      // Frutas
      'Manzana': '🍎', 'Plátano': '🍌', 'Naranja': '🍊', 'Fresa': '🍓',
      'Uva': '🍇', 'Sandía': '🍉', 'Pera': '🍐', 'Cereza': '🍒',
      'Piña': '🍍', 'Durazno': '🍑',
      // Colores
      'Rojo': '🔴', 'Azul': '🔵', 'Amarillo': '🟡', 'Verde': '🟢',
      'Morado': '🟣', 'Anaranjado': '🟠', 'Rosa': '💗', 'Café': '🟤',
      'Negro': '⚫', 'Blanco': '⚪',
      // Figuras
      'Círculo': '⭕', 'Cuadrado': '⬜', 'Triángulo': '🔺', 'Rectángulo': '▬',
      'Estrella': '⭐', 'Corazón': '❤️', 'Rombo': '🔷', 'Óvalo': '🥚',
      'Pentágono': '⬠', 'Hexágono': '⬡',
    };
    return emojis[answer] ?? '❓';
  }
}
