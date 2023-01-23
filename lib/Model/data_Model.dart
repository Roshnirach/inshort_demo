class News {
  News({
    required this.category,
    required this.data,
    required this.success,
  });

  String category;
  List<Datum> data;
  bool success;

  factory News.fromJson(Map<String, dynamic> json) => News(
        category: json["category"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        success: json["success"],
      );
}

class Datum {
  Datum({
    required this.author,
    required this.content,
    required this.id,
    required this.imageUrl,
    this.readMoreUrl,
    required this.time,
    required this.title,
    required this.url,
  });
  String author;
  String content;

  String id;
  String imageUrl;
  String? readMoreUrl;
  String time;
  String title;
  String url;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        author: json["author"],
        content: json["content"],
        id: json["id"],
        imageUrl: json["imageUrl"],
        readMoreUrl: json["readMoreUrl"],
        time: json["time"],
        title: json["title"],
        url: json["url"],
      );
}
