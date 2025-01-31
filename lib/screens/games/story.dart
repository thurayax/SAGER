class Story {
  final String title;
  final String imagePath;
  final String content;
  final String audioPath; // إضافة متغير الصوت

  Story({
    required this.title,
    required this.imagePath,
    required this.content,
    required this.audioPath, // جعله مطلوبًا عند إنشاء كائن القصة
  });
}
