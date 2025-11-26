import 'package:flutter/material.dart';


class SearchBar extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChanged;


  const SearchBar({Key? key, required this.hint, required this.onChanged}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}