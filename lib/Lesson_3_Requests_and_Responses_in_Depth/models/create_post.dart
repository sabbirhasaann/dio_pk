class CreatePost {
  final String title;
  final String body;
  final int userId;

  CreatePost({
    required this.title,
    required this.body,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'boyd': body,
    };
  }
}
