import 'package:flutter/material.dart';
import 'package:num_num/app/themes/app_colors.dart';

class PrimaryActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final String? loadingText;

  const PrimaryActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(
      context,
    ).textTheme.headlineSmall?.copyWith(color: AppColors.primary);

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 12),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLoading) ...[
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
            if (loadingText != null) ...[
              const SizedBox(width: 8),
              Text(loadingText!, style: textStyle),
            ],
          ] else ...[
            Text(text, style: textStyle),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 28),
            ],
          ],
        ],
      ),
    );
  }
}
