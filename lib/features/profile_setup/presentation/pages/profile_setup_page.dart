import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:num_num/features/profile_setup/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:num_num/features/profile_setup/presentation/providers/profile_provider.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? _selectedAvatar;
  bool _isLoading = false;
  int _currentStep = 0; // 0: nombre, 1: avatar

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (_firstNameController.text.trim().isEmpty) {
      _showMessage('¡Escribe tu nombre! 📝');
      return;
    }

    if (_selectedAvatar == null) {
      _showMessage('¡Elige tu animalito favorito! 🐾');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final profileProvider = context.read<ProfileProvider>();
      final success = await profileProvider.createProfile(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        avatar: _selectedAvatar!,
      );

      if (success && mounted) {
        context.go('/categories');
      } else if (mounted) {
        _showMessage('Error al guardar. Intenta de nuevo.');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _nextStep() {
    if (_currentStep == 0) {
      if (_firstNameController.text.trim().isEmpty) {
        _showMessage('¡Escribe tu nombre! 📝');
        return;
      }
      setState(() => _currentStep = 1);
    } else {
      _saveProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Indicador de progreso
                Row(
                  children: [
                    _buildStepIndicator(0, '📝'),
                    Expanded(
                      child: Container(
                        height: 3,
                        color: _currentStep >= 1
                            ? Colors.white
                            : Colors.white38,
                      ),
                    ),
                    _buildStepIndicator(1, '🐾'),
                  ],
                ),

                const SizedBox(height: 40),

                // Contenido según el paso
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _currentStep == 0
                      ? _buildNameStep()
                      : _buildAvatarStep(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int step, String emoji) {
    final isActive = _currentStep >= step;
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white38,
        shape: BoxShape.circle,
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(emoji, style: TextStyle(fontSize: isActive ? 24 : 20)),
      ),
    );
  }

  Widget _buildNameStep() {
    return Column(
      key: const ValueKey('name'),
      children: [
        const Text(
          '¿Cómo te llamas?',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Escribe tu nombre para comenzar',
          style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8)),
        ),
        const SizedBox(height: 40),

        // Campo de nombre
        CustomTextField(
          controller: _firstNameController,
          hint: 'Tu nombre',
          icon: Icons.person_outline,
        ),

        const SizedBox(height: 16),

        // Campo de apellido (opcional)
        CustomTextField(
          controller: _lastNameController,
          hint: 'Tu apellido (opcional)',
          icon: Icons.family_restroom,
        ),

        const SizedBox(height: 40),

        _buildNextButton('Siguiente', Icons.arrow_forward_rounded),
      ],
    );
  }

  Widget _buildAvatarStep() {
    return Column(
      key: const ValueKey('avatar'),
      children: [
        const Text(
          '¡Elige tu mascota!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Este animalito te acompañará',
          style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8)),
        ),
        const SizedBox(height: 30),

        // Grid de avatares
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: AvailableAvatars.all.length,
            itemBuilder: (context, index) {
              final avatar = AvailableAvatars.all[index];
              final isSelected = _selectedAvatar == avatar['emoji'];

              return GestureDetector(
                onTap: () {
                  setState(() => _selectedAvatar = avatar['emoji'] as String);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color(avatar['color'] as int).withOpacity(0.2)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isSelected
                          ? Color(avatar['color'] as int)
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      avatar['emoji'] as String,
                      style: TextStyle(fontSize: isSelected ? 35 : 28),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 30),

        // Botón de atrás y continuar
        Row(
          children: [
            TextButton.icon(
              onPressed: () => setState(() => _currentStep = 0),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              label: const Text(
                'Atrás',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: _buildNextButton(
                _isLoading ? 'Guardando...' : 'A jugar!',
                Icons.play_arrow_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNextButton(String text, IconData icon) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _nextStep,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF3a47d5),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isLoading)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else ...[
            Text(
              text,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            Icon(icon),
          ],
        ],
      ),
    );
  }
}
