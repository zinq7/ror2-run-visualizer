// ignore_for_file: unused_local_variable

import 'dart:ui';

/// Takes a [time] and returns the min:sec string representation
String timeFormat(double time) {
  time = time / 1000; // milliseconds
  return "${(time / 60).floor()}:${time % 60 < 10 ? "0" : ""}${(time % 60).floor()}";
}

/// gets a portrait for a [json] interactable object if application
String? getInteractablePortrait(Map interactable) {
  const iconPath = "lib/assets/icons/";

  return "$iconPath${interactable["interactorName"]}.png";
  // return null;
}

List<List<num>> positionMultiItems(int count, List<num> pos) {
  switch (count) {
    case 1:
      // single centered
      return [
        [0, 0],
      ];
    case 2:
      // side by side
      return [
        [-pos[0] / 2, 0],
        [pos[0] / 2, 0],
      ];
    case 3:
      // triangle with single top
      return [
        [-pos[0] / 2, -pos[1] / 2], // bottom left
        [pos[0] / 2, -pos[1] / 2], // bottom right
        [0, pos[1] / 2], // top
      ];
    case 4:
      // four corners square
      return [
        [-pos[0] / 2, -pos[1] / 2], // bottom left
        [-pos[0] / 2, pos[1] / 2], // top left
        [pos[0] / 2, -pos[1] / 2], // bottom right
        [pos[0] / 2, -pos[1] / 2], // top right
      ];
  }
  return [] as List<List<num>>;
}

List<String> getItemPortraitFromInteractable(Map interactable) {
  const itemPath = "lib/assets/items/";

  var list = <String>[];
  for (Map item in interactable["loot"]) {
    var name = item["nameToken"];
    list.add("$itemPath$name.png");
  }

  return list;
}

/// gets a portrait for a [json] event, including portraits for **items, bodies, stages, and misc/assets**
String? getPortraitFromEvent(Map event) {
  const basePath = "lib/assets/";
  const inv = "${basePath}items/";
  const body = "${basePath}bodies/";
  const stage = "${basePath}stages/";
  const misc = "${basePath}misc/";

  String eventType = event["eventType"];

  // items
  if (event["eventType"] == "InventoryEvent") {
    return "$inv${event["item"]["englishName"]}.png";

    // tp start is visible, end doesn't matter
  } else if (eventType == "ChargeStartEvent") {
    return "${misc}teleporter.png";

    // tp end is a null boi
  } else if (eventType == "TeleportHitEvent") {
    return "hidden";

    // fucking dying
  } else if (eventType == "DeathEvent") {
    return "${misc}DeathEvent.png";

    // getting killed
  } else if (eventType == "KillEvent") {
    return "$body${event["killerBody"]}.png";

    // bosses
  } else if (eventType == "BossKillEvent" || eventType == "BossSpawnEvent") {
    String bossName = event["boss"];
    return "$body$bossName.png";

    // footprints
  } else if (eventType == "CharacterExistEvent") {
    return "${misc}feet.png";

    // spawn in
  } else if (eventType == "SpawnInEvent") {
    String bodyName = event["character"];
    return "$body$bodyName.png";

    // NONE OF THE ABOVE
  } else {
    return null;
  }
}
