import 'stage_helper.dart';
import '../util.dart';
import 'stage.dart';
import 'package:flutter/material.dart';
import 'displayer_widget.dart';
import 'dart:convert';

/// Visualizes a run, with items from each stage on a timeline
class RunVisualizer extends StatelessWidget {
  final String json;
  const RunVisualizer({super.key, required this.json});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Stage> stages = List<Stage>.empty(growable: true); // yes

    // get stage events
    List stageJSONs = getStageEvents(jsonDecode(json));
    double totalTime = 0;

    // loop through stage
    for (int k = 0; k < stageJSONs.length; k++) {
      String nextStage = "";
      if (k + 1 < stageJSONs.length) nextStage = stageJSONs[k + 1][0]["englishName"];
      stages.add(analyzeStage(stageJSONs[k], nextStage));
      // print('analyzing stage ${stageJSONs[k][0]["englishName"]}');
      totalTime += stages[k].endTime - stages[k].startTime;
      var s = stages[stages.length - 1];
      if (s.worldEvents.isNotEmpty) print(s.worldEvents[s.worldEvents.length - 1]);
    }

    return MaterialApp(
      title: 'Run Visualizer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color.fromARGB(255, 185, 185, 185),
            fontFamily: "Comic Sans",
            fontStyle: FontStyle.italic,
          ),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 51, 51, 51), //const Color.fromARGB(75, 125, 127, 128),
      ),
      home: StageDisplayer(
        runTitle: "Sample Run - played by an amazing player in ${timeFormat(totalTime)}",
        stages: stages,
        background: const AssetImage(
          "lib/assets/misc/background.jpg",
        ),
      ),
    );
  }
}
