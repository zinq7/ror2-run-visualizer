import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:test_app/run_visualizer/run_compare_visualizer.dart';
import 'run_visualizer/run_visualizer.dart';
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
            var res = FilePicker.platform.pickFiles(withData: true, type: FileType.custom, allowedExtensions: ["run.json"], allowMultiple: true);
            res.then((response) {
              var lst = response?.files[0].bytes;

              if (lst != null) {
                if (response!.files.length > 1) {
                  List<String> jsons = [];

                  for (var file in response.files) {
                    String json = const Utf8Decoder().convert(lst.toList());
                    jsons.add(json);
                  }
                  runApp(RunComparer(runs: jsons));
                } else {
                  String json = const Utf8Decoder().convert(lst.toList());
                  print('wtf');
                  runApp(RunVisualizer(json: json));
                }
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
