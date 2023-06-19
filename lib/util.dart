/// Takes a time and returns the min:sec string representation
String timeFormat(double time) {
  return "${(time / 60).floor()}:${time % 60 < 10 ? "0" : ""}${(time % 60).floor()}";
}
