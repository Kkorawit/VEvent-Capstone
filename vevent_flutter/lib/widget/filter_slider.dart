import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/event/event_bloc.dart';
import 'package:vevent_flutter/etc/filter.dart';
// import 'package:vevent_flutter/repository/event_repository.dart';

// ignore: must_be_immutable
class FilterBanner extends StatefulWidget {
  String selected = "All";
  final String uEmail;
  final String uRole;

  FilterBanner({super.key, required this.uEmail, required this.uRole});

  @override
  State<FilterBanner> createState() => _FilterBannerState();
  String filterBy() {
    return selected;
  }
}

class _FilterBannerState extends State<FilterBanner> {
  @override
  void initState() {
    context.read<EventBloc>().add(showEventList(
        uEmail: widget.uEmail, uRole: widget.uRole, selectedStatus:"All", sortBy: EventFilter.sortBy));
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
              status = EventFilter.filterSelected(FilterBy.All);
              break;
            case "Pending":
              status = EventFilter.filterSelected(FilterBy.P);
              break;
            case "In Progress":
              status = EventFilter.filterSelected(FilterBy.IP);
              break;
            case "Success":
              status = EventFilter.filterSelected(FilterBy.S);
              break;
            case "Fail":
              status = EventFilter.filterSelected(FilterBy.F);
              break;
            case "Upcoming":
              status = EventFilter.filterSelected(FilterBy.UP);
              break;
            case "Ongoing":
              status = EventFilter.filterSelected(FilterBy.ON);
              break;
            case "Completed":
              status = EventFilter.filterSelected(FilterBy.CO);
              break;
            case "Canceled":
              status = EventFilter.filterSelected(FilterBy.CA);
              break;
            default:
              status = EventFilter.filterSelected(FilterBy.All);
              break;
          }
          context.read<EventBloc>().add(showEventList(
              uEmail: widget.uEmail,
              uRole: widget.uRole,
              selectedStatus: status,
              sortBy: EventFilter.sortBy));
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
