import 'dart:math';

import 'package:flutter/material.dart';
import 'map_to_image_helper.dart';
import '../util.dart';
import 'dart:ui';

class EventOverlayer extends StatelessWidget {
  final List stageEvents;
  final double startTime;
  const EventOverlayer({super.key, required this.stageEvents, this.startTime = 0});

  void makeImageList(List<Widget> w, List<dynamic> events) {
    for (Map item in events) {
      List<double?> size = (item["eventType"] == "CharacterExistEvent") ? [16, 16] : [64, 64];
      String? portraitURL = getPortraitFromEvent(item); // helper to get image

      if (portraitURL == null) continue; // can't find portrait
      if (item["x"] == 0 && item["z"] == 0) continue; // world event, we ignore in THIS one

      // add the widget
      w.add(
        LayoutId(
          id: item.hashCode,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ...(() {
                if (item["eventType"] != "CharacterExistEvent" && portraitURL != "hidden") {
                  return [
                    Container(
                      height: size[0],
                      width: size[1],
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(136, 0, 0, 0), //Color.fromARGB(192, 119, 119, 119),
                        border: Border.all(
                          width: 0.05,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image(
                        image: AssetImage(portraitURL),
                        width: size[0],
                        height: size[1],
                      ),
                    ),
                    Text(
                      timeFormat(item["timestamp"] - startTime).toString(),
                    ),
                  ];
                } else if (portraitURL != "hidden") {
                  return [
                    Image(
                      image: AssetImage(portraitURL),
                      width: size[0],
                      height: size[1],
                    )
                  ];
                } else {
                  print("hidden");
                  return [Text("balls")];
                }
              }()),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // get list
    List<Widget> events = [];
    makeImageList(events, stageEvents);

    // it's a stack ig
    return Stack(
      children: [
        Image.asset(stageMap["Siphoned Forest"]!["image"] as String),
        CustomMultiChildLayout(
          delegate: RatiodItemOverlayer(
            events: stageEvents,
            ratio: stageMap["Siphoned Forest"]!["ratio"] as Function,
          ),
          children: events,
        ),
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: LinePainter(
            events: stageEvents,
            ratio: stageMap["Siphoned Forest"]!["ratio"] as Function,
          ),
        ),
      ],
    );
  }
}

class RatiodItemOverlayer extends MultiChildLayoutDelegate {
  List events;
  Function ratio;
  Offset offset;
  bool isEvent;
  RatiodItemOverlayer({required this.events, required this.ratio, this.offset = Offset.zero, this.isEvent = true});

  @override
  void performLayout(Size size) {
    for (Map item in events) {
      if ((isEvent && getPortraitFromEvent(item) == null) || getInteractablePortrait(item) == null) continue;
      if (item["x"] == 0 && item["z"] == 0) continue;

      // set constraints
      layoutChild(
        item.hashCode,
        const BoxConstraints(
          maxHeight: 64,
          minHeight: 64,
          maxWidth: 64,
          minWidth: 64,
        ),
      );

      var percents = ratio(item["z"], item["x"], size.width, size.height);
      Offset thisPos = offset +
          Offset(percents[0], percents[1]) -
          (item["eventType"] == "CharacterExistEvent" ? const Offset(16, 16) : const Offset(32, 32)); // inherent 64 offset, top left corner

      // position it
      positionChild(
        item.hashCode,
        thisPos,
      );
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false; // no need YET
  }
}

class LinePainter extends CustomPainter {
  final List events;
  final Function ratio;
  const LinePainter({
    required this.events,
    required this.ratio,
  });

  @override
  void paint(Canvas canvas, Size size) {
    print("PAINTING, NERD $size, ${canvas.runtimeType}");
    const Color preTp = Color.fromARGB(185, 29, 202, 38), postTp = Color.fromARGB(162, 219, 33, 33), midTp = Color.fromARGB(188, 61, 128, 252);
    const List<Color> lineColors = [preTp, midTp, postTp];
    int tpColor = 0;

    Offset? oldPos;
    for (var event in events) {
      if (getPortraitFromEvent(event) == null) continue;
      if (event["x"] == 0 && event["z"] == 0) continue;

      if (oldPos == null) {
        var percents = ratio(event["z"], event["x"], size.width, size.height);
        oldPos = Offset(percents[0], percents[1]);
      } else {
        var percents = ratio(event["z"], event["x"], size.width, size.height);
        Offset newPos = Offset(percents[0], percents[1]);

        var pnt = Paint();
        pnt.color = lineColors[min(tpColor, lineColors.length)];
        pnt.strokeWidth = 4;
        canvas.drawLine(
          oldPos,
          newPos,
          pnt,
        );
        oldPos = newPos;
      }

      if (event["eventType"].contains("Charge")) tpColor++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
