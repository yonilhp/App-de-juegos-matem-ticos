import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:num_num/shared/widgets/primary_action_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF00d2ff), Color(0xFF3a47d5)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Contenido centrado (scrolleable si es necesario)
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Imagen principal
                        ClipOval(
                          child: Image.asset(
                            'lib/assets/images/IntelliQ.png',
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Título
                        const Text(
                          'Una aventura divertida para aprender',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Botón fijo en la parte inferior
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: PrimaryActionButton(
                    text: '¡Comenzar!',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () => context.go('/profile_setup'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
