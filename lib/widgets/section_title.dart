import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool centerTitle;
  final bool showLine;

  const SectionTitle({
    Key? key,
    required this.title,
    this.subtitle,
    this.centerTitle = false,
    this.showLine = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: centerTitle ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              if (showLine) ...[
                const SizedBox(width: 10),
                Container(
                  height: 1,
                  width: 100,
                  color: AppColors.secondaryColor,
                  margin: const EdgeInsets.only(top: 5),
                ),
              ],
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 10),
            Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.subTextColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
} 