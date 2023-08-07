import 'stage.dart';

/// Parse the next stage from a JSON and return [the stage, the rest];
List getStage(List json) {
  List lst = json;
  int start = 0, end = lst.indexWhere((element) => element["eventType"] == "StageEndEvent");

  if (end == -1) return [json, null]; // no stageEnd is last stage

  return [lst.sublist(start, end + 1), lst.sublist(end + 1)]; // separate on end
}

/// Get all the stage events, and return them as a list of JSON arrays.
List getStageEvents(Map json) {
  // get events (to start)
  List events = getStage(json["runEvents"]);
  List stageEvents = [];
  int stage = 1;

  // loop through and fill list with stages
  while (events[1] != null && !events[1].isEmpty) {
    stageEvents.add(events[0]); // events[0] is the stage

    events = getStage(events[1]); // events[1] is the rest
    if (events[1] == null) break;
    stage++;

    if (stage > 6) break; // unlikely, but ignore loops
  }

  if (events[0] != null) stageEvents.add(events[0]);
  return stageEvents;
}

List getStageItems(Map json) {
  return json["stageLoots"][0]["stageLoot"];
}

Stage analyzeStage(
  List stage,
  String nextStage, {
  SideInfo leftItem = SideInfo.numbers,
  String runner = "none",
}) {
  // DECLARE VARIABLES FOR ANALYSIS
  List<dynamic> gains = [], losses = [], worldEvents = []; // yes
  String stageName = "none";
  int stageNum = -1;
  double startTime, endTime;

  // first event stageStart, last gstageSplit
  startTime = stage[0]["timestamp"];
  endTime = stage[stage.length - 1]["timestamp"];
  // print("start: $startTime, end: $endTime, length: $duration");

  // items in stages
  for (int i = 0; i < stage.length; i++) {
    var event = stage[i]; // get ev
    // print("event $event");

    switch (event["eventType"]) {
      // stage start
      case "StageStartEvent":
        stageName = event["stageNum"] == 6 ? "MAP_MOON_TITLE" : event["englishName"];
        stageNum = event["stageNum"];
        if (stageNum == 5) nextStage = "MAP_MOON_TITLE";
        break;

      // inventory event
      case "InventoryEvent":
        if (event["quantity"] == 0) break; // in case JSON is fucked
        if (event["transactionType"] == 5 && event["quantity"] > 0) break; // double logging voids whoops
        (event["quantity"] > 0 ? gains : losses).add(event); // faster
        break;

      // boss event
      case "DeathEvent":
        losses.add({
          "eventType": "KillEvent",
          "killerBody": event["killer"],
          "x": event["x"],
          "y": event["y"],
          "z": event["z"],
          "timestamp": event["timestamp"],
        });
        worldEvents.add(event);
        break;

      case "BossKillEvent":
        worldEvents.add(event);
        break;

      case "BossSpawnEvent":
        // print("wtf a $event");
        // TODO: THIS
        break;
    }
  }

  return Stage(
    stageNum: stageNum,
    startTime: startTime,
    endTime: endTime,
    itemGains: List<dynamic>.from(gains),
    itemLosses: List<dynamic>.from(losses),
    stageName: stageName,
    worldEvents: worldEvents,
    nextStage: nextStage,
    sideInfo: leftItem,
    runner: runner,
  );
}

enum SideInfo {
  numbers,
  profilePics,
}
