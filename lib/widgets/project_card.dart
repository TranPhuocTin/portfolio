import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_colors.dart';
import 'package:portfolio/utils/url_launcher_helper.dart';
import 'package:portfolio/utils/image_placeholder.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> technologies;
  final String github;
  final String live;
  final String image;
  final VoidCallback? onTap;

  const ProjectCard({
    Key? key,
    required this.title,
    required this.description,
    required this.technologies,
    required this.github,
    required this.live,
    required this.image,
    this.onTap,
  }) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    _rotateAnimation = Tween<double>(begin: 0, end: 0.01).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => isHovered = false);
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // Perspective
                ..rotateX(_rotateAnimation.value)
                ..translate(0.0, isHovered ? -10.0 : 0.0),
              alignment: Alignment.center,
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(10),
                splashColor: AppColors.secondaryColor.withOpacity(0.1),
                hoverColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: isHovered
                            ? AppColors.secondaryColor.withOpacity(0.3)
                            : AppColors.primaryColor.withOpacity(0.1),
                        blurRadius: isHovered ? 20 : 10,
                        offset: Offset(0, isHovered ? 10 : 5),
                        spreadRadius: isHovered ? 2 : 0,
                      ),
                    ],
                    border: Border.all(
                      color: isHovered
                          ? AppColors.secondaryColor.withOpacity(0.5)
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project Image with hover effect
                      Stack(
                        children: [
                          SizedBox(
                            height: 160,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Hero(
                                tag: 'project-${widget.title}',
                                child: ImagePlaceholder.buildProjectImage(widget.title),
                              ),
                            ),
                          ),
                          if (isHovered)
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.secondaryColor.withOpacity(0.2),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.code, color: Colors.white, size: 28),
                                        onPressed: () => UrlLauncherHelper.launchURL(widget.github),
                                      ),
                                      const SizedBox(width: 20),
                                      IconButton(
                                        icon: const Icon(Icons.launch, color: Colors.white, size: 28),
                                        onPressed: () => UrlLauncherHelper.launchURL(widget.live),
                                      ),
                                    ],
                                  ).animate().scale(),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Project Title
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isHovered ? AppColors.secondaryColor : AppColors.textColor,
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
                              border: Border.all(
                                color: isHovered 
                                  ? AppColors.secondaryColor 
                                  : AppColors.secondaryColor.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              tech,
                              style: TextStyle(
                                fontSize: 12,
                                color: isHovered 
                                  ? AppColors.secondaryColor 
                                  : AppColors.secondaryColor.withOpacity(0.8),
                                fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 