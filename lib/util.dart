// ignore_for_file: unused_local_variable

/// Takes a [time] and returns the min:sec string representation
String timeFormat(double time) {
  time = time / 1000; // milliseconds
  return "${(time / 60).floor()}:${time % 60 < 10 ? "0" : ""}${(time % 60).floor()}";
}

/// gets a portrait for a [json] interactable object if application
String? getInteractablePortrait(Map interactable) {
  const iconPath = "lib/assets/icons/";
  String interact = interactable["interactorName"] ?? "";
  if (interact == "") interact = "blank";

  return "$iconPath$interact.png";
}

List<String> getItemPortraitFromInteractable(Map interactable) {
  const itemPath = "lib/assets/items/";

  var list = <String>[];
  for (Map item in interactable["loot"]) {
    var name = item["nameToken"] ?? "blank";
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
    return "${basePath}icons/TELEPORTER_NAME.png";

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

    // footprints -> don't draw these
  } else if (eventType == "CharacterExistEvent") {
    return "hidden";

    // spawn in
  } else if (eventType == "SpawnInEvent") {
    String bodyName = event["character"];
    return "$body$bodyName.png";

    // NONE OF THE ABOVE
  } else {
    return null;
  }
}
