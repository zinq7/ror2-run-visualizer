import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'run_visualizer.dart';
import 'dart:convert';

/// Visualizes a run, with items from each stage on a timeline
class FilePick extends StatelessWidget {
  const FilePick({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: InkWell(
          onTap: () {
            var res = FilePicker.platform.pickFiles(withData: true, type: FileType.custom, allowedExtensions: [".run.json"]);
            res.then((response) {
              var lst = response?.files[0].bytes;
              if (lst != null) {
                String json = const Utf8Decoder().convert(lst.toList());
                print('wtf');
                runApp(RunVisualizer(json: json));
              } else {
                print("ERROR ERROR");
              }
            });
          },
          child: Image(
            image: const AssetImage("lib/assets/misc/select_file.png"),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}