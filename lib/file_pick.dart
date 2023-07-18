import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:test_app/map_shit/stage_view.dart';
import 'package:test_app/run_visualizer/run_compare_visualizer.dart';
import 'run_visualizer/run_visualizer.dart';
import 'dart:convert';

/// Visualizes a run, with items from each stage on a timeline
class FilePick extends StatelessWidget {
  final DisplayMode displayMode;
  const FilePick({super.key, this.displayMode = DisplayMode.runVisualizer});

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
                List<String> jsons = [];

                for (var file in response!.files) {
                  var filyBytes = file.bytes;
                  String json = const Utf8Decoder().convert(filyBytes!.toList());
                  jsons.add(json);
                }

                // handle with json
                switch (displayMode) {
                  case DisplayMode.runVisualizer:
                    runVisualizer(jsons);
                    break;
                  case DisplayMode.stageOverlayer:
                    stageOverlayer(jsons);
                    break;
                  default:
                    break;
                }
              } else {
                // ignore: avoid_print
                throw ("no file selected");
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

void runVisualizer(List jsons) {
  if (jsons.length > 1) {
    runApp(RunComparer(runs: jsons as List<String>));
  } else {
    runApp(RunVisualizer(json: jsons[0]));
  }
}

void stageOverlayer(List jsons) {
  if (jsons.length > 1) {
    throw "not implemented";
    // runApp(RunComparer(runs: jsons as List<String>));
  } else {
    runApp(StageView(json: jsons[0]));
  }
}

enum DisplayMode {
  runVisualizer,
  stageDisplayer,
  stageOverlayer,
}
