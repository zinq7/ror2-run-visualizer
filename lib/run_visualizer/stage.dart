import 'package:flutter/material.dart';
import '../util.dart';
import 'stage_helper.dart';
import 'item_icon.dart';
import 'dart:convert';

/// Stage is a horizontal widget that lists all info of a stage:
/// The stage number and image;
/// A timeline of item gains + losses, and boss + tps.
/// The next stage and split time
class Stage extends StatelessWidget {
  final List<dynamic> itemGains, itemLosses, bosses;
  final String stageName, nextStage, runner;
  final double startTime, endTime;
  final int stageNum;
  final TextStyle textStyle;
  final SideInfo sideInfo;
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
    this.nextStage = "",
    this.sideInfo = SideInfo.numbers,
    this.runner = "none",
  });

  /// Add a bunch of Widgets into [boss] based on the ones in [bosses]
  void makeBossImageList(List boss, List bosses) {
    for (final dynamic event in bosses) {
      String bossName = event["boss"].replaceAll("?", "w");
      List eliteNames = ["Overloading", "Blazing", "Mending", "Glacial"];
      for (String x in eliteNames) {
        bossName = bossName.replaceAll("$x ", "");
      }

      // The component: confusing
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
                    image: AssetImage("lib/assets/body_portraits_english_x/$bossName.png"),
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
                    image: AssetImage("lib/assets/item_icons_english/$itemName.png"),
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

  Widget getStage(String stageName, BorderRadius corners) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
          color: Colors.black,
        ),
        borderRadius: corners,
      ),
      child: ClipRRect(
        borderRadius: corners * 0.75,
        child: Image(
          image: AssetImage("lib/assets/stage_icons_english_dash/${stageName.replaceFirst(RegExp(r":"), " -")}.png"),
          width: 156,
          height: 94,
        ),
      ),
    );
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

    String timeRep = timeFormat(endTime - startTime);

    var stageImage = getStage(
      stageName,
      const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      ),
    );

    var backStage = Stack(
      alignment: Alignment.center,
      children: [
        getStage(
          nextStage,
          const BorderRadius.only(
            bottomRight: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        Text(
          timeRep,
          textScaleFactor: 4.0,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        ),
      ],
    );

    return Row(
      children: [
        (() {
          if (sideInfo == SideInfo.numbers) {
            return Text(
              "#$stageNum: ",
              textScaleFactor: 3.0,
            );
          } else if (sideInfo == SideInfo.profilePics) {
            String profPic = MAP[runner]!;
            return Container(
              decoration: BoxDecoration(
                color: Colors.black38,
                border: Border.all(
                  color: Colors.black,
                  width: 5,
                ),
              ),
              child: Image.network(
                profPic,
                width: 70,
                height: 70,
              ),
            );
          } else {
            return const Text("f");
          }
        }()),
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
        backStage,
      ],
    );
  }
}

/// MultiChildLayoutDelegate child that positions items in a timeline;
/// Requires a list of items and the parent stage
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
        offset + Offset(completionPercent * (size.width - 64), 0), // inherent 64 offset
      );
    }
  }

  @override
  bool shouldRelayout(PositionItems oldDelegate) {
    return false;
  }
}

const MAP = <String, String>{
  "Cabbage123": "https://yt3.googleusercontent.com/_H-mAz3ZtQ3HQ08ymGa7S4bHVcso-U0NiixDU3D2zFx_2hJiGzOSzUr6OHrs1LRR9J7diYloVA=s176-c-k-c0x00ffffff-no-rj",
  "Nuxlar": "https://static-cdn.jtvnw.net/jtv_user_pictures/0565f80a-60e4-4cb3-a255-b69b3c30d501-profile_image-70x70.png",
  "zinqio": "https://static-cdn.jtvnw.net/jtv_user_pictures/9d1e7994-2ebf-4617-a4f6-8263984b4b79-profile_image-70x70.png",
  "ICap_I": "https://www.ikea.com/ca/en/images/products/knoeckla-step-trash-can-dark-gray__1029080_pe835654_s5.jpg",
  "no_pick": "https://1.bp.blogspot.com/-iCnFX7eWVjs/XR9NQutHXcI/AAAAAAAAJ9k/ISWH3UXgJF8QJdsV6P9wh3agzOwOF_aYgCLcBGAs/s1600/cat-1285634_1920.png"
};
