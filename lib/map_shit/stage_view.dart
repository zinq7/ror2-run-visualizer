import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_app/map_shit/event_overlayer.dart';
import 'package:test_app/map_shit/loot_overlayer.dart';
import 'package:test_app/run_visualizer/stage_helper.dart';

/// Visualizes a run, with items from each stage on a timeline
class StageView extends StatelessWidget {
  final String json;
  const StageView({super.key, required this.json});

  @override
  Widget build(BuildContext context) {
    var stageEvents = getStageEvents(jsonDecode(json))[0];
    var stageItems = getStageItems(jsonDecode(json));
    // var s1ItemEvents = analyzeStage(stageEvents[0], "idc").itemGains;

    return Material(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: LootOverlayer(
          loot: stageItems,
        ),
      ),
    );
  }
}
