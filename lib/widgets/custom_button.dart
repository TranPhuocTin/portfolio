import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool outline;
  final IconData? icon;
  final double height;
  final double width;
  final Color? color;
  final String? tooltip;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.outline = false,
    this.icon,
    this.height = 45,
    this.width = 150,
    this.color,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonWidget = Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: outline ? Colors.transparent : (color ?? AppColors.secondaryColor),
          foregroundColor: outline ? AppColors.textColor : AppColors.primaryColor,
          side: outline ? BorderSide(color: color ?? AppColors.secondaryColor, width: 1.5) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: outline ? (color ?? AppColors.secondaryColor) : AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
    
    return tooltip != null
        ? Tooltip(
            message: tooltip!,
            child: buttonWidget,
          )
        : buttonWidget;
  }
} 