import 'package:flutter/material.dart';
import 'map_to_image_helper.dart';
import '../util.dart';

class StageOverlayer extends StatelessWidget {
  final List stageItems;
  final double startTime;
  const StageOverlayer({super.key, required this.stageItems, this.startTime = 0});

  void makeItemImageList(List<Widget> w, List<dynamic> items) {
    for (Map item in items) {
      var itemName = item["item"]["englishName"];
      String portraitURL = getPortraitFromEvent(item);
      w.add(
        LayoutId(
          id: item.hashCode,
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
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // get list
    List<Widget> itemEvents = [];
    makeItemImageList(itemEvents, stageItems);

    // it's a stack ig
    return Stack(
      children: [
        Image.asset(stageMap["Siphoned Forest"]!["image"] as String),
        CustomMultiChildLayout(
          delegate: EventOverlayerDelegate(
            events: stageItems,
            ratio: stageMap["Siphoned Forest"]!["ratio"] as Function,
          ),
          children: itemEvents,
        ),
      ],
    );
  }
}

class EventOverlayerDelegate extends MultiChildLayoutDelegate {
  List events;
  Function ratio;
  Offset offset;
  EventOverlayerDelegate({required this.events, required this.ratio, this.offset = Offset.zero});

  @override
  void performLayout(Size size) {
    for (Map item in events) {
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
      print("SIZE IS $size");

      var percents = ratio(item["x"], item["z"], size.width, size.height);
      print("Location is $percents");
      positionChild(
        item.hashCode,
        offset + Offset(percents[0], percents[1]), // inherent 64 offset, top left corner
      );
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false; // no need YET
  }
}
