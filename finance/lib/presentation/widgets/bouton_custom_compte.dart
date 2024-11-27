import 'package:flutter/material.dart';

class Boutoncustomcompte extends StatelessWidget {
  final VoidCallback onpressed;
  final String texteValeur;
  const Boutoncustomcompte(
      {super.key, required this.onpressed, required this.texteValeur});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white),
          bottom: BorderSide(color: Colors.white),
        ),
      ),
      child: TextButton(
        onPressed: () {
          onpressed();
        },
        child: Text(
          texteValeur,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
