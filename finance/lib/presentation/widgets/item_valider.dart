import 'package:finance/presentation/widgets/vertical_margin.dart';
import 'package:flutter/material.dart';

class ItemValider extends StatelessWidget {
  final String titre;
  final String valeur;
  const ItemValider({super.key, required this.titre, required this.valeur});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.13,
      child: Column(
        children: [
          //Text titre
          Text(
            titre,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const Verticalmargin(ratio: 0.015),
          //Valeur
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF221F4A),
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              valeur,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
