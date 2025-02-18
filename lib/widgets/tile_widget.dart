import 'package:flutter/material.dart';

class TileWidget extends StatefulWidget {
  const TileWidget({super.key});

  @override
  State<TileWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.maxFinite,
      color: Colors.purple.shade50,
      child: Column(
        children: [
          Row(
            children: [Text("first name"), Text("last name")],
          )
        ],
      ),
    );
  }
}
