import 'package:flutter/material.dart';

class PositionMultiItemsDelegate extends MultiChildLayoutDelegate {
  final List<String> items;
  PositionMultiItemsDelegate({required this.items});

  @override
  void performLayout(Size size) {
    var positions = positionMultiItems(items.length, [size.width, size.height]);
    for (int i = 0; i < items.length; i++) {
      layoutChild(
        i,
        const BoxConstraints(
          maxHeight: 64,
          minHeight: 64,
          maxWidth: 64,
          minWidth: 64,
        ),
      );

      positionChild(
        i,
        Offset(positions[i][0], positions[i][1]),
      );
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }

  List<List<double>> positionMultiItems(int count, List<double> pos) {
    print('there is a count $count');
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
          [pos[0] / 2, pos[1] / 2], // top right
        ];
    }
    return <List<double>>[];
  }
}
