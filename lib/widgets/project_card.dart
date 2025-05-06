import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_colors.dart';
import 'package:portfolio/utils/url_launcher_helper.dart';
import 'package:portfolio/utils/image_placeholder.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> technologies;
  final String github;
  final String live;
  final String image;

  const ProjectCard({
    Key? key,
    required this.title,
    required this.description,
    required this.technologies,
    required this.github,
    required this.live,
    required this.image,
  }) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: isHovered
            ? (Matrix4.identity()..translate(0, -10))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: AppColors.highlightColor.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ]
              : [],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image
            SizedBox(
              height: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ImagePlaceholder.buildProjectImage(widget.title),
              ),
            ),
            const SizedBox(height: 20),
            
            // Project Title
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 10),
            
            // Project Description
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.subTextColor,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            
            // Technologies Used
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.technologies.map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.secondaryColor, width: 1),
                  ),
                  child: Text(
                    tech,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => UrlLauncherHelper.launchURL(widget.github),
                  icon: const Icon(
                    Icons.code,
                    color: AppColors.secondaryColor,
                    size: 20,
                  ),
                  tooltip: 'View Code',
                ),
                IconButton(
                  onPressed: () => UrlLauncherHelper.launchURL(widget.live),
                  icon: const Icon(
                    Icons.launch,
                    color: AppColors.secondaryColor,
                    size: 20,
                  ),
                  tooltip: 'View Live',
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
} 