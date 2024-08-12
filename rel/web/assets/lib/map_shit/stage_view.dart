import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:test_app/map_shit/event_overlayer.dart';
import 'package:test_app/map_shit/loot_overlayer.dart';
import 'package:test_app/util.dart';

/// Visualizes a run, with items from each stage on a timeline
class StageView extends StatefulWidget {
  final List<String> jsons;
  const StageView({super.key, required this.jsons});

  @override
  State createState() => StageViewState();
}

class StageViewState extends State<StageView> {
  int _currentStage = 0;
  double _slider = 0.0;
  ViewMode _mode = ViewMode.events;
  String _followPlayer = "All";

  late Map mainJson;
  late List<String> players;
  late double minStart, maxEnd;

  void changeStage(int stage) {
    setState(() {
      if (stage >= mainJson["stageLoots"].length) stage = 0;
      if (stage < 0) stage = mainJson["stageLoots"].length - 1;
      _currentStage = stage;
    });
  }

  void slideSlider(double newVal) {
    setState(() {
      _slider = newVal;
    });
  }

  void clickViewMode() {
    setState(() {
      const viewCycle = [ViewMode.events, ViewMode.loot]; //... more
      int current = viewCycle.indexOf(_mode);
      current++;
      if (current >= viewCycle.length) current = 0;

      _mode = viewCycle[current];
    });
  }

  void changeDropdown(String? person) {
    setState(() {
      _followPlayer = person ?? "All";
    });
  }

  String getModeName() {
    switch (_mode) {
      case ViewMode.events:
        return "Event Overlay";
      case ViewMode.loot:
        return "Loot Overlay";
      default:
        return "???";
    }
  }

  List<Widget> getBottomBar(List<dynamic> events) {
    var slider = FractionallySizedBox(
      widthFactor: 0.3,
      child: Slider(
        label: "Slider Opacity",
        value: _slider,
        secondaryTrackValue: 0.5,
        onChanged: slideSlider,
      ),
    );

    switch (_mode) {
      case ViewMode.loot:
        return [
          const Text("Interactable Opacity"),
          slider,
          const Text("Loot Opacity"),
        ];
      case ViewMode.events:
        minStart = 999999999;
        maxEnd = -1;
        for (var play in events) {
          minStart = min(play[0]["timestamp"], minStart);
          maxEnd = max(play[play.length - 1]["timestamp"], maxEnd);
        }

        return [
          Text(timeFormat(minStart)),
          slider,
          Text(timeFormat(maxEnd)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
            ),
            child: DropdownButton<String>(
              value: _followPlayer,
              dropdownColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              borderRadius: BorderRadius.circular(24),
              items: players.map((per) {
                return DropdownMenuItem(
                  value: per,
                  child: Text(
                    per,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: changeDropdown,
            ),
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    mainJson = jsonDecode(widget.jsons[0]);

    // var stageEvents = getStageEvents(jsonDecode(json))[0];
    var stageItems = mainJson["stageLoots"][_currentStage]["stageLoot"];
    var mapName = mainJson["stageLoots"][_currentStage]["stageName"];

    // add all the people's jsons (while separating by stage)
    var stageEvents = [];
    players = ["All"];
    for (int i = 0; i < widget.jsons.length; i++) {
      var indivJson = jsonDecode(widget.jsons[i]);

      // load players
      String player = indivJson["player"];
      players.add(player);

      if (_followPlayer == "All" || player == _followPlayer) {
        List<dynamic> initial = indivJson["runEvents"];

        // search for correct stage info
        int stage = 0, stIndex = 0, stEndIndex = 0;
        for (int i = 0; i < initial.length; i++) {
          Map ev = initial[i];
          if (ev["eventType"] == "StageStartEvent") {
            stage++;
            stIndex = stEndIndex;
            stEndIndex = i;

            if (stage - 1 == _currentStage) {
              break;
            }
          }
        }

        // fix stage events (including the last stage)
        if (stage - 1 != _currentStage) {
          initial = initial.sublist(stEndIndex);
        } else {
          initial = initial.sublist(stIndex, stEndIndex);
        }

        stageEvents.add(initial);
      }
    }

    return MaterialApp(
      title: 'Run Visualizer',
      theme: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
        dropdownMenuTheme: const DropdownMenuThemeData(
          textStyle: TextStyle(
            color: Colors.white,
            backgroundColor: Colors.black,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          alignedDropdown: true,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color.fromARGB(255, 116, 188, 255),
            fontFamily: "Comic Sans",
            fontStyle: FontStyle.italic,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ),

        primaryTextTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color.fromARGB(255, 116, 188, 255),
            fontFamily: "Comic Sans",
            fontStyle: FontStyle.italic,
          ),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0), //const Color.fromARGB(75, 125, 127, 128),
      ),
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: InteractiveViewer(
            maxScale: 10,
            child: (() {
              switch (_mode) {
                case ViewMode.loot:
                  return LootOverlayer(
                    loot: stageItems,
                    mapName: mapName,
                    opacity: _slider,
                  );
                case ViewMode.events:
                  return EventOverlayer(
                    stageEvents: stageEvents,
                    startTime: stageEvents[0][0]["timestamp"],
                    stageName: mapName,
                    currentTime: 0,
                  );
              }
            }()),
          ),
          floatingActionButton: TextButton(
            onPressed: () {
              clickViewMode();
            },
            child: Text("Mode: ${getModeName()}"),
          ),
          persistentFooterAlignment: AlignmentDirectional.bottomCenter,
          persistentFooterButtons: <Widget>[
            TextButton(
              child: const Text("PREVIOUS STAGE"),
              onPressed: () {
                changeStage(_currentStage - 1);
              },
            ),
            ...getBottomBar(stageEvents),
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

enum ViewMode { events, loot }
