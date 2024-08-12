import 'dart:math';
import 'package:flutter/material.dart';
import 'map_to_image_helper.dart';
import '../util.dart';

class EventOverlayer extends StatelessWidget {
  final List<dynamic> stageEvents;
  final double startTime, currentTime;
  final String stageName;
  const EventOverlayer({super.key, required this.stageEvents, required this.stageName, this.startTime = 0, this.currentTime = 0});

  // create the list of images to overlay (in the form of widgets)
  void makeImageList(List<Widget> w, List<dynamic> events) {
    for (Map item in events) {
      List<double?> size = (item["eventType"] == "CharacterExistEvent") ? [32, 32] : [64, 64];
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
                  return [];
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
    List<Widget> extraItems = [];

    // don't show items with multiple players /
    if (stageEvents.length == 1) {
      List<Widget> events = [];
      makeImageList(events, stageEvents[0]);

      extraItems.add(
        CustomMultiChildLayout(
          delegate: RatiodItemOverlayer(
            events: stageEvents[0],
            ratio: stageMap[stageName]!["ratio"] as Function,
          ),
          children: events,
        ),
      );
    } else {
      for (int i = 1; i < stageEvents.length; i++) {
        extraItems.add(
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: LinePainter(
              events: stageEvents[i],
              ratio: stageMap[stageName]!["ratio"] as Function,
              hueShift: i * 20,
            ),
          ),
        );
      }
    }

    // it's a stack ig
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          stageMap[stageName]!["image"] as String,
          fit: BoxFit.fill,
        ),
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: LinePainter(
            events: stageEvents[0],
            ratio: stageMap[stageName]!["ratio"] as Function,
          ),
        ),
        ...extraItems,
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
  final int hueShift;
  final List events;
  final Function ratio;
  const LinePainter({
    required this.events,
    required this.ratio,
    this.hueShift = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const Color preTp = Color.fromARGB(185, 29, 202, 38), postTp = Color.fromARGB(162, 219, 33, 33), midTp = Color.fromARGB(188, 61, 128, 252);
    const List<Color> lineColors = [preTp, midTp, postTp];
    int tpColor = 0;

    Offset? oldPos;
    for (var event in events) {
      if (event["eventType"].contains("Charge")) tpColor++;

      if (getPortraitFromEvent(event) == null) continue;
      if (event["x"] == 0 && event["z"] == 0) continue;

      if (oldPos == null) {
        var percents = ratio(event["z"], event["x"], size.width, size.height);
        oldPos = Offset(percents[0], percents[1]);
      } else {
        var percents = ratio(event["z"], event["x"], size.width, size.height);
        Offset newPos = Offset(percents[0], percents[1]);

        var pnt = Paint();
        var clr = lineColors[min(tpColor, lineColors.length)];
        // add hue shift
        clr = HSLColor.fromColor(clr).withHue(HSLColor.fromColor(clr).hue + hueShift).toColor();
        pnt.color = clr;
        pnt.strokeWidth = 4;
        canvas.drawLine(
          oldPos,
          newPos,
          pnt,
        );
        oldPos = newPos;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
