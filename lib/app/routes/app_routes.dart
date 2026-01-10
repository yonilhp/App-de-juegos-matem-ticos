import 'package:go_router/go_router.dart';
import 'package:num_num/features/profile_setup/presentation/pages/splash_page.dart';
import 'package:num_num/features/profile_setup/presentation/pages/welcome_page.dart';
import 'package:num_num/features/profile_setup/presentation/pages/profile_setup_page.dart';
import 'package:num_num/features/math_game/presentation/pages/categories_page.dart';
import 'package:num_num/features/math_game/presentation/pages/game_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),
    GoRoute(path: '/welcome', builder: (context, state) => const WelcomePage()),
    GoRoute(
      path: '/profile_setup',
      builder: (context, state) => const ProfileSetupPage(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoriesPage(),
    ),
    GoRoute(
      path: '/game/:categoryId',
      builder: (context, state) {
        final categoryId = state.pathParameters['categoryId']!;
        return GamePage(categoryId: categoryId);
      },
    ),
  ],
);
