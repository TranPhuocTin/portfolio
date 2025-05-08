import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_colors.dart';
import 'package:portfolio/constants/app_constants.dart';
import 'package:portfolio/utils/responsive_helper.dart';
import 'package:portfolio/widgets/custom_button.dart';
import 'package:portfolio/widgets/section_title.dart';
import 'package:portfolio/widgets/project_card.dart';
import 'package:portfolio/utils/url_launcher_helper.dart';
import 'package:portfolio/utils/file_helper.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:portfolio/utils/image_placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/screens/project_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  
  // Controllers for contact form
  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _subjectController = TextEditingController();
  // final TextEditingController _messageController = TextEditingController();
  
  // Navigation sections and scroll positions
  final List<String> _sections = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Experience',
    // 'Contact',
  ];
  
  // Fixed scroll positions (approximate px from top) - sẽ được điều chỉnh trong initState
  List<double> _sectionOffsets = [0, 600, 900, 1200, 1800]; // Removed Contact offset, adjust if necessary
  
  int _selectedIndex = 0;

  // List of particles for background effect
  List<Particle> _particles = [];
  AnimationController? _particleController;

  // 3D cube animation
  late AnimationController _cubeController;
  bool _hasInitializedCube = false;

  @override
  void initState() {
    super.initState();
    
    // Add a post-frame callback to update section offsets and initialize particles based on screen size
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSectionOffsets();
      _initializeParticles();
      
      // Initialize cube controller
      _cubeController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 15),
      )..repeat();
      _hasInitializedCube = true;
    });
    
    // Listen to scroll events to update the selected nav item
    _scrollController.addListener(_updateSelectedIndexBasedOnScroll);
  }
  
  // Initialize particles based on screen size
  void _initializeParticles() {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    
    _particles = List.generate(
      50, 
      (_) => Particle(
        position: Offset(
          math.Random().nextDouble() * screenWidth,
          math.Random().nextDouble() * screenHeight,
        ),
        speed: Offset(
          (math.Random().nextDouble() - 0.5) * 0.8,
          (math.Random().nextDouble() - 0.5) * 0.8,
        ),
        radius: math.Random().nextDouble() * 4 + 1,
      ),
    );
    
    // Initialize animation controller for particles
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 30), // ~60fps
    )..repeat();
    
    _particleController?.addListener(() {
      final size = MediaQuery.of(context).size;
      final screenWidth = size.width;
      final screenHeight = size.height;
      
      for (var particle in _particles) {
        particle.position += particle.speed;
        // Wrap particles around screen edges
        if (particle.position.dx < 0) particle.position = Offset(screenWidth, particle.position.dy);
        if (particle.position.dx > screenWidth) particle.position = Offset(0, particle.position.dy);
        if (particle.position.dy < 0) particle.position = Offset(particle.position.dx, screenHeight);
        if (particle.position.dy > screenHeight) particle.position = Offset(particle.position.dx, 0);
      }
      setState(() {});
    });
  }
  
  @override
  void dispose() {
    _scrollController.removeListener(_updateSelectedIndexBasedOnScroll);
    _scrollController.dispose();
    // _nameController.dispose();
    // _subjectController.dispose();
    // _messageController.dispose();
    if (_hasInitializedCube) {
      _cubeController.dispose();
    }
    if (_particleController != null && _particleController!.isAnimating) {
      _particleController!.dispose();
    }
    super.dispose();
  }
  
  // Update section offsets based on screen size
  void _updateSectionOffsets() {
    final screenHeight = MediaQuery.of(context).size.height;
    final factor = screenHeight / 800; // Base height reference
    
    setState(() {
      _sectionOffsets = [
        0,
        screenHeight * 0.75,              // About
        screenHeight * 0.75 + 350 * factor, // Skills 
        screenHeight * 0.75 + 500 * factor, // Projects
        screenHeight * 0.75 + 900 * factor, // Experience
        // screenHeight * 0.75 + 1500 * factor, // Contact (Commented out)
      ];
    });
  }
  
  // Update selected index based on current scroll position
  void _updateSelectedIndexBasedOnScroll() {
    double scrollPosition = _scrollController.offset;
    
    for (int i = _sectionOffsets.length - 1; i >= 0; i--) {
      if (scrollPosition >= _sectionOffsets[i] - 100) {
        if (_selectedIndex != i) {
          setState(() {
            _selectedIndex = i;
          });
        }
        break;
      }
    }
  }

  // Scroll to section by index
  void _scrollToSection(int index) {
    if (index >= 0 && index < _sectionOffsets.length) {
      _scrollController.animateTo(
        _sectionOffsets[index],
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // Send email with form data
  // void _sendEmail() {
  //   final name = _nameController.text.trim();
  //   final subject = _subjectController.text.trim();
  //   final message = _messageController.text.trim();
  //   
  //   // Create email body with sender's name
  //   final bodyText = 'From: $name\n\n$message';
  //   
  //   // Launch email client with pre-filled data
  //   UrlLauncherHelper.launchEmail(
  //     AppConstants.email,
  //     subject: subject,
  //     body: bodyText,
  //   );
  // }
  
  // Show project detail dialog
  void _showProjectDetail(Map<String, dynamic> project) {
    // Create project ID from project title (slug)
    final projectId = project['title'].toString().toLowerCase().replaceAll(' ', '-');
    
    // Navigate to /project/:id path and pass project data
    context.goNamed('project-detail', pathParameters: {'id': projectId}, extra: project);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Animated background particles covering the entire screen
          if (_particles.isNotEmpty)
            Positioned.fill(
              child: CustomPaint(
                painter: ParticlesPainter(particles: _particles),
              ),
            ),
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    _buildHeroSection(),
                    const SizedBox(height: 80),
                    _buildAboutSection(),
                    const SizedBox(height: 80),
                    _buildSkillsSection(),
                    const SizedBox(height: 80),
                    _buildProjectsSection(),
                    const SizedBox(height: 80),
                    _buildExperienceSection(),
                    const SizedBox(height: 80),
                    // _buildContactSection(),
                    // const SizedBox(height: 80),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryColor.withOpacity(0.8),
      elevation: 0,
      title: Row(
        children: [
          Text(
            AppConstants.name.split(' ')[0],
            style: const TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            ' ${AppConstants.name.split(' ').sublist(1).join(' ')}',
            style: const TextStyle(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: ResponsiveHelper.isMobile(context)
          ? [
              IconButton(
                icon: const Icon(Icons.menu, color: AppColors.textColor),
                onPressed: () {
                  _showMobileMenu();
                },
              ),
            ]
          : _sections
              .asMap()
              .entries
              .map(
                (entry) => TextButton(
                  onPressed: () {
                    setState(() => _selectedIndex = entry.key);
                    _scrollToSection(entry.key);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: _selectedIndex == entry.key
                        ? AppColors.secondaryColor
                        : AppColors.textColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      entry.value,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }

  // Mobile menu
  void _showMobileMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _sections
                .asMap()
                .entries
                .map(
                  (entry) => ListTile(
                    title: Text(
                      entry.value,
                      style: TextStyle(
                        color: _selectedIndex == entry.key
                            ? AppColors.secondaryColor
                            : AppColors.textColor,
                      ),
                    ),
                    onTap: () {
                      setState(() => _selectedIndex = entry.key);
                      Navigator.pop(context);
                      _scrollToSection(entry.key);
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  // Hero Section
  Widget _buildHeroSection() {
    return ResponsiveHelper.responsiveWidget(
      context: context,
      mobile: _buildHeroSectionMobile(),
      tablet: _buildHeroSectionDesktop(),
      desktop: _buildHeroSectionDesktop(),
    );
  }

  Widget _buildHeroSectionMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, my name is',
          style: const TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideX(),
        const SizedBox(height: 20),
        Text(
          AppConstants.name,
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: ResponsiveHelper.isMobile(context) ? 40 : 70,
            fontWeight: FontWeight.bold,
            height: 1.1,
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 400.ms).slideX(),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              "I'm a ",
              style: TextStyle(
                color: AppColors.subTextColor,
                fontSize: ResponsiveHelper.isMobile(context) ? 24 : 40,
                fontWeight: FontWeight.w500,
              ),
            ),
            _buildAnimatedJobTitle(),
          ],
        ).animate().fadeIn(duration: 500.ms, delay: 600.ms),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: Text(
            AppConstants.aboutMe,
            style: const TextStyle(
              color: AppColors.subTextColor,
              fontSize: 18,
              height: 1.6,
            ),
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 800.ms),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: 'View Project',
              onPressed: () {
                setState(() => _selectedIndex = 3); // Projects index
                _scrollToSection(3);
              },
              icon: Icons.arrow_forward,
            ).animate().scale(delay: 1000.ms),
            const SizedBox(width: 16),
            CustomButton(
              text: 'Download CV',
              onPressed: () => FileHelper.openAssetFile(
                AppConstants.cvUrl,
                AppConstants.cvFileName,
              ),
              icon: Icons.download_rounded,
              outline: true,
              tooltip: 'Download ${AppConstants.cvFileName}',
            ).animate().scale(delay: 1200.ms),
          ],
        ),
        const SizedBox(height: 40),
        Center(
          child: _buildSocialLinks().animate().fadeIn(delay: 1200.ms),
        ),
      ],
    );
  }

  Widget _buildHeroSectionDesktop() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left side - Text content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, my name is',
                style: const TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideX(),
              const SizedBox(height: 20),
              Text(
                AppConstants.name,
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: ResponsiveHelper.isMobile(context) ? 40 : 70,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ).animate().fadeIn(duration: 500.ms, delay: 400.ms).slideX(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "I'm a ",
                    style: TextStyle(
                      color: AppColors.subTextColor,
                      fontSize: ResponsiveHelper.isMobile(context) ? 24 : 40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  _buildAnimatedJobTitle(),
                ],
              ).animate().fadeIn(duration: 500.ms, delay: 600.ms),
              const SizedBox(height: 30),
              SizedBox(
                width: 500,
                child: Text(
                  AppConstants.aboutMe,
                  style: const TextStyle(
                    color: AppColors.subTextColor,
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),
              ).animate().fadeIn(duration: 500.ms, delay: 800.ms),
              const SizedBox(height: 40),
              Row(
                children: [
                  CustomButton(
                    text: 'View Project',
                    onPressed: () {
                      setState(() => _selectedIndex = 3); // Projects index
                      _scrollToSection(3);
                    },
                    icon: Icons.arrow_forward,
                  ).animate().scale(delay: 1000.ms),
                  const SizedBox(width: 16),
                  CustomButton(
                    text: 'Download CV',
                    onPressed: () => FileHelper.openAssetFile(
                      AppConstants.cvUrl,
                      AppConstants.cvFileName,
                    ),
                    icon: Icons.download_rounded,
                    outline: true,
                    tooltip: 'Download ${AppConstants.cvFileName}',
                  ).animate().scale(delay: 1200.ms),
                ],
              ),
              const SizedBox(height: 40),
              _buildSocialLinks().animate().fadeIn(delay: 1200.ms),
            ],
          ),
        ),
        
        // Right side - Animated 3D cube
        Expanded(
          child: _build3DCube(),
        ),
      ],
    );
  }

  // Animated job title with typewriter effect
  Widget _buildAnimatedJobTitle() {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          AppConstants.title,
          textStyle: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: ResponsiveHelper.isMobile(context) ? 24 : 40,
            fontWeight: FontWeight.w500,
          ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
      totalRepeatCount: 1,
      displayFullTextOnTap: true,
    );
  }

  // Social Links
  Widget _buildSocialLinks() {
    return Row(
      children: [
        _socialIcon(Icons.code, AppConstants.github),
        _socialIcon(Icons.facebook, AppConstants.facebook),
      ],
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return IconButton(
      icon: Icon(icon, color: AppColors.subTextColor, size: 20),
      onPressed: () => UrlLauncherHelper.launchURL(url),
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      tooltip: url.split('/').last,
    );
  }

  // About Section
  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'About Me'),
        const SizedBox(height: 20),
        Text(
          AppConstants.aboutMe,
          style: const TextStyle(
            color: AppColors.subTextColor,
            fontSize: 16,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoItem(Icons.email, 'Email', AppConstants.email),
            _infoItem(Icons.phone, 'Phone', AppConstants.phone),
            _infoItem(Icons.location_on, 'Location', AppConstants.location),
          ],
        ),
      ],
    );
  }

  Widget _infoItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: AppColors.secondaryColor, size: 30),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.subTextColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Skills Section
  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Skills'),

        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: AppConstants.skills.asMap().entries.map((entry) {
            final index = entry.key;
            final skill = entry.value;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.secondaryColor.withOpacity(0.3)),
              ),
              child: Text(
                skill,
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Projects Section
  Widget _buildProjectsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Recent Projects')
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 1800.ms, color: AppColors.secondaryColor.withOpacity(0.5)),
        const SizedBox(height: 40),
        ResponsiveHelper.responsiveWidget(
          context: context,
          mobile: _buildMobileProjectGrid(),
          tablet: _buildTabletProjectGrid(),
          desktop: _buildDesktopProjectGrid(),
        ),
      ],
    );
  }

  Widget _buildMobileProjectGrid() {
    return Column(
      children: AppConstants.projects.asMap().entries.map((entry) {
        final index = entry.key;
        final project = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: ProjectCard(
            title: project['title'],
            description: project['description'],
            technologies: List<String>.from(project['technologies']),
            github: project['github'],
            live: project['live'],
            image: project['image'],
            onTap: () => _showProjectDetail(project),
          ).animate(delay: Duration(milliseconds: 100 * index))
              .fadeIn(duration: 600.ms)
              .slide(begin: const Offset(0, 0.1), end: Offset.zero),
        );
      }).toList(),
    );
  }

  Widget _buildTabletProjectGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: AppConstants.projects.length,
      itemBuilder: (context, index) {
        final project = AppConstants.projects[index];
        return ProjectCard(
          title: project['title'],
          description: project['description'],
          technologies: List<String>.from(project['technologies']),
          github: project['github'],
          live: project['live'],
          image: project['image'],
          onTap: () => _showProjectDetail(project),
        ).animate(delay: Duration(milliseconds: 100 * index))
            .fadeIn(duration: 600.ms)
            .slide(begin: const Offset(0, 0.1), end: Offset.zero);
      },
    );
  }

  Widget _buildDesktopProjectGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: AppConstants.projects.length,
      itemBuilder: (context, index) {
        final project = AppConstants.projects[index];
        return ProjectCard(
          title: project['title'],
          description: project['description'],
          technologies: List<String>.from(project['technologies']),
          github: project['github'],
          live: project['live'],
          image: project['image'],
          onTap: () => _showProjectDetail(project),
        ).animate(delay: Duration(milliseconds: 100 * index))
            .fadeIn(duration: 600.ms)
            .slide(begin: const Offset(0, 0.1), end: Offset.zero);
      },
    );
  }

  // Experience Section
  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Work Experience')
            .animate()
            .fadeIn(duration: 500.ms)
            .slide(begin: const Offset(-0.1, 0), end: Offset.zero),
        const SizedBox(height: 30),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: AppConstants.experiences.length,
          itemBuilder: (context, index) {
            final experience = AppConstants.experiences[index];
            return _experienceItem(
              position: experience['position'],
              company: experience['company'],
              duration: experience['duration'],
              description: experience['description'],
              index: index,
            );
          },
        ),
        const SizedBox(height: 40),
        const SectionTitle(title: 'Education')
            .animate()
            .fadeIn(duration: 500.ms)
            .slide(begin: const Offset(-0.1, 0), end: Offset.zero),
        const SizedBox(height: 30),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: AppConstants.education.length,
          itemBuilder: (context, index) {
            final education = AppConstants.education[index];
            return _educationItem(
              degree: education['degree'],
              institution: education['institution'],
              duration: education['duration'],
              description: education['description'],
              index: index,
            );
          },
        ),
      ],
    );
  }

  Widget _experienceItem({
    required String position,
    required String company,
    required String duration,
    required String description,
    required int index,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            position,
            style: const TextStyle(
              color: AppColors.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                company,
                style: const TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.subTextColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  duration,
                  style: const TextStyle(
                    color: AppColors.subTextColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              color: AppColors.subTextColor,
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      ),
    )
    .animate(delay: Duration(milliseconds: 200 * index))
    .fadeIn(duration: 600.ms)
    .slide(begin: const Offset(0, 0.1), end: Offset.zero);
  }

  Widget _educationItem({
    required String degree,
    required String institution,
    required String duration,
    required String description,
    required int index,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            degree,
            style: const TextStyle(
              color: AppColors.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                institution,
                style: const TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.subTextColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  duration,
                  style: const TextStyle(
                    color: AppColors.subTextColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              color: AppColors.subTextColor,
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      ),
    )
    .animate(delay: Duration(milliseconds: 200 * index))
    .fadeIn(duration: 600.ms)
    .slide(begin: const Offset(0, 0.1), end: Offset.zero);
  }

  // Footer
  Widget _buildFooter() {
    return Column(
      children: [
        const Divider(color: AppColors.subTextColor),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '© ${DateTime.now().year} ${AppConstants.name}. All Rights Reserved.',
              style: const TextStyle(
                color: AppColors.subTextColor,
                fontSize: 14,
              ),
            ),
            _buildSocialLinks(),
          ],
        ),
      ],
    );
  }

  // 3D cube animation
  Widget _build3DCube() {
    return Container(
      height: 400,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circles
          ...List.generate(3, (index) {
            final size = 300 - (index * 60);
            return Container(
              width: size.toDouble(),
              height: size.toDouble(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.secondaryColor.withOpacity(0.1 + (index * 0.05)), 
                  width: 1
                ),
              ),
            ).animate(
              onPlay: (controller) => controller.repeat(),
            ).rotate(
              duration: Duration(seconds: 20 + (index * 10)),
              curve: Curves.linear,
            );
          }),
          
          // Floating code snippets
          ...List.generate(5, (index) {
            final snippets = [
              'const app = build();',
              'flutter create project',
              'import material.dart',
              'setState(() { ... })',
              'return Container(...)',
            ];
            
            final positions = [
              const Offset(0.2, 0.2),
              const Offset(0.8, 0.3),
              const Offset(0.3, 0.7),
              const Offset(0.7, 0.8),
              const Offset(0.5, 0.5),
            ];
            
            return Positioned(
              left: MediaQuery.of(context).size.width * 0.25 * positions[index].dx,
              top: 400 * positions[index].dy,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.cardColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: AppColors.secondaryColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  snippets[index],
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ).animate()
                .fade(duration: 500.ms, delay: Duration(milliseconds: 500 + index * 200))
                .slideY(begin: 0.2, end: 0),
            );
          }),
          
          // 3D Rotating cube
          Center(
            child: AnimatedBuilder(
              animation: _cubeController,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // Perspective
                    ..rotateY(_cubeController.value * 2 * math.pi)
                    ..rotateX(math.sin(_cubeController.value * math.pi) * 0.5),
                  child: _buildCube(),
                );
              },
            ),
          ),
          
          // Connection lines
          ...List.generate(8, (index) {
            final double angle = (index / 8) * 2 * math.pi;
            final double startRadius = 90;
            final double endRadius = 150;
            final double startX = startRadius * math.cos(angle);
            final double startY = startRadius * math.sin(angle);
            final double endX = endRadius * math.cos(angle);
            final double endY = endRadius * math.sin(angle);
            
            return CustomPaint(
              size: const Size(400, 400),
              painter: _LinePainter(
                start: Offset(200 + startX, 200 + startY),
                end: Offset(200 + endX, 200 + endY),
                color: AppColors.secondaryColor.withOpacity(0.2),
              ),
            );
          }),
          
        ],
      ),
    );
  }
  
  // Build the 3D cube
  Widget _buildCube() {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryColor.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
        border: Border.all(
          color: AppColors.secondaryColor,
          width: 2,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondaryColor.withOpacity(0.1),
            AppColors.backgroundColor,
            AppColors.cardColor,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Logo icon in the center
          Center(
            child: Icon(
              Icons.code,
              size: 60,
              color: AppColors.secondaryColor,
            ).animate(
              onPlay: (controller) => controller.repeat(),
            ).shimmer(
              duration: 2000.ms,
            ),
          ),
          
          // Grid pattern
          CustomPaint(
            size: const Size(180, 180),
            painter: _GridPainter(
              color: AppColors.secondaryColor.withOpacity(0.2),
              cellSize: 15,
            ),
          ),
          
          // Overlaying code-like patterns
          Positioned(
            top: 20,
            left: 20,
            child: _buildCodePatterns(5),
          ),
          
          Positioned(
            bottom: 20,
            right: 20,
            child: _buildCodePatterns(4),
          ),
          
          // Pulsing highlight
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondaryColor.withOpacity(0.2),
                    Colors.transparent,
                  ],
                  stops: const [0.1, 1.0],
                ),
              ),
            ).animate(
              onPlay: (controller) => controller.repeat(),
            ).custom(
              duration: 3000.ms,
              builder: (context, value, child) {
                final opacity = 0.3 + (math.sin(value * math.pi * 2) * 0.7);
                return Opacity(
                  opacity: opacity.clamp(0.0, 1.0),
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  // Build code-like patterns
  Widget _buildCodePatterns(int lines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(lines, (index) {
        final width = 20.0 + (math.Random().nextDouble() * 80);
        return Container(
          margin: const EdgeInsets.only(bottom: 6),
          height: 8,
          width: width,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}

// Grid painter for the cube
class _GridPainter extends CustomPainter {
  final Color color;
  final double cellSize;
  
  _GridPainter({
    required this.color,
    required this.cellSize,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;
      
    // Draw horizontal lines
    for (double i = 0; i <= size.height; i += cellSize) {
      canvas.drawLine(
        Offset(0, i), 
        Offset(size.width, i), 
        paint,
      );
    }
    
    // Draw vertical lines
    for (double i = 0; i <= size.width; i += cellSize) {
      canvas.drawLine(
        Offset(i, 0), 
        Offset(i, size.height), 
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(_GridPainter oldDelegate) => false;
}

// Line painter
class _LinePainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final Color color;
  
  _LinePainter({
    required this.start,
    required this.end,
    required this.color,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    
    canvas.drawLine(start, end, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Particle class to represent a single floating particle
class Particle {
  Offset position;
  Offset speed;
  double radius;
  
  Particle({
    required this.position,
    required this.speed,
    required this.radius,
  });
}

// Custom painter for drawing particles
class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  
  ParticlesPainter({required this.particles});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.secondaryColor.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    
    for (var particle in particles) {
      canvas.drawCircle(particle.position, particle.radius, paint);
    }
    
    // Add connection lines between nearby particles
    final linePaint = Paint()
      ..color = AppColors.secondaryColor.withOpacity(0.1)
      ..strokeWidth = 0.5;
    
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final distance = (particles[i].position - particles[j].position).distance;
        if (distance < 100) {
          canvas.drawLine(particles[i].position, particles[j].position, linePaint);
        }
      }
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 