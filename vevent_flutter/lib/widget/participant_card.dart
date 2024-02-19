import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:vevent_flutter/page/participant_page.dart';
import 'package:vevent_flutter/widget/image.dart';

// ignore: camel_case_types
class participantCard extends StatelessWidget {
  final String position;
  final String index;
  final String profileImg;
  final String name;
  final String surName;
  final String status;

  participantCard(
      {required this.position,
      required this.index,
      required this.profileImg,
      required this.name,
      required this.surName,
      required this.status});

  @override
  Widget build(BuildContext context) {
    debugPrint("position $position");
    debugPrint("profile image: $profileImg");
    debugPrint("user name: $name");
    debugPrint("user surName: $surName");
    debugPrint("user status: $status");
    if (position == "participantPage") {
      return Table(
        columnWidths: const {
          0: FixedColumnWidth(56.0),
          1: FlexColumnWidth(236.0),
          2: FlexColumnWidth(68.0),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            TableCell(
              child: Center(child: Text("${index}")),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: getProfileImage(profileImg)),
                  ),
                  title: Text("$name $surName"),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(child: getIcon(status)),
              ),
            ),
          ])
        ],
      );
    } else if (position == "eventDetail") {
      return Table(
        columnWidths: const {
          0: FixedColumnWidth(24.0),
          1: FlexColumnWidth(236.0),
          2: FlexColumnWidth(68.0),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            // TableCell(
            //   child: Text("${index}"),
            // ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: getProfileImage(profileImg)),
                  ),
                  title: Text("$name $surName"),
                ),
              ),
            )
          ])
        ],
      );
    } else {
      print(status);
    }
    return Text(status);
  }
}

Widget getIcon(status) {
  if (kDebugMode) {
    print("validate status : ${status}");
  }
   if (status == "S") {
    return const Icon(
      Icons.verified_outlined,
      color: Colors.green,
    );
  } else if (status == "F") {
    return const Icon(
      Icons.highlight_off_rounded,
      color: Colors.red,
    );
  } else if (status == "P" || status == "IP" ) {
    return const Icon(
      Icons.remove_circle_outline,
      color: Colors.grey,
    );
  }else {
    debugPrint("get icon by verify status = null or sth wrong with user validate status");
  }
  return Container();
}
