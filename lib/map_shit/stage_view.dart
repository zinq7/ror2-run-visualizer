import 'package:flutter/material.dart';
import 'map_to_image_helper.dart';

/// Visualizes a run, with items from each stage on a timeline
class FilePick extends StatelessWidget {
  const FilePick({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> images = [];

    return Material(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            Image(
              image: const AssetImage("lib/assets/misc/select_file.png"),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            ...images,
          ],
        ),
      ),
    );
  }
}
