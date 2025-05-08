import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_colors.dart';
import 'package:portfolio/constants/app_constants.dart';
import 'package:portfolio/utils/image_placeholder.dart';
import 'package:portfolio/utils/url_launcher_helper.dart';
import 'package:portfolio/widgets/custom_button.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utils/responsive_helper.dart';
import 'package:portfolio/utils/pattern_painter.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

class ProjectDetailScreen extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectDetailScreen({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // Header với ảnh và tiêu đề (SliverAppBar)
         
          // Main content
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 40 : 24, 
                    vertical: isDesktop ? 50 : 32
                  ),
                  child: isDesktop
                      ? _buildDesktopLayout(context)
                      : _buildMobileLayout(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Desktop layout with two columns
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column (2/3 width)
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project description
                _buildSectionTitle('Project Description', Icons.description)
                    .animate()
                    .fadeIn(delay: 100.ms),
                const SizedBox(height: 16),
                _buildSectionContent(project['description'])
                    .animate()
                    .fadeIn(delay: 200.ms),
                const SizedBox(height: 40),
                
                // Project goals
                _buildSectionTitle('Project Goals', Icons.flag)
                    .animate()
                    .fadeIn(delay: 300.ms),
                const SizedBox(height: 16),
                ..._buildProjectGoals(project)
                    .animate(interval: 100.ms, delay: 400.ms)
                    .fadeIn()
                    .slideX(begin: 0.1, end: 0),
                const SizedBox(height: 40),
                
                // Features
                _buildSectionTitle('Main Features', Icons.star)
                    .animate()
                    .fadeIn(delay: 500.ms),
                const SizedBox(height: 16),
                ..._buildProjectFeatures(project)
                    .animate(interval: 100.ms, delay: 600.ms)
                    .fadeIn()
                    .slideX(begin: 0.1, end: 0),
                const SizedBox(height: 40),
                
                // Screenshots
                _buildSectionTitle('Screenshots', Icons.image)
                    .animate()
                    .fadeIn(delay: 700.ms),
                const SizedBox(height: 24),
                _buildScreenshotsGrid(context)
                    .animate(delay: 800.ms)
                    .fadeIn(),
              ],
            ),
          ),
        ),
        
        // Right column (1/3 width)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Technologies
              _buildSectionTitle('Technologies Used', Icons.code)
                  .animate()
                  .fadeIn(delay: 700.ms),
              const SizedBox(height: 16),
              _buildTechnologies(project)
                  .animate(delay: 800.ms)
                  .fadeIn(),
              const SizedBox(height: 40),
              
              // Download section
              if (project['apk_download'] != null) ...[
                _buildDownloadSection(project)
                    .animate(delay: 900.ms)
                    .fadeIn()
                    .scale(),
              ],
              
              // Screenshots or additional info could go here
              const SizedBox(height: 40),
              _buildQuickLinks(project, context)
                  .animate(delay: 1000.ms)
                  .fadeIn(),
            ],
          ),
        ),
      ],
    );
  }

  // Mobile layout with single column
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Project description
        _buildSectionTitle('Project Description', Icons.description)
            .animate()
            .fadeIn(delay: 100.ms),
        const SizedBox(height: 16),
        _buildSectionContent(project['description'])
            .animate()
            .fadeIn(delay: 200.ms),
        const SizedBox(height: 32),
        
        // Project goals
        _buildSectionTitle('Project Goals', Icons.flag)
            .animate()
            .fadeIn(delay: 300.ms),
        const SizedBox(height: 16),
        ..._buildProjectGoals(project)
            .animate(interval: 100.ms, delay: 400.ms)
            .fadeIn()
            .slideX(begin: 0.1, end: 0),
        const SizedBox(height: 32),
        
        // Technologies
        _buildSectionTitle('Technologies Used', Icons.code)
            .animate()
            .fadeIn(delay: 600.ms),
        const SizedBox(height: 16),
        _buildTechnologies(project)
            .animate(delay: 700.ms)
            .fadeIn(),
        const SizedBox(height: 32),
        
        // Features
        _buildSectionTitle('Main Features', Icons.star)
            .animate()
            .fadeIn(delay: 800.ms),
        const SizedBox(height: 16),
        ..._buildProjectFeatures(project)
            .animate(interval: 100.ms, delay: 900.ms)
            .fadeIn()
            .slideX(begin: 0.1, end: 0),
        const SizedBox(height: 32),
        
        // Screenshots
        _buildSectionTitle('Screenshots', Icons.image)
            .animate()
            .fadeIn(delay: 1000.ms),
        const SizedBox(height: 16),
        _buildScreenshotsGrid(context)
            .animate(delay: 1100.ms)
            .fadeIn(),
        const SizedBox(height: 32),
        
        // Download section
        if (project['apk_download'] != null) ...[
          _buildDownloadSection(project)
              .animate(delay: 1200.ms)
              .fadeIn()
              .scale(),
          const SizedBox(height: 32),
        ],
      ],
    );
  }
  
  // Screenshots section
  Widget _buildScreenshotsGrid(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    
    // Lấy dữ liệu screenshots từ project
    final List<Map<String, dynamic>> screenshotSections = 
        (project['screenshots'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];
    
    // Nếu không có dữ liệu screenshots, hiển thị thông báo
    if (screenshotSections.isEmpty) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.secondaryColor.withOpacity(0.2)),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.photo_library_outlined,
              color: AppColors.secondaryColor,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'No screenshots available for this project',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Please add images to the assets/images/projects folder and update in app_constants.dart',
              style: TextStyle(
                color: AppColors.subTextColor,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    
    // Calculate number of columns based on screen width
    final crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: screenshotSections.length,
      itemBuilder: (context, index) {
        final section = screenshotSections[index];
        return _buildSectionItem(
          context: context,
          title: section['section'] as String,
          description: section['description'] as String,
          icon: section['icon'] as String,
          images: section['images'] as List<Map<String, dynamic>>,
          index: index,
        );
      },
    );
  }
  
  // Section item thể hiện phần ảnh đại diện và số lượng ảnh
  Widget _buildSectionItem({
    required BuildContext context, 
    required String title, 
    required String description,
    required String icon,
    required List<Map<String, dynamic>> images,
    required int index,
  }) {
    // Create image widget based on whether we have a path or color
    Widget imageWidget;
    if (images.first.containsKey('path')) {
      final String imagePath = images.first['path'] as String;
      imageWidget = Image.asset(
        imagePath,
        fit: BoxFit.cover,
      );
    } else {
      final int colorValue = images.first['color'] as int;
      final Color color = Color(colorValue);
      imageWidget = Container(
        color: color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getIconData(icon),
                size: 32,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
    
    return InkWell(
      onTap: () => _showImageGallery(context, title, images, icon),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image placeholder area - replace with actual image
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  imageWidget,
                  
                  // Badge hiển thị số lượng ảnh
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.photo_library,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${images.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Nút xem chi tiết
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.black38,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.fullscreen,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Screenshot info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.subTextColor,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Hiển thị gallery ảnh cho từng section
  void _showImageGallery(
    BuildContext context,
    String title, 
    List<Map<String, dynamic>> images,
    String icon,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.backgroundColor,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              // Title bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Icon(_getIconData(icon), color: AppColors.secondaryColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.textColor),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.cardColor),
              
              // Thumbnails grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final image = images[index];
                      final caption = image['caption'] as String;
                      
                      // Determine if we should use a real image path or a color
                      Widget imageWidget;
                      if (image.containsKey('path')) {
                        final String imagePath = image['path'] as String;
                        imageWidget = Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        );
                      } else {
                        final int colorValue = image['color'] as int;
                        final Color color = Color(colorValue);
                        imageWidget = Container(
                          color: color,
                          child: Center(
                            child: Icon(
                              _getIconData(icon),
                              size: 16, // Thu nhỏ icon
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                      
                      return Tooltip(
                        message: caption,
                        child: InkWell(
                          onTap: () => _showFullScreenImage(context, images, index),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                imageWidget,
                                // Hiển thị tooltip thay vì caption cố định
                                Positioned(
                                  right: 3,
                                  bottom: 3,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Icon(
                                      Icons.fullscreen,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  // Show full-screen image viewer
  void _showFullScreenImage(
    BuildContext context,
    List<Map<String, dynamic>> images,
    int initialIndex,
  ) {
    final PageController pageController = PageController(initialPage: initialIndex);
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Black background
                  Container(color: Colors.black),
                  
                  // Image PageView
                  PageView.builder(
                    controller: pageController,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final image = images[index];
                      final caption = image['caption'] as String;
                      
                      Widget imageWidget;
                      if (image.containsKey('path')) {
                        final String imagePath = image['path'] as String;
                        imageWidget = InteractiveViewer(
                          minScale: 0.5,
                          maxScale: 4.0,
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.contain,
                          ),
                        );
                      } else {
                        final int colorValue = image['color'] as int;
                        final Color color = Color(colorValue);
                        imageWidget = Container(
                          color: color,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Sample Image',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Replace with actual feature image',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: imageWidget),
                          Container(
                            width: double.infinity,
                            color: Colors.black54,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                            child: Text(
                              caption,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  
                  // Close button
                  Positioned(
                    top: 40,
                    right: 24,
                    child: IconButton(
                      icon: const CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  
                  // Navigation buttons
                  if (images.length > 1) ...[
                    // Previous button
                    Positioned(
                      left: 16,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: IconButton(
                          icon: const CircleAvatar(
                            backgroundColor: Colors.black38,
                            child: Icon(Icons.chevron_left, color: Colors.white),
                          ),
                          onPressed: () {
                            if (pageController.page!.round() > 0) {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    
                    // Next button
                    Positioned(
                      right: 16,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: IconButton(
                          icon: const CircleAvatar(
                            backgroundColor: Colors.black38,
                            child: Icon(Icons.chevron_right, color: Colors.white),
                          ),
                          onPressed: () {
                            if (pageController.page!.round() < images.length - 1) {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
  
  // Helper method to get icon data from string
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'login':
        return Icons.login;
      case 'dashboard':
        return Icons.dashboard;
      case 'people':
        return Icons.people;
      case 'notifications':
        return Icons.notifications;
      case 'assessment':
        return Icons.assessment;
      case 'search':
        return Icons.search;
      case 'visibility':
        return Icons.visibility;
      case 'more_horiz':
        return Icons.more_horiz;
      case 'apartment':
        return Icons.apartment;
      case 'payment':
        return Icons.payment;
      case 'chat':
        return Icons.chat;
      case 'face':
        return Icons.face;
      case 'security':
        return Icons.security;
      case 'assignment':
        return Icons.assignment;
      case 'settings':
        return Icons.settings;
      case 'group':
        return Icons.group;
      case 'description':
        return Icons.description;
      case 'person':
        return Icons.person;
      case 'campaign':
        return Icons.campaign;
      default:
        return Icons.image;
    }
  }
  
  Widget _buildQuickLinks(Map<String, dynamic> project, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.secondaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Quick Links',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.home,
                  color: AppColors.secondaryColor,
                  size: 18,
                ),
                onPressed: () => context.goNamed('home'),
                tooltip: 'Back to Home',
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildQuickLinkItem(
            'GitHub Repository',
            Icons.code,
            () => UrlLauncherHelper.launchURL(project['github']),
          ),
          // const Divider(color: AppColors.primaryColor),
          // _buildQuickLinkItem(
          //   'Live Demo',
          //   Icons.public,
          //   () => UrlLauncherHelper.launchURL(project['live']),
          // ),
          // if (project['apk_download'] != null) ...[
          //   const Divider(color: AppColors.primaryColor),
          //   _buildQuickLinkItem(
          //     'Download APK',
          //     Icons.android,
          //     () => UrlLauncherHelper.launchURL(project['apk_download'], inNewTab: true, enableDomStorage: true),
          //   ),
          // ],
        ],
      ),
    );
  }

  Widget _buildQuickLinkItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.secondaryColor,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.secondaryColor,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.secondaryColor,
          size: 24,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: const TextStyle(
        color: AppColors.subTextColor,
        fontSize: 16,
        height: 1.6,
      ),
    );
  }

  List<Widget> _buildProjectGoals(Map<String, dynamic> project) {
    final goals = project['goals'] as List<String>? ?? 
      ['Develop real-world application', 'Improve programming skills'];
    
    return goals.map((goal) => Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.secondaryColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              goal,
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    )).toList();
  }

  Widget _buildTechnologies(Map<String, dynamic> project) {
    final techs = project['technologies_detail'] as List<String>? ?? 
              project['technologies'] as List<String>;
              
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: techs.map((tech) {
        return Chip(
          backgroundColor: AppColors.cardColor,
          side: BorderSide(color: AppColors.secondaryColor.withOpacity(0.5)),
          label: Text(
            tech,
            style: const TextStyle(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          avatar: const Icon(
            Icons.code,
            color: AppColors.secondaryColor,
            size: 16,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        );
      }).toList(),
    );
  }

  List<Widget> _buildProjectFeatures(Map<String, dynamic> project) {
    final features = project['features'] as List<String>? ?? 
                   ['User-friendly interface', 'Optimized performance'];
    
    return features.map((feature) => Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.star,
            color: AppColors.secondaryColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              feature,
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    )).toList();
  }

  Widget _buildDownloadSection(Map<String, dynamic> project) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.secondaryColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.android,
            color: AppColors.secondaryColor,
            size: 48,
          ),
          const SizedBox(height: 16),
          const Text(
            'Download and experience now!',
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'You can download the APK file to install and experience this application directly on your Android device.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.subTextColor,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Download APK',
            onPressed: () => UrlLauncherHelper.launchURL(project['apk_download'], inNewTab: true, enableDomStorage: true),
            width: 200,
            icon: Icons.download,
          ),
        ],
      ),
    );
  }

  // Tech badges for header
  Widget _buildHeaderTechBadges() {
    final techs = (project['technologies'] as List<String>).take(4).toList();
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: techs.map((tech) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            tech,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }
}

// Chart painters for visualization
class ChartPainter extends CustomPainter {
  final Color color;
  
  ChartPainter(this.color);
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.5)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    
    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.25, 
      size.height * 0.3, 
      size.width * 0.5, 
      size.height * 0.5
    );
    path.quadraticBezierTo(
      size.width * 0.75, 
      size.height * 0.7, 
      size.width, 
      size.height * 0.2
    );
    
    canvas.drawPath(path, paint);
    
    // Draw points
    final pointPaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(Offset(0, size.height * 0.7), 4, pointPaint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), 4, pointPaint);
    canvas.drawCircle(Offset(size.width, size.height * 0.2), 4, pointPaint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DonutChartPainter extends CustomPainter {
  final Color color;
  
  DonutChartPainter(this.color);
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.4;
    
    final segments = [0.45, 0.25, 0.2, 0.1];
    var startAngle = 0.0;
    
    for (int i = 0; i < segments.length; i++) {
      final sweepAngle = segments[i] * 2 * math.pi;
      final paint = Paint()
        ..color = i == 0 
            ? color 
            : color.withOpacity(1.0 - (i * 0.2));
        
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      
      startAngle += sweepAngle;
    }
    
    // Draw center hole
    canvas.drawCircle(
      center, 
      radius * 0.6,
      Paint()..color = Colors.white,
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LineChartPainter extends CustomPainter {
  final Color color;
  
  LineChartPainter(this.color);
  
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    
    final path = Path();
    
    final points = [
      Offset(0, size.height * 0.6),
      Offset(size.width * 0.2, size.height * 0.8),
      Offset(size.width * 0.4, size.height * 0.4),
      Offset(size.width * 0.6, size.height * 0.6),
      Offset(size.width * 0.8, size.height * 0.2),
      Offset(size.width, size.height * 0.3),
    ];
    
    path.moveTo(points[0].dx, points[0].dy);
    
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    
    canvas.drawPath(path, linePaint);
    
    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;
    
    for (int i = 1; i < 4; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 