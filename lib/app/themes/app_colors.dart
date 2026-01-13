import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFFFFFFFF);
  static const Color foreground = Color(0xFF0F172A);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardForeground = Color(0xFF0F172A);
  static const Color popover = Color(0xFFFFFFFF);
  static const Color popoverForeground = Color(0xFF0F172A);

  static const Color primary = Color(0xFF3a47d5);
  static const Color primaryForeground = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFFF1F5F9);
  static const Color secondaryForeground = Color(0xFF1E293B);

  static const Color muted = Color(0xFFF1F5F9);
  static const Color mutedForeground = Color(0xFF64748B);

  static const Color accent = Color(0xFF00BFA5);
  static const Color accentForeground = Color(0xFFFFFFFF);

  static const Color destructive = Color(0xFFDC2626);
  static const Color destructiveForeground = Color(0xFFFFFFFF);

  static const Color border = Color(0xFFE2E8F0);
  static const Color input = Color(0xFFE2E8F0);
  static const Color ring = Color(0xFF006BC3);

  static const Color chart1 = Color(0xFF006BC3);
  static const Color chart2 = Color(0xFF00BFA5);
  static const Color chart3 = Color(0xFF0891B2);
  static const Color chart4 = Color(0xFF3B82F6);
  static const Color chart5 = Color(0xFF06B6D4);

  static const Color sidebar = Color(0xFFFAFAFA);
  static const Color sidebarForeground = Color(0xFF0F172A);
  static const Color sidebarPrimary = Color(0xFF2563EB);
  static const Color sidebarPrimaryForeground = Color(0xFFFFFFFF);
  static const Color sidebarAccent = Color(0xFFF1F5F9);
  static const Color sidebarAccentForeground = Color(0xFF1E293B);
  static const Color sidebarBorder = Color(0xFFE2E8F0);
  static const Color sidebarRing = Color(0xFF006BC3);

  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkForeground = Color(0xFFF8FAFC);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkCardForeground = Color(0xFFF8FAFC);
  static const Color darkPopover = Color(0xFF1E293B);
  static const Color darkPopoverForeground = Color(0xFFF8FAFC);

  static const Color darkPrimary = Color(0xFF3B9EFF);
  static const Color darkPrimaryForeground = Color(0xFF0F172A);

  static const Color darkSecondary = Color(0xFF334155);
  static const Color darkSecondaryForeground = Color(0xFFF8FAFC);

  static const Color darkMuted = Color(0xFF334155);
  static const Color darkMutedForeground = Color(0xFF94A3B8);

  static const Color darkAccent = Color(0xFF26E7CB);
  static const Color darkAccentForeground = Color(0xFF0F172A);

  static const Color darkDestructive = Color(0xFFEF4444);
  static const Color darkDestructiveForeground = Color(0xFF0F172A);

  static const Color darkBorder = Color(0xFF334155);
  static const Color darkInput = Color(0xFF334155);
  static const Color darkRing = Color(0xFF3B9EFF);

  static const Color darkChart1 = Color(0xFF3B9EFF);
  static const Color darkChart2 = Color(0xFF26E7CB);
  static const Color darkChart3 = Color(0xFF22D3EE);
  static const Color darkChart4 = Color(0xFF60A5FA);
  static const Color darkChart5 = Color(0xFF06B6D4);

  static const Color darkSidebar = Color(0xFF1E293B);
  static const Color darkSidebarForeground = Color(0xFFF8FAFC);
  static const Color darkSidebarPrimary = Color(0xFF3B9EFF);
  static const Color darkSidebarPrimaryForeground = Color(0xFF0F172A);
  static const Color darkSidebarAccent = Color(0xFF334155);
  static const Color darkSidebarAccentForeground = Color(0xFFF8FAFC);
  static const Color darkSidebarBorder = Color(0xFF334155);
  static const Color darkSidebarRing = Color(0xFF3B9EFF);

  static const Color grey50 = Color(0xFFF8FAFC);
  static const Color grey100 = Color(0xFFF1F5F9);
  static const Color grey200 = Color(0xFFE2E8F0);
  static const Color grey300 = Color(0xFFCBD5E1);
  static const Color grey400 = Color(0xFF94A3B8);
  static const Color grey500 = Color(0xFF64748B);
  static const Color grey600 = Color(0xFF475569);
  static const Color grey700 = Color(0xFF334155);
  static const Color grey800 = Color(0xFF1E293B);
  static const Color grey900 = Color(0xFF0F172A);

  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);

  static const Color error = destructive;
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFB91C1C);

  static const Color info = primary;
  static const Color infoLight = Color(0xFF3B9EFF);
  static const Color infoDark = Color(0xFF0056A3);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color textPrimary = foreground;
  static const Color textSecondary = mutedForeground;
  static const Color textDisabled = Color(0xFF94A3B8);

  static const Color surface = card;
  static const Color surfaceVariant = secondary;

  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0D000000);
  static const Color shadowDark = Color(0x26000000);

  static const Color progress = Color(0xFF22C55E);
  static const Color progressLight = Color(0xFF4ADE80);
  static const Color progressDark = Color(0xFF16A34A);

  static const MaterialColor primarySwatch =
      MaterialColor(0xFF006BC3, <int, Color>{
        50: Color(0xFFE0F2FE),
        100: Color(0xFFBAE6FD),
        200: Color(0xFF7DD3FC),
        300: Color(0xFF38BDF8),
        400: Color(0xFF0EA5E9),
        500: Color(0xFF006BC3),
        600: Color(0xFF0056A3),
        700: Color(0xFF004182),
        800: Color(0xFF002C62),
        900: Color(0xFF001742),
      });

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF006BC3), Color(0xFF0056A3)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00BFA5), Color(0xFF009688)],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF34D399), Color(0xFF10B981)],
  );

  static const LinearGradient warningGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
  );

  static const LinearGradient errorGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF87171), Color(0xFFEF4444)],
  );

  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 10.0;
  static const double radiusXl = 14.0;
}
