// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'dart:io';

class PogOut extends StatefulWidget {
  final String folder;
  const PogOut({super.key, required this.folder});

  @override
  State createState() => PogOutState();
}

class PogOutState extends State<PogOut> {
  PogOutState();

  Future<Widget> callAsyncFetch() {
    var dir = Directory(widget.folder);
    return dir.list().toList().then((items) {
      items.sort((a, b) => a.path.split("/").last.split('_')[1].compareTo(b.path.split("/").last.split('_')[1]));

      var images = <Widget>[];
      int i = 0;
      double minx = 1231231, maxx = -123132, miny = 123213, maxy = -123132, minz = 123123, maxz = -123132;
      for (var item in items) {
        i++;

        List<String> uh = (item.path).split("/").last.split("_");
        double x = double.parse(uh[0]), y = double.parse(uh[2].split('.')[0]), z = double.parse(uh[1]);

        if (x < minx) minx = x;
        if (x > maxx) maxx = x;
        if (y < miny) miny = y;
        if (y > maxy) maxy = y;
        if (z < minz) minz = z;
        if (z > maxz) maxz = z;

        images.add(
          LayoutId(
            id: i,
            child: /*ShaderMask(
              shaderCallback: (rect) {
                return RadialGradient(
                  radius: 0.5,
                  colors: [
                    Colors.black.withOpacity(1.0),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.2),
                    Colors.transparent,
                  ],
                  stops: const [0.1, 0.3, 0.5, 0.7, 0.9, 1],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: Image(
                image: FileImage(
                  File(item.path),
                ),
                width: 64,
                height: 64,
              ),
            ), */

                ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: FileImage(
                  File(item.path),
                ),
                width: 64,
                height: 64,
                opacity: const AlwaysStoppedAnimation(0.5),
              ),
            ),
          ),
        );
      }

      print("minX: $minx");
      print("maxX: $maxx");
      print("miny: $miny");
      print("maxy: $maxy");
      print("minz: $minz");
      print("maxz: $maxz");
      print('json: {"minx": $minx, "maxx": $maxx, "miny": $miny, "maxy": $maxy, "maxz": $maxz, "minz": $minz}');

      return SizedBox(
        child: CustomMultiChildLayout(
          delegate: OverlaySpam(
            items: items,
            maxx: maxx,
            maxy: maxy,
            minx: minx,
            miny: miny,
          ),
          children: images,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
        future: callAsyncFetch(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data as Widget;
          } else {
            return const CircularProgressIndicator(
              value: 0.99,
            );
          }
        });
  }
}

class OverlaySpam extends MultiChildLayoutDelegate {
  final dynamic items;
  double minx, miny, maxx, maxy;
  OverlaySpam({
    required this.items,
    required this.minx,
    required this.maxx,
    required this.miny,
    required this.maxy,
  });

  @override
  void performLayout(Size size) {
    int i = 0;
    double addX = 50 - minx, divX = maxx - minx + 100, addY = 25 - miny, divY = maxy - miny + 100;
    for (var item in items) {
      i++;
      var path = item.path;
      // print('$path is item');
      List<String> uh = (path as String).split("/").last.split("_");
      double x = double.parse(uh[0]), y = double.parse(uh[2].split('.')[0]);
      // if (double.parse(uh[1]) > z) return;
      layoutChild(
        i,
        const BoxConstraints(
          minHeight: 10,
          minWidth: 10,
        ),
      );
      var pos = Offset(((x + addX) / divX) * size.width - 5, ((y + addY) / divY) * size.height - 5);
      // print("$i going to $pos");
      positionChild(
        i,
        pos,
      );
      // print(i);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
