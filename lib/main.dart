import 'package:flutter/material.dart';
import 'file_pick.dart';
import 'dart:io';
import 'dart:convert';

String? file, folder;
Function(List<dynamic>) display = stageOverlayer;

/// run it.
void main(List<String> args) async {
  // process stupid args
  for (var a in args) {
    // available args are just folder and file, and they should not have an equals sign in them (hopefully)
    if (a.startsWith("folder")) {
      folder = a.split("=")[1];
    } else if (a.startsWith("file")) {
      file = a.split("=")[1];
    } else if (a.startsWith("mode")) {
      display = a == "timeline" ? runVisualizer : stageOverlayer; // note that this is bad.
    }
  }

  if (folder != null) {
    // read all files using probably the most incorrect way possible
    List<String> jsons = [];
    Directory dir = Directory(folder!);

    // hopefully ok use of promises -- or well futures
    await Future.wait(dir
        .listSync()
        .map((fil) => File(fil.path).readAsBytes().then((res) {
              String jason = const Utf8Decoder().convert(res.toList());
              jsons.add(jason);
            }))
        .toList());

    display(jsons);
  } else if (file != null) {
    // file read
    await File(file!).readAsBytes().then((res) {
      String jason = const Utf8Decoder().convert(res.toList());
      display([jason]);
    });

    // default mode: add a main menu
  } else {
    runApp(const FilePick(
      defaultDisplayMode: DisplayMode.stageOverlayer, // default display mode
    ));
  }
}
