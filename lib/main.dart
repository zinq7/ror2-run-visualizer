import 'dart:io';
import 'dart:convert';
import 'stage_helper.dart';
import 'util.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const RunVisualizer());
}

class RunVisualizer extends StatelessWidget {
  const RunVisualizer({super.key});

  Stage analyzeStage(List stage) {
    List<dynamic> gains = List<dynamic>.empty(growable: true), losses = List<dynamic>.empty(growable: true); // yes
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
          break;

        // inventory event
        case "InventoryEvent":
          if (event["quantity"] == 0) break; // in case JSON is fucked
          if (event["transactionType"] == 5 && event["quantity"] > 0) break; // double logging voids whoops
          (event["quantity"] > 0 ? gains : losses).add(event["item"]); // faster
          break;

        // boss event
        case "BossKillEvent":
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
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Stage> stages = List<Stage>.empty(growable: true); // yes

    // get stage events
    var jsonString = File("./lib/assets/run.json").readAsStringSync();
    List stageJSONs = getStageEvents(jsonString);
    double totalTime = 0;

    // loop through stage
    for (int k = 0; k < stageJSONs.length; k++) {
      stages.add(analyzeStage(stageJSONs[k]));
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
            color: Colors.white,
            fontFamily: "Comic Sans",
            fontStyle: FontStyle.italic,
          ),
        ),
        scaffoldBackgroundColor: Colors.grey[500],
      ),
      home: StageDisplayer(
        runTitle: "Sample Run - played by the amazing player 'zinq' in ${timeFormat(totalTime)}",
        stages: stages,
      ),
    );
  }
}

class Stage extends StatelessWidget {
  final List<dynamic> itemGains, itemLosses;
  final String stageName;
  final double startTime, endTime;
  final int stageNum;
  const Stage(
      {super.key,
      required this.itemGains,
      required this.itemLosses,
      required this.stageName,
      required this.startTime,
      required this.endTime,
      required this.stageNum});

  void makeItemImageList(List<Widget> w, List<dynamic> items) {
    for (int i = 0; i < items.length; i++) {
      var item = items[i];
      var itemName = item["englishName"];
      w.add(
        Image(
          image: FileImage(File("./lib/assets/item_icons_english/$itemName.png")),
          width: 64,
          height: 64,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> gains = List<Widget>.empty(growable: true), losses = List<Widget>.empty(growable: true);

    makeItemImageList(gains, itemGains);
    makeItemImageList(losses, itemLosses);

    // minor fix if you lose no items
    if (losses.isEmpty) {
      losses.add(const SizedBox(
        width: 64,
        height: 64,
      ));
    }

    Image stageImage = Image(
      image: FileImage(
        File("./lib/assets/stage_icons_english_dash/${stageName.replaceFirst(RegExp(r":"), " -")}.png"),
      ),
      width: 156,
      height: 156,
    );

    String timeRep = "${timeFormat(endTime - startTime)}  ";

    return Row(
      children: [
        Text(
          "#$stageNum: ",
          textScaleFactor: 3.0,
        ),
        stageImage,
        Expanded(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: gains,
              ),
              const Expanded(
                flex: 0,
                child: Divider(
                  indent: 0,
                  endIndent: 0,
                  thickness: 5.0,
                  color: Colors.black87,
                  height: 5,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: losses,
              ),
            ],
          ),
        ),
        Text(
          "Time: $timeRep",
          textScaleFactor: 3.0,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        ),
      ],
    );
  }
}

class StageDisplayer extends StatelessWidget {
  final List<Stage> stages;
  final String runTitle;

  const StageDisplayer({super.key, required this.stages, required this.runTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: stages),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
