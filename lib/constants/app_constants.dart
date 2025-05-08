import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AppConstants {
  // Portfolio Information
  static const String name = "Tran Phuoc Tin";
  static const String title = "Flutter Developer";
  static const String email = "phuoctin74@gmail.com";
  static const String phone = "+84 70 802 50 65";
  static const String location = "Da Nang, Vietnam";
  
  // CV Download
  static const String cvFileName = "TranPhuocTin_CV.pdf";
  static const String cvFilePath = "assets/files/TranPhuocTin_CV.pdf";
  static String get cvUrl => kIsWeb 
      ? "assets/files/TranPhuocTin_CV.pdf" 
      : cvFilePath;
  
  // Social Media Links
  static const String github = "https://github.com/TranPhuocTin";
  static const String linkedin = "https://linkedin.com/in/yourusername";
  static const String twitter = "https://twitter.com/yourusername";
  static const String facebook = "https://www.facebook.com/tran.phuoc.tin.2024";
  
  // About Me
  static const String aboutMe = 
    "I am a Flutter Developer with a passion for creating beautiful and efficient mobile applications. "
    "With experience in cross-platform application development, I am always looking for ways to improve "
    "my skills and learn new technologies. I have the ability to work independently as well as effectively in a team.";
  
  // Skills
  static const List<String> skills = [
    "Flutter",
    "Dart",
    "Firebase",
    "RESTful API",
    "Git",
    "Bloc"
  ];
  
  // Projects
  // For images, use the 'path' property instead of 'color' to display actual images
  // Example: {'path': 'assets/images/projects/roomily_main.png', 'caption': 'Main Screen'}
  // Image paths should be placed in the assets/images/projects/ folder
  // If there is no actual image, the system will display a placeholder color
  static const List<Map<String, dynamic>> projects = [
    {
       "title": "Roomily",
  "description": "Comprehensive room rental management application with two main user types: landlords and tenants. Provides features for posting and renting rooms, contract management, bill payments, finding roommates, and real-time notification system.",
  "technologies": ["Flutter", "Firebase", "Bloc/Cubit", "Websocket", "Google Maps API"],
  "technologies_detail": [
    "Flutter", "Dart", "Bloc/Cubit", "Firebase Core", 
    "Firebase Cloud Messaging", "Firestore", "REST API", 
    "Socket.IO (Stomp)", "Google Maps API", "Clean Architecture",
    "Provider", "Go Router", "Dio", "JSON Serializable"
  ],
  "goals": [
    "Connect landlords and tenants effectively through an easy-to-use platform",
    "Automate bill management, payments, and notifications",
    "Optimize room search and rental experience with maps and advanced filters",
    "Support finding roommates and cost sharing",
    "Provide budgeting tools for tenants"
  ],
  "features": [
    "Registration and login with two distinct roles: landlord or tenant",
    "Post rooms, search and filter rooms by location, price, amenities",
    "View rooms on a map with detailed information",
    "Real-time chat system between landlords and tenants",
    "Create, manage and view rental contracts",
    "Pay bills (electricity, water, internet) via QR code",
    "Post and search for roommates with detailed information",
    "Manage favorite room listings",
    "Rate rooms and landlords",
    "Detailed budget planning for tenants",
    "Room advertising features for landlords",
    "Income and expense statistics and reports for landlords",
    "Push notifications for payments, contract renewals",
    "Wallet and transaction management for both user types"
  ],
      'github': 'https://github.com/TranPhuocTin/roomily-app',
      'live': 'https://example.com/roomily-app',
      'image': 'assets/icons/roomily_logo.png',
      'apk_download': 'https://drive.google.com/drive/folders/1fEQkawlaaq6ghK8jYVIqqWl14ZO9p-9w?usp=drive_link',
      'screenshots': [
        {
          'section': 'Home',
          'description': 'Interface for tenants and landlords',
          'icon': 'home',
          'images': [
            {'path': 'assets/images/projects/tenant_home_screen.jpg', 'caption': 'Tenant home screen'},
            {'path': 'assets/images/projects/landlord_home_1.jpg', 'caption': 'Landlord home screen'},
            {'path': 'assets/images/projects/landlord_home_2.jpg', 'caption': 'Landlord dashboard'},
          ]
        },
        {
          'section': 'Room Search',
          'description': 'Room search and filter features by location and criteria',
          'icon': 'search',
          'images': [
            {'path': 'assets/images/projects/search_screen_1.jpg', 'caption': 'Basic search'},
            {'path': 'assets/images/projects/search_screen_2.jpg', 'caption': 'Advanced filters'},
            {'path': 'assets/images/projects/search_screen_3.jpg', 'caption': 'Search results'},
            {'path': 'assets/images/projects/map_screen.jpg', 'caption': 'Map search'},
          ]
        },
        {
          'section': 'Find Roommates',
          'description': 'Feature to connect tenants for shared accommodation, reducing rental costs',
          'icon': 'group',
          'images': [
            {'path': 'assets/images/projects/find_partner_1.jpg', 'caption': 'Roommate listings'},
            {'path': 'assets/images/projects/find_partner_2.jpg', 'caption': 'Roommate filters'},
            {'path': 'assets/images/projects/find_partner_3.jpg', 'caption': 'Profile details'},
            {'path': 'assets/images/projects/find_partner_4.jpg', 'caption': 'Preferences and habits'},
            {'path': 'assets/images/projects/find_partner_5.jpg', 'caption': 'Room requirements'},
            {'path': 'assets/images/projects/find_partner_6.jpg', 'caption': 'Create roommate profile'},
            {'path': 'assets/images/projects/find_partner_7.jpg', 'caption': 'Matching suggestions'},
            {'path': 'assets/images/projects/find_partner_8.jpg', 'caption': 'Match notifications'},
            {'path': 'assets/images/projects/find_partner_9.jpg', 'caption': 'Compatibility rating'},
            {'path': 'assets/images/projects/find_partner_10.jpg', 'caption': 'Contact roommate'},
          ]
        },
        {
          'section': 'Room Management',
          'description': 'Manage room listings and add new rooms',
          'icon': 'apartment',
          'images': [
            {'path': 'assets/images/projects/room_screen.jpg', 'caption': 'Room list'},
            {'path': 'assets/images/projects/landlord_add_room_1.jpg', 'caption': 'Create new room'},
            {'path': 'assets/images/projects/landlord_add_room_2.jpg', 'caption': 'Add basic information'},
            {'path': 'assets/images/projects/landlord_add_room_3.jpg', 'caption': 'Set room amenities'},
            {'path': 'assets/images/projects/landlord_add_room_4.jpg', 'caption': 'Add room images'},
            {'path': 'assets/images/projects/landlord_add_room_5.jpg', 'caption': 'Set prices and conditions'},
          ]
        },
        {
          'section': 'Room Details',
          'description': 'View detailed information about rooms',
          'icon': 'visibility',
          'images': [
            {'path': 'assets/images/projects/room_detail_1.jpg', 'caption': 'Basic information'},
            {'path': 'assets/images/projects/room_detail_2.jpg', 'caption': 'Amenities and description'},
            {'path': 'assets/images/projects/room_detail_3.jpg', 'caption': 'Location and reviews'},
          ]
        },
        {
          'section': 'Payments and Bills',
          'description': 'Utility bill management and payment system',
          'icon': 'payment',
          'images': [
            {'path': 'assets/images/projects/bill_1.jpg', 'caption': 'Bill list'},
            {'path': 'assets/images/projects/bill_2.jpg', 'caption': 'Bill details'},
            {'path': 'assets/images/projects/bill_3.jpg', 'caption': 'Payment confirmation'},
            {'path': 'assets/images/projects/bill_4.jpg', 'caption': 'Payment history'},
            {'path': 'assets/images/projects/bill_5.jpg', 'caption': 'Payment notifications'},
            {'path': 'assets/images/projects/bill_6.jpg', 'caption': 'Select payment method'},
            {'path': 'assets/images/projects/bill_7.jpg', 'caption': 'QR code payment'},
            {'path': 'assets/images/projects/bill_8.jpg', 'caption': 'Financial report'},
            {'path': 'assets/images/projects/bill_9.jpg', 'caption': 'Expense statistics'},
          ]
        },
        {
          'section': 'Rental Contracts',
          'description': 'Electronic contract management between landlords and tenants',
          'icon': 'description',
          'images': [
            {'path': 'assets/images/projects/contract 1.jpg', 'caption': 'Contract list'},
            {'path': 'assets/images/projects/contract_2.jpg', 'caption': 'Contract details'},
            {'path': 'assets/images/projects/contract_3.jpg', 'caption': 'Contract signing'},
          ]
        },
        {
          'section': 'Chat',
          'description': 'Direct messaging system between landlords and tenants',
          'icon': 'chat',
          'images': [
            {'path': 'assets/images/projects/chat_screen_1.jpg', 'caption': 'Chat list'},
            {'path': 'assets/images/projects/chat_screen_2.jpg', 'caption': 'Chat window'},
            {'path': 'assets/images/projects/chat_screen_3.jpg', 'caption': 'Send images'},
            {'path': 'assets/images/projects/chat_screen_4.jpg', 'caption': 'Group chat'},
            {'path': 'assets/images/projects/chat_screen_5.jpg', 'caption': 'Search messages'},
            {'path': 'assets/images/projects/chat_screen_6.jpg', 'caption': 'Share room information'},
          ]
        },
        {
          'section': 'Campaigns & Advertising',
          'description': 'Room promotion features, offers and promotional campaigns',
          'icon': 'campaign',
          'images': [
            {'path': 'assets/images/projects/campaign_1.jpg', 'caption': 'Campaign list'},
            {'path': 'assets/images/projects/campaign_2.jpg', 'caption': 'Create new campaign'},
            {'path': 'assets/images/projects/campaign_3.jpg', 'caption': 'Performance statistics'},
            {'path': 'assets/images/projects/campaign_4.jpg', 'caption': 'Target audience settings'},
          ]
        },
        {
          'section': 'Profile',
          'description': 'Manage personal information and account settings',
          'icon': 'person',
          'images': [
            {'path': 'assets/images/projects/profile_screen_1.jpg', 'caption': 'Personal information'},
            {'path': 'assets/images/projects/profile_screen_2.jpg', 'caption': 'Edit profile'},
            {'path': 'assets/images/projects/profile_screen_3.jpg', 'caption': 'Privacy settings'},
            {'path': 'assets/images/projects/profile_screen_4.jpg', 'caption': 'Account management'},
          ]
        },
        {
          'section': 'Notifications',
          'description': 'Notification system for events, payments and new messages',
          'icon': 'notifications',
          'images': [
            {'path': 'assets/images/projects/notification.jpg', 'caption': 'Notification center'},
          ]
        }
      ]
    },
    {
      'title': 'Exam Guard',
      'description': 'Exam monitoring application using AI technology to detect cheating behaviors and ensure fairness in online testing.',
      'technologies': ['Flutter', 'Websocket', 'ML Kit API', 'Bloc/Cubit'],
       "technologies_detail": [
          "Flutter", "Dart", "Bloc/Cubit", "Google ML Kit", 
          "Camera API", 
          "Socket.IO", "JSON Serialization"
        ],
        "goals": [
          "Build an effective online exam monitoring system",
          "Use AI to automatically detect cheating behavior",
          "Create a fair testing environment for all candidates",
          "Reduce the need for manual supervision by teachers"
        ],
        "features": [
          "Face detection to verify candidate identity",
          "Eye movement tracking to detect suspicious actions",
          "Detection when another person appears in the frame",
          "Audio analysis to detect speech or noise",
          "Random screenshots to check activities",
          "Detailed reports on suspicious behaviors",
          "Dashboard for teachers to monitor multiple candidates simultaneously",
          "Ability to operate with low bandwidth"
        ],
      'github': 'https://github.com/TranPhuocTin/ExamGuardApp',
      'live': 'https://example.com/exam-guard',
      'image': 'assets/images/project2.jpg',
      'apk_download': 'https://drive.google.com/file/d/example-examguard/view',
    },
  ];
  
  // Experience
  static const List<Map<String, dynamic>> experiences = [
    {
      'position': 'Intern',
      'company': 'Fpt Software',
      'duration': 'Jan 2025 - May 2025',
      'description': 'Participated in Java and Spring Boot training courses; developed and maintained the main application of the assigned project, collaborated with the team to complete important features; gained practical experience in mobile and backend programming, code review and agile work processes.',
    },
  ];
  
  // Education
  static const List<Map<String, dynamic>> education = [
    {
      'degree': 'Bachelor of Information Technology',
      'institution': 'Duy Tan University',
      'duration': '2021 - 2025',
      'description': 'Software Engineering major. GPA: 3.65/4.0',
    },
  ];
  
  // Services
  static const List<Map<String, String>> services = [
    {
      'title': 'Mobile App Development',
      'description': 'Create high-performance, responsive mobile applications for iOS and Android using Flutter.',
      'icon': 'assets/icons/mobile.svg',
    },
    {
      'title': 'Backend Integration',
      'description': 'Connect mobile applications with backends like Firebase, REST API, GraphQL.',
      'icon': 'assets/icons/backend.svg',
    },
  ];
  
  // Testimonials
  static const List<Map<String, String>> testimonials = [
    {
      'name': 'Nguyen Van A',
      'position': 'CEO, Tech Company A',
      'testimonial': 'An excellent developer with professional Flutter skills. Always completes work on time and with high quality.',
      'image': 'assets/images/testimonial1.jpg',
    },
    {
      'name': 'Tran Thi B',
      'position': 'Project Manager, Tech Company B',
      'testimonial': 'Working with you was a wonderful experience. You are not only a great developer but also an excellent colleague.',
      'image': 'assets/images/testimonial2.jpg',
    },
  ];
  
  // Contact
  static const String contactDescription = 'Please contact me if you have any questions or want to discuss your project.';
} 