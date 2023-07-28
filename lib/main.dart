import 'package:flutter/material.dart';
import 'file_pick.dart';
import './testing/pog_out.dart';
import 'map_shit/stage_view.dart';

/// run it.
void main() {
  var map = "frozenwall";
  var path = "D:/Flutter/stages/Images/MAP_${map.toUpperCase()}_TITLE/";
  print(path);
  runApp(const FilePick(
    displayMode: DisplayMode.runVisualizer,
  ));
  //runApp(PogOut(folder: path));
}
