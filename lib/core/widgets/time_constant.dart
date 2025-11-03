class TimeConstants {
  static const int breakfastPrepTime = 1440; // minutes
  static const int lunchPrepTime = 45; // minutes
  static const int dinnerPrepTime = 60; // minutes

  static String formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;

    if (hours > 0) {
      return '${hours}h ${mins}m';
    }
    return '${mins}m';
  }
}