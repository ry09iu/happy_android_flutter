class TimeUtil {
  static String convertTime(var time) {
    String ret;
    try {
      ret = DateTime.fromMillisecondsSinceEpoch(time)
          .toLocal()
          .toString()
          .substring(0, 19);
    } catch (e) {
      ret = time.toString();
    }
    return ret;
  }
}
