import 'package:finance/presentation/widgets/bouton_custom.dart';
import 'package:flutter/material.dart';

class CustomOptionsDialog extends StatefulWidget {
  final List<Map<String, VoidCallback>> listeBoutons;
  const CustomOptionsDialog({super.key, required this.listeBoutons});

  @override
  State<CustomOptionsDialog> createState() => _CustomOptionsDialogState();
}

class _CustomOptionsDialogState extends State<CustomOptionsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF151433),
      content: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.listeBoutons.length,
        itemBuilder: (context, index) {
          // TODO : Rajouter les référence au liste de map dynamique en paramètre
          return BoutonCustom(
              onpressed: () {
                widget.listeBoutons[index];
              },
              texteValeur: widget.listeBoutons[index].toString());
        },
      ),
    );
  }
}
