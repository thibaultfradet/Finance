import 'package:flutter/material.dart';

class Horirontalmargin extends StatelessWidget {
  final double ratio;
  const Horirontalmargin({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: MediaQuery.of(context).size.width * ratio);
  }
}
