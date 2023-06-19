import 'dart:io';
import 'stage_helper.dart';
import '../util.dart';
import 'stage.dart';
import 'package:flutter/material.dart';

/// Visualizes a run, with items from each stage on a timeline
class RunVisualizer extends StatelessWidget {
  final String json;
  const RunVisualizer({super.key, required this.json});

  Stage analyzeStage(List stage, String nextStage) {
    List<dynamic> gains = [], losses = [], bosses = []; // yes
    String stageName = "none";
    int stageNum = -1;
    double startTime, endTime, duration;

    // first event stageStart, last stageSplit
    startTime = stage[0]["timestamp"];
    endTime = stage[stage.length - 1]["timestamp"];
    duration = endTime - startTime;
    print("start: $startTime, end: $endTime, length: $duration");

    // items in stages
    for (int i = 0; i < stage.length; i++) {
      var event = stage[i]; // get ev

      switch (event["eventType"]) {
        // stage start
        case "StageStartEvent":
          stageName = event["stageNum"] == 6 ? "Commencement" : event["englishName"];
          stageNum = event["stageNum"];
          if (stageNum == 5) nextStage = "Commencement";
          break;

        // inventory event
        case "InventoryEvent":
          if (event["quantity"] == 0) break; // in case JSON is fucked
          if (event["transactionType"] == 5 && event["quantity"] > 0) break; // double logging voids whoops
          (event["quantity"] > 0 ? gains : losses).add(event); // faster
          break;

        // boss event
        case "BossKillEvent":
          bosses.add(event);
          break;
      }
    }

    return Stage(
      stageNum: stageNum,
      startTime: startTime,
      endTime: endTime,
      itemGains: List<dynamic>.from(gains),
      itemLosses: List<dynamic>.from(losses),
      stageName: stageName,
      bosses: bosses,
      nextStage: nextStage,
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Stage> stages = List<Stage>.empty(growable: true); // yes

    // get stage events
    List stageJSONs = getStageEvents(json);
    double totalTime = 0;

    // loop through stage
    for (int k = 0; k < stageJSONs.length; k++) {
      String nextStage = "";
      if (k + 1 < stageJSONs.length) nextStage = stageJSONs[k + 1][0]["englishName"];
      stages.add(analyzeStage(stageJSONs[k], nextStage));
      print('analyzing stage ${stageJSONs[k][0]["englishName"]}');
      totalTime += stages[k].endTime - stages[k].startTime;
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
        runTitle: "Sample Run - played by the amazing player 'zinq' in ${timeFormat(totalTime)}",
        stages: stages,
      ),
    );
  }
}

/// The Scaffold Widget that displays all the info about the stages
class StageDisplayer extends StatelessWidget {
  final List<Stage> stages;
  final String runTitle;

  const StageDisplayer({super.key, required this.stages, required this.runTitle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image(
          image: const AssetImage(
            "lib/assets/misc/background.jpg",
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(206, 0, 0, 0),
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(runTitle,
                textScaleFactor: 2.0,
                style: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                )),
            automaticallyImplyLeading: true,
            toolbarHeight: 60,
          ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: stages,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {},
          ),
        ),
      ], // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
