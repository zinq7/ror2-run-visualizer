import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Stage> stages = List<Stage>.empty(growable: true);

    List<dynamic> gains = List<dynamic>.empty(growable: true),
        losses = List<dynamic>.empty(growable: true);
    String stageName = "none";

    var json = jsonDecode(File("./lib/assets/run.json").readAsStringSync());
    for (int i = 0; i < json['runEvents'].length; i++) {
      var event = json['runEvents'][i];
      if (event["eventType"] == "StageStartEvent") {
        if (stageName != "none") {
          stages.add(
            Stage(
              itemGains: List<dynamic>.from(gains),
              itemLosses: List<dynamic>.from(losses),
              stageName: stageName,
            ),
          );
          print(
              "added a new stage! it has items like ${gains[0]} and ${gains[1]}");
          gains.clear();
          losses.clear();
        }
        if (event["stageNum"] == 6) {
          stageName = "Commencement";
        } else {
          stageName = event["englishName"];
        }
      }

      if (event["eventType"] == "InventoryEvent") {
        if (event["quantity"] > 0) {
          gains.add(event["item"]);
        } else if (event["quantity"] < 0) {
          losses.add(event["item"]);
        }
      }
    }

    return MaterialApp(
      title: 'Run Visualizer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StageDisplayer(
        runTitle: "Sample Run",
        stages: stages,
      ),
    );
  }
}

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

class Stage extends StatelessWidget {
  final List<dynamic> itemGains, itemLosses;
  final String stageName;
  const Stage(
      {super.key,
      required this.itemGains,
      required this.itemLosses,
      required this.stageName});

  @override
  Widget build(BuildContext context) {
    List<Widget> gains = List<Image>.empty(growable: true),
        losses = List<Image>.empty(growable: true);

    makeItemImageList(gains, itemGains);
    makeItemImageList(losses, itemLosses);

    Image stageImage = Image(
      image: FileImage(
        File(
            "./lib/assets/stage_icons_english_dash/${stageName.replaceFirst(RegExp(r":"), " -")}.png"),
      ),
      width: 156,
      height: 156,
    );

    return Row(
      children: [
        stageImage,
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: gains,
            ),
            const Divider(
              indent: 0,
              endIndent: 0,
              thickness: 5.0,
              color: Colors.black87,
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: losses,
            ),
          ],
        )
      ],
    );
  }
}

class StageDisplayer extends StatelessWidget {
  final List<Stage> stages;
  final String runTitle;

  const StageDisplayer(
      {super.key, required this.stages, required this.runTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(runTitle),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, children: stages),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
