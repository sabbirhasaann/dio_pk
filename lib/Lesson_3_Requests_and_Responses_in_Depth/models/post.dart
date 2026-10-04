class Post {
  final int userId;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.title,
    required this.body,
  });

  factory fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
