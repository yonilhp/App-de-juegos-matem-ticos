import 'package:flutter/material.dart';
import 'package:num_num/app/routes/app_routes.dart';
import 'package:num_num/app/themes/app_theme.dart';
import 'package:num_num/features/profile_setup/presentation/providers/profile_provider.dart';
import 'package:num_num/features/math_game/presentation/providers/category_provider.dart';
import 'package:num_num/features/math_game/presentation/providers/game_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => GameProvider()),
      ],
      child: MaterialApp.router(
        title: 'NumNum - Aprende Jugando',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: router,
      ),
    );
  }
}
