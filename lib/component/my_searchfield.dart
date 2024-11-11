import 'package:flutter/material.dart';

class MySearchField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function(String) onChanged;

  const MySearchField(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
