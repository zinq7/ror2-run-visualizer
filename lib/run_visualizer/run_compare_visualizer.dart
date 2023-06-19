import 'package:flutter/material.dart';
import 'run_visualizer.dart';
import 'stage_helper.dart';
import 'stage.dart';

class RunComparer extends StatefulWidget {
  final List<String> runs;
  const RunComparer({super.key, required this.runs});

  @override
  State<StatefulWidget> createState() => RunComparerState();
}

class RunComparerState extends State<RunComparer> {
  int _stageNum = 0;
  List playerLengths = [];

  void changeStage(int stage) {
    setState(() {
      for (var x in playerLengths) {
        if (stage >= x) stage = 0;
      }
      _stageNum = stage;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Stage> stages = List<Stage>.empty(growable: true); // yes

    for (var json in widget.runs) {
      // get stage events
      List stageJSONs = getStageEvents(json);
      playerLengths.add(stageJSONs.length);

      // loop through stage
      String nextStage = "";
      if (_stageNum + 1 < stageJSONs.length) nextStage = stageJSONs[_stageNum + 1][0]["englishName"];
      stages.add(analyzeStage(stageJSONs[_stageNum], nextStage));
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
          runTitle: "Comparing A to B",
          stages: stages,
          background: const AssetImage("lib/assets/misc/background_fight.jpg"),
          button: FloatingActionButton(
            onPressed: () {
              changeStage(_stageNum + 1);
            },
            child: const Text(
              "Next Stage",
            ),
          )),
    );
  }
}
