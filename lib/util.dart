/// Takes a time and returns the min:sec string representation
String timeFormat(double time) {
  return "${(time / 60).floor()}:${time % 60 < 10 ? "0" : ""}${(time % 60).floor()}";
}

String? getPortraitFromEvent(Map event) {
  const basePath = "lib/assets/";
  const inv = "${basePath}item_icons_english/";
  const body = "${basePath}body_portraits_english_x/";
  const stage = "${basePath}stage_icons_english_dash/";
  const misc = "${basePath}misc/";

  String eventType = event["eventType"];

  // items
  if (event["eventType"] == "InventoryEvent") {
    return "$inv${event["item"]["englishName"].replaceAll("?", "x")}.png";

    // tp start is visible, end doesn't matter
  } else if (eventType == "ChargeStartEvent") {
    return "${misc}teleporter.png";

    // tp end is a null boi
  } else if (eventType == "TeleportHitEvent") {
    return "hidden";

    // bosses
  } else if (eventType == "BossKillEvent") {
    String bossName = event["boss"].replaceAll("?", "w");
    List eliteNames = ["Overloading", "Blazing", "Mending", "Glacial"];
    for (String x in eliteNames) {
      bossName = bossName.replaceAll("$x ", "");
    }
    return "$body$bossName.png";

    // footprints
  } else if (eventType == "CharacterExistEvent") {
    return "${misc}feet.png";

    // spawn in
  } else if (eventType == "SpawnInEvent") {
    String bodyName = event["character"].replaceAll("?", "x");
    return "$body$bodyName.png";

    // NONE OF THE ABOVE
  } else {
    return null;
  }
}
