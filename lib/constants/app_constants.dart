import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AppConstants {
  // Portfolio Information
  static const String name = "Trần Phước Tín";
  static const String title = "Flutter Developer";
  static const String email = "phuoctin74@gmail.com";
  static const String phone = "+84 70 802 50 65";
  static const String location = "Đà Nẵng, Việt Nam";
  
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
  // Đối với các hình ảnh, sử dụng thuộc tính 'path' thay vì 'color' để hiển thị ảnh thực tế
  // Ví dụ: {'path': 'assets/images/projects/roomily_main.png', 'caption': 'Màn hình chính'}
  // Đường dẫn ảnh nên được đặt trong thư mục assets/images/projects/
  // Nếu không có ảnh thực tế, hệ thống sẽ hiển thị một màu placeholder
  static const List<Map<String, dynamic>> projects = [
    {
       "title": "Roomily",
  "description": "Ứng dụng quản lý phòng trọ toàn diện với hai đối tượng chính: chủ nhà và người thuê. Cung cấp các tính năng đăng và thuê phòng, quản lý hợp đồng, thanh toán hóa đơn, tìm bạn cùng phòng, và hệ thống thông báo thời gian thực.",
  "technologies": ["Flutter", "Firebase", "Bloc/Cubit", "Websocket", "Google Maps API"],
  "technologies_detail": [
    "Flutter", "Dart", "Bloc/Cubit", "Firebase Core", 
    "Firebase Cloud Messaging", "Firestore", "REST API", 
    "Socket.IO (Stomp)", "Google Maps API", "Clean Architecture",
    "Provider", "Go Router", "Dio", "JSON Serializable"
  ],
  "goals": [
    "Kết nối chủ nhà và người thuê hiệu quả thông qua nền tảng dễ sử dụng",
    "Tự động hóa quản lý hóa đơn, thanh toán và thông báo",
    "Tối ưu trải nghiệm tìm kiếm và thuê phòng với bản đồ và bộ lọc nâng cao",
    "Hỗ trợ tìm bạn cùng phòng và chia sẻ chi phí",
    "Cung cấp công cụ lập kế hoạch ngân sách cho người thuê"
  ],
  "features": [
    "Đăng ký và đăng nhập với hai vai trò riêng biệt: chủ nhà hoặc người thuê",
    "Đăng phòng, tìm kiếm và lọc phòng theo vị trí, giá, tiện nghi",
    "Xem phòng trên bản đồ với thông tin chi tiết",
    "Hệ thống chat thời gian thực giữa chủ nhà và người thuê",
    "Tạo, quản lý và xem hợp đồng thuê nhà",
    "Thanh toán hóa đơn (điện, nước, internet) qua mã QR",
    "Đăng và tìm kiếm bạn cùng phòng với thông tin chi tiết",
    "Quản lý danh sách phòng yêu thích",
    "Đánh giá phòng và chủ nhà",
    "Lập kế hoạch ngân sách chi tiêu cho người thuê",
    "Chức năng quảng cáo phòng cho chủ nhà",
    "Thống kê và báo cáo thu chi cho chủ nhà",
    "Hệ thống thông báo đẩy về thanh toán, gia hạn hợp đồng",
    "Quản lý ví và giao dịch cho cả hai đối tượng"
  ],
      'github': 'https://github.com/TranPhuocTin/roomily-app',
      'live': 'https://example.com/roomily-app',
      'image': 'assets/icons/roomily_logo.png',
      'apk_download': 'https://drive.google.com/drive/folders/1fEQkawlaaq6ghK8jYVIqqWl14ZO9p-9w?usp=drive_link',
      'screenshots': [
        {
          'section': 'Trang chủ',
          'description': 'Giao diện dành cho người thuê và chủ trọ',
          'icon': 'home',
          'images': [
            {'path': 'assets/images/projects/tenant_home_screen.jpg', 'caption': 'Trang chủ người thuê'},
            {'path': 'assets/images/projects/landlord_home_1.jpg', 'caption': 'Trang chủ chủ trọ'},
            {'path': 'assets/images/projects/landlord_home_2.jpg', 'caption': 'Bảng điều khiển chủ trọ'},
          ]
        },
        {
          'section': 'Tìm kiếm phòng',
          'description': 'Tính năng tìm kiếm và lọc phòng trọ theo vị trí và tiêu chí',
          'icon': 'search',
          'images': [
            {'path': 'assets/images/projects/search_screen_1.jpg', 'caption': 'Tìm kiếm cơ bản'},
            {'path': 'assets/images/projects/search_screen_2.jpg', 'caption': 'Bộ lọc nâng cao'},
            {'path': 'assets/images/projects/search_screen_3.jpg', 'caption': 'Kết quả tìm kiếm'},
            {'path': 'assets/images/projects/map_screen.jpg', 'caption': 'Tìm kiếm trên bản đồ'},
          ]
        },
        {
          'section': 'Tìm bạn cùng phòng',
          'description': 'Tính năng kết nối người thuê để ở ghép, giảm chi phí thuê phòng',
          'icon': 'group',
          'images': [
            {'path': 'assets/images/projects/find_partner_1.jpg', 'caption': 'Danh sách người tìm ở ghép'},
            {'path': 'assets/images/projects/find_partner_2.jpg', 'caption': 'Bộ lọc tìm bạn cùng phòng'},
            {'path': 'assets/images/projects/find_partner_3.jpg', 'caption': 'Chi tiết hồ sơ'},
            {'path': 'assets/images/projects/find_partner_4.jpg', 'caption': 'Sở thích và thói quen'},
            {'path': 'assets/images/projects/find_partner_5.jpg', 'caption': 'Yêu cầu về phòng ở'},
            {'path': 'assets/images/projects/find_partner_6.jpg', 'caption': 'Tạo hồ sơ tìm bạn cùng phòng'},
            {'path': 'assets/images/projects/find_partner_7.jpg', 'caption': 'Các đề xuất phù hợp'},
            {'path': 'assets/images/projects/find_partner_8.jpg', 'caption': 'Thông báo phù hợp'},
            {'path': 'assets/images/projects/find_partner_9.jpg', 'caption': 'Đánh giá mức độ hợp nhau'},
            {'path': 'assets/images/projects/find_partner_10.jpg', 'caption': 'Liên hệ với bạn cùng phòng'},
          ]
        },
        {
          'section': 'Quản lý phòng trọ',
          'description': 'Quản lý danh sách phòng trọ và thêm phòng mới',
          'icon': 'apartment',
          'images': [
            {'path': 'assets/images/projects/room_screen.jpg', 'caption': 'Danh sách phòng'},
            {'path': 'assets/images/projects/landlord_add_room_1.jpg', 'caption': 'Tạo phòng mới'},
            {'path': 'assets/images/projects/landlord_add_room_2.jpg', 'caption': 'Thêm thông tin cơ bản'},
            {'path': 'assets/images/projects/landlord_add_room_3.jpg', 'caption': 'Cài đặt tiện ích phòng'},
            {'path': 'assets/images/projects/landlord_add_room_4.jpg', 'caption': 'Thêm hình ảnh phòng'},
            {'path': 'assets/images/projects/landlord_add_room_5.jpg', 'caption': 'Cài đặt giá và điều kiện'},
          ]
        },
        {
          'section': 'Chi tiết phòng',
          'description': 'Xem thông tin chi tiết về phòng trọ',
          'icon': 'visibility',
          'images': [
            {'path': 'assets/images/projects/room_detail_1.jpg', 'caption': 'Thông tin cơ bản'},
            {'path': 'assets/images/projects/room_detail_2.jpg', 'caption': 'Tiện ích và mô tả'},
            {'path': 'assets/images/projects/room_detail_3.jpg', 'caption': 'Vị trí và đánh giá'},
          ]
        },
        {
          'section': 'Thanh toán và hóa đơn',
          'description': 'Hệ thống quản lý và thanh toán hóa đơn tiện ích',
          'icon': 'payment',
          'images': [
            {'path': 'assets/images/projects/bill_1.jpg', 'caption': 'Danh sách hóa đơn'},
            {'path': 'assets/images/projects/bill_2.jpg', 'caption': 'Chi tiết hóa đơn'},
            {'path': 'assets/images/projects/bill_3.jpg', 'caption': 'Xác nhận thanh toán'},
            {'path': 'assets/images/projects/bill_4.jpg', 'caption': 'Lịch sử thanh toán'},
            {'path': 'assets/images/projects/bill_5.jpg', 'caption': 'Thông báo thanh toán'},
            {'path': 'assets/images/projects/bill_6.jpg', 'caption': 'Chọn phương thức thanh toán'},
            {'path': 'assets/images/projects/bill_7.jpg', 'caption': 'Thanh toán QR code'},
            {'path': 'assets/images/projects/bill_8.jpg', 'caption': 'Báo cáo tài chính'},
            {'path': 'assets/images/projects/bill_9.jpg', 'caption': 'Thống kê chi tiêu'},
          ]
        },
        {
          'section': 'Hợp đồng thuê phòng',
          'description': 'Quản lý hợp đồng điện tử giữa chủ trọ và người thuê',
          'icon': 'description',
          'images': [
            {'path': 'assets/images/projects/contract 1.jpg', 'caption': 'Danh sách hợp đồng'},
            {'path': 'assets/images/projects/contract_2.jpg', 'caption': 'Chi tiết hợp đồng'},
            {'path': 'assets/images/projects/contract_3.jpg', 'caption': 'Ký kết hợp đồng'},
          ]
        },
        {
          'section': 'Trò chuyện',
          'description': 'Hệ thống nhắn tin trực tiếp giữa chủ trọ và người thuê',
          'icon': 'chat',
          'images': [
            {'path': 'assets/images/projects/chat_screen_1.jpg', 'caption': 'Danh sách trò chuyện'},
            {'path': 'assets/images/projects/chat_screen_2.jpg', 'caption': 'Cửa sổ chat'},
            {'path': 'assets/images/projects/chat_screen_3.jpg', 'caption': 'Gửi hình ảnh'},
            {'path': 'assets/images/projects/chat_screen_4.jpg', 'caption': 'Chat nhóm'},
            {'path': 'assets/images/projects/chat_screen_5.jpg', 'caption': 'Tìm kiếm tin nhắn'},
            {'path': 'assets/images/projects/chat_screen_6.jpg', 'caption': 'Chia sẻ thông tin phòng'},
          ]
        },
        {
          'section': 'Chiến dịch & Quảng cáo',
          'description': 'Tính năng quảng bá phòng trọ, ưu đãi và chiến dịch khuyến mãi',
          'icon': 'campaign',
          'images': [
            {'path': 'assets/images/projects/campaign_1.jpg', 'caption': 'Danh sách chiến dịch'},
            {'path': 'assets/images/projects/campaign_2.jpg', 'caption': 'Tạo chiến dịch mới'},
            {'path': 'assets/images/projects/campaign_3.jpg', 'caption': 'Thống kê hiệu quả'},
            {'path': 'assets/images/projects/campaign_4.jpg', 'caption': 'Cài đặt đối tượng'},
          ]
        },
        {
          'section': 'Hồ sơ cá nhân',
          'description': 'Quản lý thông tin cá nhân và cài đặt tài khoản',
          'icon': 'person',
          'images': [
            {'path': 'assets/images/projects/profile_screen_1.jpg', 'caption': 'Thông tin cá nhân'},
            {'path': 'assets/images/projects/profile_screen_2.jpg', 'caption': 'Chỉnh sửa hồ sơ'},
            {'path': 'assets/images/projects/profile_screen_3.jpg', 'caption': 'Cài đặt riêng tư'},
            {'path': 'assets/images/projects/profile_screen_4.jpg', 'caption': 'Quản lý tài khoản'},
          ]
        },
        {
          'section': 'Thông báo',
          'description': 'Hệ thống thông báo về các sự kiện, thanh toán và tin nhắn mới',
          'icon': 'notifications',
          'images': [
            {'path': 'assets/images/projects/notification.jpg', 'caption': 'Trung tâm thông báo'},
          ]
        }
      ]
    },
    {
      'title': 'Exam Guard',
      'description': 'Ứng dụng giám sát thi cử sử dụng công nghệ AI để phát hiện các hành vi gian lận và đảm bảo tính công bằng trong quá trình kiểm tra trực tuyến.',
      'technologies': ['Flutter', 'Websocket', 'ML Kit API', 'Bloc/Cubit'],
       "technologies_detail": [
          "Flutter", "Dart", "Bloc/Cubit", "Google ML Kit", 
          "Camera API", 
          "Socket.IO", "JSON Serialization"
        ],
        "goals": [
          "Xây dựng hệ thống giám sát thi cử trực tuyến hiệu quả",
          "Sử dụng AI để phát hiện hành vi gian lận tự động",
          "Tạo môi trường thi cử công bằng cho tất cả thí sinh",
          "Giảm thiểu nhu cầu giám sát thủ công của giáo viên"
        ],
        "features": [
          "Face detection để xác minh danh tính thí sinh",
          "Theo dõi chuyển động mắt để phát hiện hành động đáng ngờ",
          "Phát hiện khi có người khác xuất hiện trong khung hình",
          "Phân tích âm thanh để phát hiện tiếng nói hoặc tiếng ồn",
          "Chụp màn hình ngẫu nhiên để kiểm tra hoạt động",
          "Báo cáo chi tiết về các hành vi đáng ngờ",
          "Dashboard cho giáo viên theo dõi nhiều thí sinh cùng lúc",
          "Khả năng hoạt động với băng thông thấp"
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