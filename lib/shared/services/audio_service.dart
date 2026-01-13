import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

/// Servicio para manejar los sonidos de la aplicación
class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _successPlayer = AudioPlayer();
  final AudioPlayer _errorPlayer = AudioPlayer();

  /// Reproducir sonido de éxito (respuesta correcta)
  Future<void> playSuccess() async {
    final bytes = await rootBundle.load('lib/assets/audio/Success.mp3');
    await _successPlayer.stop();
    await _successPlayer.play(BytesSource(bytes.buffer.asUint8List()));
  }

  /// Reproducir sonido de error (respuesta incorrecta)
  Future<void> playError() async {
    final bytes = await rootBundle.load('lib/assets/audio/Error.mp3');
    await _errorPlayer.stop();
    await _errorPlayer.play(BytesSource(bytes.buffer.asUint8List()));
  }

  /// Liberar recursos
  void dispose() {
    _successPlayer.dispose();
    _errorPlayer.dispose();
  }
}
