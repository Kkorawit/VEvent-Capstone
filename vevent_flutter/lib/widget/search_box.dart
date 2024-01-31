import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        // contentPadding: EdgeInsets.all(4),
        prefixIcon: Icon(
          Icons.search,
          color: Color.fromRGBO(69, 32, 204, 1),
          // size: 26,
        ),
        suffixIcon: Icon(Icons.filter_alt, color: Color.fromRGBO(69, 32, 204, 1),),
        // suffix: IconButton(onPressed: (){} , icon: Icon(Icons.filter_alt, color: Color.fromRGBO(69, 32, 204, 1),)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: "Search event",
        labelStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        isDense: true,
      ),
    );
  }
}