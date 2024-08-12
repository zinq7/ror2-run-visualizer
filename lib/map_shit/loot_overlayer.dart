import 'package:flutter/material.dart';
import 'package:test_app/map_shit/event_overlayer.dart';
import 'package:test_app/map_shit/map_to_image_helper.dart' as map_helper;
import 'package:test_app/util.dart';
import 'package:test_app/map_shit/multiitem_position_delegate.dart';

class LootOverlayer extends StatefulWidget {
  final List loot;
  final String mapName;
  final double opacity;
  const LootOverlayer({super.key, required this.loot, required this.mapName, this.opacity = 0});

  @override
  State<StatefulWidget> createState() => _LootOverlayerState();
}

class _LootOverlayerState extends State<LootOverlayer> {
  // create loot
  Widget createLoot(Map obj, List size, List<String> lootPortraits, double opacity) {
    List<Widget> items = [];
    for (int i = 0; i < lootPortraits.length; i++) {
      items.add(
        LayoutId(
          id: i,
          child: Container(
            height: size[0],
            width: size[1],
            decoration: BoxDecoration(
              color: Color.fromARGB((136 * opacity).toInt(), 0, 0, 0), //Color.fromARGB(192, 119, 119, 119),
              border: Border.all(
                width: 0.05,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image(
              image: AssetImage(lootPortraits[i]),
              width: size[0],
              height: size[1],
              opacity: AlwaysStoppedAnimation(opacity),
            ),
          ),
        ),
      );
    }

    return LayoutId(
      id: obj.hashCode,
      child: SizedBox(
        width: 64,
        height: 64,
        child: CustomMultiChildLayout(
          delegate: PositionMultiItemsDelegate(
            items: lootPortraits,
          ),
          children: items,
        ),
      ),
    );
  }

  // create interactables
  Widget createInteractable(Map map, List size, String interactablePortrait, double opacity) {
    return LayoutId(
      id: map.hashCode,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: size[0],
            width: size[1],
            decoration: BoxDecoration(
              color: Color.fromARGB((136 * opacity).toInt(), 0, 0, 0), //Color.fromARGB(192, 119, 119, 119),
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
              opacity: AlwaysStoppedAnimation(opacity),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> interactables = <Widget>[], loot = <Widget>[];
    String mapName = widget.mapName;

    double interactableOpacity = 1 - widget.opacity;
    double itemOpacity = widget.opacity;

    for (var loot_thing in widget.loot) {
      String? interactablePortrait = getInteractablePortrait(loot_thing);
      List<String> lootPortraits = getItemPortraitFromInteractable(loot_thing);

      if (interactablePortrait == null) continue;

      var size = [64.0, 64.0];

      interactables.add(createInteractable(loot_thing, size, interactablePortrait, interactableOpacity));
      loot.add(createLoot(loot_thing, size, lootPortraits, itemOpacity));
    }

    return Container(
      color: const Color.fromARGB(255, 67, 87, 111),
      child: Center(
        child: SizedBox.expand(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                map_helper.stageMap[mapName]!["image"] as String,
                fit: BoxFit.fill,
              ),
              CustomMultiChildLayout(
                delegate: RatiodItemOverlayer(
                  ratio: map_helper.stageMap[mapName]!["ratio"] as Function,
                  events: widget.loot,
                  isEvent: false,
                ),
                children: interactables,
              ),
              CustomMultiChildLayout(
                delegate: RatiodItemOverlayer(
                  ratio: map_helper.stageMap[mapName]!["ratio"] as Function,
                  events: widget.loot,
                  isEvent: false,
                ),
                children: loot,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
