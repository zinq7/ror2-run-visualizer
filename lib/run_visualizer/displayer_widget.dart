import 'package:flutter/material.dart';
import 'stage.dart';

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
