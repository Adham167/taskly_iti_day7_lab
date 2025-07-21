class PostModel {
  final String title;
  final String body;
  final int id;
  bool isfavourite = false;

  PostModel({required this.id, required this.title, required this.body});

  factory PostModel.fromJson(data) =>
      PostModel(title: data['title'], body: data['body'], id: data['id']);
}
