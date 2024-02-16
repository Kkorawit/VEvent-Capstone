import 'package:flutter/material.dart';
import 'package:vevent_flutter/widget/filter_overlay.dart';

class SearchBox extends StatefulWidget {
    final String uEmail;
  final String uRole;

  const SearchBox({super.key, required this.uEmail, required this.uRole});


  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        // contentPadding: EdgeInsets.all(4),
        prefixIcon: const Icon(
          Icons.search,
          color: Color.fromRGBO(69, 32, 204, 1),
          // size: 26,
        ),
        suffixIcon: FilterOverlay(uEmail: widget.uEmail, uRole: widget.uRole,),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: "Search event",
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        isDense: true,
      ),
    );
  }
}