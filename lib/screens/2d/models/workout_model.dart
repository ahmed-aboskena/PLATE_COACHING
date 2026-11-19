class WorkoutModel {
  const WorkoutModel({
    required this.day,
    required this.title,
    required this.detail,
    this.done = false,
  });

  final String day;
  final String title;
  final String detail;
  final bool done;
}
