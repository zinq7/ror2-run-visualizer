import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:html';

Function(List<dynamic>) display = stageOverlayer;

/// run it.
void main(List<String> args) async {
  var uri = Uri.dataFromString(window.location.href);
  Map<String, String> params = uri.queryParameters;
  String run = 'runs/' + params['run']!;

  PickedFile pf = PickedFile(run);

  await pf.readAsBytes().then((res) {
    String jason = const Utf8Decoder().convert(res.toList());
    List<String> l = [jason];
    display(l);
  });
}
