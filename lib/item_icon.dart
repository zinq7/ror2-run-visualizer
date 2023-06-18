import 'package:flutter/material.dart';

class ItemIcon extends StatefulWidget {
  final Widget child;

  const ItemIcon({super.key, required this.child});
  @override
  State<StatefulWidget> createState() => _ItemIconState();
}

class _ItemIconState extends State<ItemIcon> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (val) {
        setState(() {
          _isHover = val;
        });
      },
      onTap: () {},
      child: widget.child,
    );
  }
}
