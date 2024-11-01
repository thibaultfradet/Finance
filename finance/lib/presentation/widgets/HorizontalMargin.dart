import 'package:flutter/material.dart';

class HorizontalMargin extends StatefulWidget {
  final double ratio;
  const HorizontalMargin({super.key, required this.ratio});

  @override
  State<HorizontalMargin> createState() => _HorizontalMarginState();
}

class _HorizontalMarginState extends State<HorizontalMargin> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: MediaQuery.of(context).size.width * widget.ratio);
  }
}
