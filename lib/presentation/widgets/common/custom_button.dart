import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/dimensions.dart';

enum ButtonType { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = height ?? AppDimensions.buttonHeight;
    final buttonWidth = width ?? double.infinity;

    Widget buttonChild = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.textLight),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: AppDimensions.paddingS),
              ],
              Text(text),
            ],
          );

    switch (type) {
      case ButtonType.primary:
        return SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            child: buttonChild,
          ),
        );

      case ButtonType.secondary:
        return SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.textLight,
            ),
            child: buttonChild,
          ),
        );

      case ButtonType.outline:
        return SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            child: buttonChild,
          ),
        );

      case ButtonType.text:
        return SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: TextButton(
            onPressed: isLoading ? null : onPressed,
            child: buttonChild,
          ),
        );
    }
  }
} 