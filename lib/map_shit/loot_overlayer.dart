import 'package:flutter/material.dart';
import 'package:test_app/map_shit/event_overlayer.dart';
import 'package:test_app/map_shit/map_to_image_helper.dart' as map_helper;
import 'package:test_app/util.dart';

class LootOverlayer extends StatefulWidget {
  final List loot;
  const LootOverlayer({super.key, required this.loot});

  @override
  State<StatefulWidget> createState() => _LootOverlayerState();
}

class _LootOverlayerState extends State<LootOverlayer> {
  double iconVsItemOpacity = -1; // -1; icons; 1: items, 0: both

  @override
  Widget build(BuildContext context) {
    List<Widget> loot = [];

    for (var loot_thing in widget.loot) {
      String? interactablePortrait = getInteractablePortrait(loot_thing);
      List<String> lootPortraits = getItemPortraitFromInteractable(loot_thing);

      if (interactablePortrait == null) continue;

      var size = [64.0, 64.0];

      loot.add(
        LayoutId(
          id: loot_thing.hashCode,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
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
                  image: AssetImage(interactablePortrait),
                  width: size[0],
                  height: size[1],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      color: const Color.fromARGB(255, 67, 87, 111),
      child: Center(
        child: Stack(
          children: [
            Image.asset(
              map_helper.stageMap["Distant Roost"]!["image"] as String,
              width: 1028,
              height: 508,
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: 1028,
              height: 508,
              child: CustomMultiChildLayout(
                delegate: RatiodItemOverlayer(
                  ratio: map_helper.stageMap["Distant Roost"]!["ratio"] as Function,
                  events: widget.loot,
                  isEvent: false,
                ),
                children: loot,
              ),
            )
          ],
        ),
      ),
    );
  }
}
