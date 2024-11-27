import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final TextEditingController tecCate;
  final String textTitre;
  const CustomDialog(
      {super.key, required this.tecCate, required this.textTitre});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF151433),
      title: Text(
        widget.textTitre,
        style: const TextStyle(color: Colors.white),
      ),
      content: TextField(
        style: const TextStyle(color: Colors.white),
        controller: widget.tecCate,
        decoration: const InputDecoration(
          hintText: "Nom de la catégorie",
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Annuler',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            'Ajouter',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            // Récupérer la valeur entrée dans le TextField
            Navigator.pop(context, widget.tecCate.text);
          },
        ),
      ],
    );
  }
}
