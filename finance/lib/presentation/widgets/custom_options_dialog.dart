import 'package:finance/presentation/widgets/bouton_custom.dart';
import 'package:finance/presentation/widgets/vertical_margin.dart';
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
      content: SizedBox(
        height: MediaQuery.of(context).size.height *
            0.16 *
            widget.listeBoutons.length,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.16 *
                  widget.listeBoutons.length,
              width: MediaQuery.of(context).size.width * 0.7,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.listeBoutons.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Verticalmargin(ratio: 0.02 * widget.listeBoutons.length),
                      BoutonCustom(
                        onpressed: widget.listeBoutons[index].values.first,
                        texteValeur: widget.listeBoutons[index].keys.first,
                        hauteur: 0.09,
                      ),
                      Verticalmargin(ratio: 0.02 * widget.listeBoutons.length),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
