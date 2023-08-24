import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_app/map_shit/loot_overlayer.dart';
import 'package:test_app/run_visualizer/stage_helper.dart';

/// Visualizes a run, with items from each stage on a timeline
class StageView extends StatefulWidget {
  final String json;
  const StageView({super.key, required this.json});

  @override
  State createState() => StageViewState();
}

class StageViewState extends State<StageView> {
  int _currentStage = 0;
  double _slider = 0;
  late Map json;

  void changeStage(int stage) {
    setState(() {
      if (stage >= json["stageLoots"].length) stage = 0;
      if (stage < 0) stage = json["stageLoots"].length - 1;
      _currentStage = stage;
    });
  }

  void slideSlider(double newVal) {
    print("hello $newVal");
    setState(() {
      _slider = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    json = jsonDecode(widget.json);

    // var stageEvents = getStageEvents(jsonDecode(json))[0];
    var stageItems = json["stageLoots"][_currentStage]["stageLoot"];
    var mapName = json["stageLoots"][_currentStage]["stageName"];

    return Material(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: LootOverlayer(
            loot: stageItems,
            mapName: mapName,
          ),
          persistentFooterAlignment: AlignmentDirectional.bottomCenter,
          persistentFooterButtons: <Widget>[
            TextButton(
              child: const Text("PREVIOUS STAGE"),
              onPressed: () {
                changeStage(_currentStage - 1);
              },
            ),
            const Text("Interactable Opacity"),
            FractionallySizedBox(
              widthFactor: 0.3,
              child: Slider(
                label: "Slider Opacity",
                value: _slider,
                secondaryTrackValue: 0.5,
                onChanged: slideSlider,
              ),
            ),
            const Text("Loot Opacity"),
            TextButton(
              child: const Text("NEXT STAGE"),
              onPressed: () {
                changeStage(_currentStage + 1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
