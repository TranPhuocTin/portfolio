import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_colors.dart';
import 'package:portfolio/constants/app_constants.dart';
import 'package:portfolio/utils/responsive_helper.dart';
import 'package:portfolio/widgets/custom_button.dart';
import 'package:portfolio/widgets/section_title.dart';
import 'package:portfolio/widgets/project_card.dart';
import 'package:portfolio/utils/url_launcher_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  
  // Controllers for contact form
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  
  // Navigation sections and scroll positions
  final List<String> _sections = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Experience',
    'Contact',
  ];
  
  // Fixed scroll positions (approximate px from top) - sẽ được điều chỉnh trong initState
  List<double> _sectionOffsets = [0, 600, 900, 1200, 1800, 2400];
  
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    
    // Add a post-frame callback to update section offsets based on screen size
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSectionOffsets();
    });
    
    // Listen to scroll events to update the selected nav item
    _scrollController.addListener(_updateSelectedIndexBasedOnScroll);
  }
  
  @override
  void dispose() {
    _scrollController.removeListener(_updateSelectedIndexBasedOnScroll);
    _scrollController.dispose();
    _nameController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
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
        screenHeight * 0.75 + 1500 * factor, // Contact
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
  void _sendEmail() {
    final name = _nameController.text.trim();
    final subject = _subjectController.text.trim();
    final message = _messageController.text.trim();
    
    // Create email body with sender's name
    final bodyText = 'From: $name\n\n$message';
    
    // Launch email client with pre-filled data
    UrlLauncherHelper.launchEmail(
      AppConstants.email,
      subject: subject,
      body: bodyText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
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
                const SizedBox(height: 120),
                _buildAboutSection(),
                const SizedBox(height: 80),
                _buildSkillsSection(),
                const SizedBox(height: 80),
                _buildProjectsSection(),
                const SizedBox(height: 80),
                _buildExperienceSection(),
                const SizedBox(height: 80),
                _buildContactSection(),
                const SizedBox(height: 80),
                _buildFooter(),
              ],
            ),
          ),
        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hi, my name is',
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppConstants.name,
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: ResponsiveHelper.isMobile(context) ? 40 : 70,
            fontWeight: FontWeight.bold,
            height: 1.1,
          ),
        ),
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
            Text(
              AppConstants.title,
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: ResponsiveHelper.isMobile(context) ? 24 : 40,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: ResponsiveHelper.isMobile(context) ? double.infinity : 500,
          child: Text(
            AppConstants.aboutMe,
            style: const TextStyle(
              color: AppColors.subTextColor,
              fontSize: 18,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            CustomButton(
              text: 'Xem Dự Án',
              onPressed: () {
                setState(() => _selectedIndex = 3); // Projects index
                _scrollToSection(3);
              },
              icon: Icons.arrow_forward,
            ),
            const SizedBox(width: 16),
            CustomButton(
              text: 'Liên Hệ',
              onPressed: () {
                setState(() => _selectedIndex = 5); // Contact index
                _scrollToSection(5);
              },
              outline: true,
            ),
          ],
        ),
        const SizedBox(height: 40),
        _buildSocialLinks(),
      ],
    );
  }

  // Social Links
  Widget _buildSocialLinks() {
    return Row(
      children: [
        _socialIcon(Icons.code, AppConstants.github),
        _socialIcon(Icons.person_pin, AppConstants.linkedin),
        _socialIcon(Icons.people, AppConstants.twitter),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoItem(Icons.email, 'Email', AppConstants.email),
                _infoItem(Icons.phone, 'Phone', AppConstants.phone),
                _infoItem(Icons.location_on, 'Location', AppConstants.location),
              ],
            ),
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
          Icon(icon, color: AppColors.secondaryColor, size: 20),
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
          children: AppConstants.skills.map((skill) {
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
        const SectionTitle(title: 'Recent Projects'),
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
      children: AppConstants.projects.map((project) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: ProjectCard(
            title: project['title'],
            description: project['description'],
            technologies: List<String>.from(project['technologies']),
            github: project['github'],
            live: project['live'],
            image: project['image'],
          ),
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
        );
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
        );
      },
    );
  }

  // Experience Section
  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Work Experience'),
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
            );
          },
        ),
        const SizedBox(height: 40),
        const SectionTitle(title: 'Education'),
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
    );
  }

  Widget _educationItem({
    required String degree,
    required String institution,
    required String duration,
    required String description,
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
    );
  }

  // Contact Section
  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Contact'),
        const SizedBox(height: 20),
        Text(
          AppConstants.contactDescription,
          style: const TextStyle(
            color: AppColors.subTextColor,
            fontSize: 16,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  labelStyle: TextStyle(color: AppColors.textColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.subTextColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondaryColor),
                  ),
                ),
                style: const TextStyle(color: AppColors.textColor),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  labelStyle: TextStyle(color: AppColors.textColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.subTextColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondaryColor),
                  ),
                ),
                style: const TextStyle(color: AppColors.textColor),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(color: AppColors.textColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.subTextColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondaryColor),
                  ),
                ),
                style: const TextStyle(color: AppColors.textColor),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Send Message',
                  onPressed: _sendEmail,
                  width: double.infinity,
                  icon: Icons.send,
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
} 