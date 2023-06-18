import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'stage_helper.dart';
import 'util.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const RunVisualizer());
}

class RunVisualizer extends StatelessWidget {
  const RunVisualizer({super.key});

  Stage analyzeStage(List stage) {
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
  final List<dynamic> itemGains, itemLosses, bosses;
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
      required this.stageNum,
      required this.bosses});

  void makeItemImageList(List<Widget> w, List<dynamic> items) {
    for (int i = 0; i < items.length; i++) {
      var item = items[i];
      var itemName = item["item"]["englishName"];
      w.add(
        LayoutId(
          id: item.hashCode,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Image(
                image: FileImage(File("./lib/assets/item_icons_english/$itemName.png")),
                width: 64,
                height: 64,
              ),
              Text(
                timeFormat(item["timestamp"] - startTime).toString(),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> gains = [], losses = [], boss = [];

    makeItemImageList(gains, itemGains);
    makeItemImageList(losses, itemLosses);

    for (final dynamic event in bosses) {
      String bossName = event["boss"].replaceAll("?", "w");
      List eliteNames = ["Overloading", "Blazing", "Mending", "Glacial"];
      for (String x in eliteNames) {
        bossName = bossName.replaceAll("$x ", "");
      }
      boss.add(
        LayoutId(
          id: event.hashCode,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Image(
                image: FileImage(File("./lib/assets/body_portraits_english_x/$bossName.png")),
                width: 64,
                height: 64,
              ),
              Text(
                timeFormat(event["timestamp"] - startTime).toString(),
              ),
            ],
          ),
        ),
      );
    }

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
              SizedBox(
                height: 64,
                child: CustomMultiChildLayout(
                  delegate: PositionItems(
                    stage: this,
                    items: itemGains,
                  ),
                  children: gains,
                ),
              ),
              SizedBox(
                height: 15,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    const Divider(
                      indent: 0,
                      endIndent: 0,
                      thickness: 5.0,
                      color: Colors.black87,
                      height: 5,
                    ),
                    CustomMultiChildLayout(
                      delegate: PositionItems(
                        stage: this,
                        items: bosses,
                        offset: const Offset(0, -32),
                      ),
                      children: boss,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 64,
                child: CustomMultiChildLayout(
                  delegate: PositionItems(
                    stage: this,
                    items: itemLosses,
                  ),
                  children: losses,
                ),
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

class PositionItems extends MultiChildLayoutDelegate {
  List items;
  Stage stage;
  Offset offset;
  PositionItems({required this.stage, required this.items, this.offset = Offset.zero});

  @override
  void performLayout(Size size) {
    for (final dynamic item in items) {
      double time = item["timestamp"];
      double completionPercent = (time - stage.startTime) / (stage.endTime - stage.startTime);
      layoutChild(
        item.hashCode,
        const BoxConstraints(
          maxHeight: 64,
          minHeight: 64,
          maxWidth: 64,
          minWidth: 64,
        ),
      );

      positionChild(
        item.hashCode,
        offset + Offset(completionPercent * size.width, 0),
      );
    }
  }

  @override
  bool shouldRelayout(PositionItems oldItem) {
    return false;
  }
}
