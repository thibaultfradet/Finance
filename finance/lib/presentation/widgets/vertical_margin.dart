import 'package:flutter/material.dart';

class Verticalmargin extends StatelessWidget {
  final double ratio;
  const Verticalmargin({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height * ratio);
  }
}
