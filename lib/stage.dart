import 'dart:math';

import 'package:flutter/material.dart';
import 'util.dart';
import 'dart:io';
import 'main.dart';
import 'item_icon.dart';

class Stage extends StatelessWidget {
  final List<dynamic> itemGains, itemLosses, bosses;
  final String stageName;
  final double startTime, endTime;
  final int stageNum;
  final TextStyle textStyle;
  const Stage({
    super.key,
    required this.itemGains,
    required this.itemLosses,
    required this.stageName,
    required this.startTime,
    required this.endTime,
    required this.stageNum,
    required this.bosses,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontStyle: FontStyle.normal,
      fontFamily: "Raleway",
    ),
  });

  void makeBossImageList(List boss, List bosses) {
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
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    width: 1,
                    color: const Color.fromARGB(255, 44, 44, 44),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: FileImage(File("./lib/assets/body_portraits_english_x/$bossName.png")),
                  ),
                ),
              ),
              Text(
                timeFormat(event["timestamp"] - startTime).toString(),
                style: textStyle,
              ),
            ],
          ),
        ),
      );
    }
  }

  void makeItemImageList(List<Widget> w, List<dynamic> items) {
    for (int i = 0; i < items.length; i++) {
      var item = items[i];
      var itemName = item["item"]["englishName"];
      w.add(
        LayoutId(
          id: item.hashCode,
          child: ItemIcon(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(136, 0, 0, 0), //Color.fromARGB(192, 119, 119, 119),
                    border: Border.all(
                      width: 0.05,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image(
                    image: FileImage(File("./lib/assets/item_icons_english/$itemName.png")),
                    width: 64,
                    height: 64,
                  ),
                ),
                Text(
                  timeFormat(item["timestamp"] - startTime).toString(),
                  style: textStyle,
                ),
              ],
            ),
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
    makeBossImageList(boss, bosses); // not clear but ok

    // minor fix if you lose no items, still add an empty box. needs a layout ID to be processed.
    if (losses.isEmpty) {
      var item = {'timestamp': startTime, "eventType": "ballsEvent"};
      itemLosses.add(item);
      losses.add(
        LayoutId(
          id: item.hashCode,
          child: const SizedBox(
            width: 64,
            height: 64,
          ),
        ),
      );
    }

    var stageImage = Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
          color: Colors.black,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
        child: Image(
          image: FileImage(
            File("./lib/assets/stage_icons_english_dash/${stageName.replaceFirst(RegExp(r":"), " -")}.png"),
          ),
          width: 156,
          height: 94,
        ),
      ),
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
                        offset: const Offset(0, -26), // magic number alert, but it works :)
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
        Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            border: Border.all(
              color: Colors.black,
              width: 4,
            ),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Text(
            "Time: $timeRep",
            textScaleFactor: 3.0,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
          ),
        ),
      ],
    );
  }
}
