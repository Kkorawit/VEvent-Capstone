import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilterBanner extends StatefulWidget {
  String selected = "All";
  FilterBanner({super.key});

  @override
  State<FilterBanner> createState() => _FilterBannerState();
}

class _FilterBannerState extends State<FilterBanner> {
  Widget filterBtn(String label) {
    return TextButton(
        onPressed: () {
          setState(() {
            widget.selected = label;
            // widget.bgColor = Color.fromRGBO(69, 32, 204, 1);
          });
        },
        style: TextButton.styleFrom(
          // fixedSize: Size.fromHeight(34),
          backgroundColor: widget.selected == label
              ? const Color.fromRGBO(69, 32, 204, 1)
              : const Color.fromRGBO(236, 233, 250, 1),
        ),
        child: Text(
          label,
          style: TextStyle(
              color: widget.selected == label
                  ? Colors.white
                  : const Color.fromRGBO(69, 32, 204, 1)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          filterBtn("All"),
          filterBtn("Pending"),
          filterBtn("In Progress"),
          filterBtn("Success"),
        ],
      ),
    );
  }
}
