import 'package:flutter/material.dart';

class InputCustomPL extends StatelessWidget {
  final TextEditingController controllerPL;
  final String placeholder;
  final bool? isObscure;
  final bool? enable;
  final bool? isDouble;
  const InputCustomPL({
    super.key,
    required this.controllerPL,
    required this.placeholder,
    this.isObscure,
    this.enable,
    this.isDouble,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.06,
      child: TextFormField(
        keyboardType: isDouble != null
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        enabled: enable, // Active/désactive en fonction du paramètre
        controller: controllerPL,
        obscureText: isObscure == null ? false : isObscure!,
        style: const TextStyle(color: Colors.white), // Texte écrit en blanc
        decoration: InputDecoration(
          labelText: placeholder,
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
