import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/event/event_bloc.dart';
import 'package:vevent_flutter/repository/event_repository.dart';

// ignore: must_be_immutable
class FilterBanner extends StatefulWidget {
  String selected = "All";
  final String uEmail;
  final String uRole;

  FilterBanner({super.key, required this.uEmail, required this.uRole});

  @override
  State<FilterBanner> createState() => _FilterBannerState();
}

class _FilterBannerState extends State<FilterBanner> {
  @override
  void initState() {
    context.read<EventBloc>().add(showEventList(
        uEmail: widget.uEmail, uRole: widget.uRole, selectedStatus: "All"));
    super.initState();
  }

  Widget filterBtn(String label) {
    String status;
    return TextButton(
        onPressed: () {
          setState(() {
            widget.selected = label;
            // widget.bgColor = Color.fromRGBO(69, 32, 204, 1);
          });
          switch (label) {
            case "All":
              status = "All";
              break;
            case "Pending":
              status = "P";
              break;
            case "In Progress":
              status = "IP";
              break;
            case "Success":
              status = "S";
              break;
            case "Fail":
              status = "F";
              break;
            case "Upcoming":
              status = "UP";
              break;
            case "Ongoing":
              status = "ON";
              break;
            case "Completed":
              status = "CO";
              break;
            case "Canceled":
              status = "CA";
              break;
            default:
              status = "All";
              break;
          }
          context.read<EventBloc>().add(showEventList(
              uEmail: widget.uEmail,
              uRole: widget.uRole,
              selectedStatus: status));
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
            fontSize: 10,
              color: widget.selected == label
                  ? Colors.white
                  : const Color.fromRGBO(69, 32, 204, 1)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.uRole == "Participant") {
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
            filterBtn("Fail"),
            filterBtn("Success"),
          ],
        ),
      );
    } else {
      return Container(
        // color: Colors.amber,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterBtn("All"),
            filterBtn("Upcoming"),
            filterBtn("Ongoing"),
            filterBtn("Completed"),
            filterBtn("Canceled"),
          ],
        ),
      );
    }
  }
}
