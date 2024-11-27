import 'package:flutter/material.dart';

class BoutonCustom extends StatelessWidget {
  final VoidCallback onpressed;
  final String texteValeur;
  final bool? isDeleteButton;
  final double? hauteur;

  const BoutonCustom({
    super.key,
    required this.onpressed,
    required this.texteValeur,
    this.isDeleteButton,
    this.hauteur,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //Si hauteur pas nul on prend hauteur de l'écran
      height: hauteur != null
          ? MediaQuery.of(context).size.height * hauteur!
          : null,
      child: TextButton(
        onPressed: () {
          onpressed();
        },
        style: TextButton.styleFrom(
          backgroundColor: isDeleteButton == null ? Colors.black : Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          texteValeur,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
