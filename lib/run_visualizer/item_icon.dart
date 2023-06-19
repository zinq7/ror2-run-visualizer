import 'package:flutter/material.dart';

/// An Icon of an Item, currently just a fancy InkWell.
class ItemIcon extends StatefulWidget {
  final Widget child;

  const ItemIcon({super.key, required this.child});
  @override
  State<StatefulWidget> createState() => _ItemIconState();
}

class _ItemIconState extends State<ItemIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (val) {
        setState(() {});
      },
      onTap: () {},
      child: widget.child,
    );
  }
}
