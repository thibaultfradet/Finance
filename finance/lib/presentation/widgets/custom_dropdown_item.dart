import 'package:flutter/material.dart';

class CustomDropdownItem extends StatelessWidget {
  final String valeur;
  const CustomDropdownItem({super.key, required this.valeur});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF221F4A),
      width: MediaQuery.of(context).size.width * 0.1,
      child: Text(valeur),
    );
  }
}
