import 'dart:convert';

/// Parse the next stage from a JSON and return [the stage, the rest];
List getStage(List json) {
  List lst = json;
  int start = 0, end = lst.indexWhere((element) => element["eventType"] == "StageEndEvent");

  if (end == -1) return [json, []]; // no stageEnd is last stage

  return [lst.sublist(start, end + 1), lst.sublist(end + 1)]; // separate on end
}

/// Get all the stage events, and return them as a list of JSON arrays.
List getStageEvents(String jsonString) {
  // read run
  var json = jsonDecode(jsonString);

  // get events (to start)
  List events = getStage(json["runEvents"]);
  List stageEvents = [];
  int stage = 1;

  // loop through and fill list with stages
  while (!events[1].isEmpty) {
    stageEvents.add(events[0]); // events[0] is the stage

    events = getStage(events[1]); // events[1] is the rest
    stage++;

    if (stage > 6) break; // unlikely, but ignore loops
  }

  return stageEvents;
}
