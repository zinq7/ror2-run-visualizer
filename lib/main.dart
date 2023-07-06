import 'package:flutter/material.dart';
import 'file_pick.dart';
import 'dart:io';
import 'dart:convert';
import './testing/pog_out.dart';

/// run it.
void main() {
  var map = "snowyforest";
  var path = "D:/Flutter/stages/Images/MAP_${map!.toUpperCase()}_TITLE/";
  print(path);
  runApp(const FilePick());
  //runApp(PogOut(folder: path));
}
