class AppConstants {
  // Portfolio Information
  static const String name = "Trần Phước Tín";
  static const String title = "Flutter Developer";
  static const String email = "phuoctin74@gmail.com";
  static const String phone = "+84 70 802 50 65";
  static const String location = "Đà Nẵng, Việt Nam";
  
  // Social Media Links
  static const String github = "https://github.com/TranPhuocTin";
  static const String linkedin = "https://linkedin.com/in/yourusername";
  static const String twitter = "https://twitter.com/yourusername";
  static const String facebook = "https://www.facebook.com/tran.phuoc.tin.2024";
  
  // About Me
  static const String aboutMe = 
    "Tôi là một Flutter Developer với niềm đam mê tạo ra các ứng dụng di động đẹp và hiệu quả. "
    "Với kinh nghiệm trong phát triển ứng dụng cross-platform, tôi luôn tìm kiếm các cách để cải thiện"
    " kỹ năng và học hỏi công nghệ mới. Tôi có khả năng làm việc độc lập cũng như làm việc nhóm hiệu quả.";
  
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
  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'Roomily',
      'description': 'Ứng dụng quản lý phòng trọ với hai đối tượng chính: chủ nhà và người thuê. Cung cấp các tính năng: Đăng và thuê phòng, Quản lý hợp đồng và hóa đơn, v.v.',
      'technologies': ['Flutter', 'Websocket', 'FCM', 'Bloc/Cubit'],
      'github': 'https://github.com/TranPhuocTin/roomily-app',
      'live': 'https://example.com/ecommerce-app',
      'image': 'assets/images/project1.jpg',
    },
    {
      'title': 'Exam Guard',
      'description': 'Ứng dụng chống gian lận trong thi cử bằng cách sử dụng AI để phát hiện các hành vi gian lận và các hành vi không phù hợp.',
      'technologies': ['Flutter', 'Websocket', 'ML Kit API', 'Bloc/Cubit'],
      'github': 'https://github.com/TranPhuocTin/exam-guard-app',
      'live': 'https://example.com/weather-app',
      'image': 'assets/images/project2.jpg',
    },

  ];
  
  // Experience
  static const List<Map<String, dynamic>> experiences = [
    {
      'position': 'Intern',
      'company': 'Fpt Software',
      'duration': 'Jan 2025 - May 2025',
      'description': 'Tham gia các khóa đào tạo về Java và Spring Boot; phát triển, duy trì ứng dụng chính của dự án được giao, phối hợp cùng nhóm để hoàn thiện các tính năng quan trọng; tích lũy kinh nghiệm thực tế về lập trình mobile và backend, review code và quy trình làm việc agile..',
    },
  ];
  
  // Education
  static const List<Map<String, dynamic>> education = [
    {
      'degree': 'Kỹ sư Công nghệ Thông tin',
      'institution': 'Đại học Duy Tân',
      'duration': '2021 - 2025',
      'description': 'Chuyên ngành Công Nghệ Phần mềm. GPA: 3.65/4.0',
    },
  ];
  
  // Services
  static const List<Map<String, String>> services = [
    {
      'title': 'Phát triển Ứng dụng Di động',
      'description': 'Tạo ứng dụng di động hiệu suất cao, đáp ứng cho iOS và Android bằng Flutter.',
      'icon': 'assets/icons/mobile.svg',
    },
    {
      'title': 'Tích hợp Backend',
      'description': 'Kết nối ứng dụng di động với backend như Firebase, REST API, GraphQL.',
      'icon': 'assets/icons/backend.svg',
    },
  ];
  
  // Testimonials
  static const List<Map<String, String>> testimonials = [
    {
      'name': 'Nguyễn Văn A',
      'position': 'CEO, Tech Company A',
      'testimonial': 'Một developer tuyệt vời với kỹ năng Flutter chuyên nghiệp. Luôn hoàn thành công việc đúng hạn và với chất lượng cao.',
      'image': 'assets/images/testimonial1.jpg',
    },
    {
      'name': 'Trần Thị B',
      'position': 'Project Manager, Tech Company B',
      'testimonial': 'Làm việc với bạn là một trải nghiệm tuyệt vời. Bạn không chỉ là một developer giỏi mà còn là một người đồng nghiệp tuyệt vời.',
      'image': 'assets/images/testimonial2.jpg',
    },
  ];
  
  // Contact
  static const String contactDescription = 'Hãy liên hệ với tôi nếu bạn có bất kỳ câu hỏi nào hoặc muốn thảo luận về dự án của bạn.';
} 