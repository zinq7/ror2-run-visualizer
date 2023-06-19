import 'stage_helper.dart';
import '../util.dart';
import 'stage.dart';
import 'package:flutter/material.dart';

/// Visualizes a run, with items from each stage on a timeline
class RunVisualizer extends StatelessWidget {
  final String json;
  const RunVisualizer({super.key, required this.json});

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
        background: const AssetImage(
          "lib/assets/misc/background.jpg",
        ),
      ),
    );
  }
}

/// The Scaffold Widget that displays all the info about the stages
class StageDisplayer extends StatelessWidget {
  final List<Stage> stages;
  final String runTitle;
  final FloatingActionButton? button;
  final ImageProvider background;

  const StageDisplayer({
    super.key,
    required this.stages,
    required this.runTitle,
    required this.background,
    this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image(
          image: background,
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
          floatingActionButton: button,
        ),
      ], // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
