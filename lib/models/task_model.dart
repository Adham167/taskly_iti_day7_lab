class Task {
  final String name;
  final String createdBy;
  bool isCompleted;

  Task({
    required this.name,
    required this.createdBy,
    this.isCompleted = false,
  });
}
