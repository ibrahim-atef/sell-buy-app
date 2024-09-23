

class NumberFormatter {
  static String? formatter(String currentBalance) {
    try {
      int value = int.tryParse(currentBalance) ?? 0;

      if (value < 1000) {
        return value.toStringAsFixed(0);
      } else if (value < 100000 && value >= 1000) {
        int result = value ~/ 1000;
        return "${result.toStringAsFixed(0)}K";
      } else if (value < 1000000 && value >= 100000) {
        int result = value ~/ 1000;
        return "${result.toStringAsFixed(1)}K";
      } else if (value >= 1000000 && value < (1000000 * 10 * 100)) {
        int result = value ~/ 1000000;
        return "${result.toStringAsFixed(0)}M";
      } else if (value >= (1000000 * 10 * 100) &&
          value < (1000000 * 10 * 100 * 100)) {
        int result = value ~/ (1000000 * 10 * 100);
        return "${result.toStringAsFixed(0)}B";
      } else if (value >= (1000000 * 10 * 100 * 100) &&
          value < (1000000 * 10 * 100 * 100 * 100)) {
        int result = value ~/ (1000000 * 10 * 100 * 100);
        return "${result.toStringAsFixed(0)}T";
      } else {
        // Handle the case when none of the conditions match
        return value.toStringAsFixed(0); // Default to original value
      }
    } catch (e) {
      return null; // Return null in case of any exception
    }
  }
}
