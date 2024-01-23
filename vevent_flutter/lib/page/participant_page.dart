import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/participant/participant_bloc.dart';
import 'package:vevent_flutter/widget/image.dart';

class ParticipantPage extends StatefulWidget {
  late String eventId;

  ParticipantPage({required this.eventId});

  @override
  State<ParticipantPage> createState() => _ParticipantPageState();
}

class _ParticipantPageState extends State<ParticipantPage> {
  @override
  void initState() {
    print("ส่ง event id ${widget.eventId}");
    context.read<ParticipantBloc>().add(showParticipant(id: widget.eventId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipantBloc, ParticipantState>(
        builder: (context, state) {
      if (state is ParticipantLoadingState || state is ParticipantInitial) {
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else if (state is ParticipantFinishState) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Participant Page",
                style: TextStyle(fontSize: 24),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Participant",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.person_2_outlined,
                            color: Colors.black,
                            size: 18,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${state.participants.length}",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                    child: Table(
                  columnWidths: {
                    0: FixedColumnWidth(56.0),
                    1: FlexColumnWidth(236.0),
                    2: FlexColumnWidth(68.0),
                  },
                  children: [
                    TableRow(children: [
                      TableCell(
                        child: Center(
                          child: Text('No.',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey)),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text('Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey)),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text('Verify',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey)),
                        ),
                      ),
                    ]),
                  ],
                )),
                Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: ListView.builder(
                      itemCount: state.participants.length,
                      itemBuilder: (context, index) {
                        return Table(
                          columnWidths: {
                            0: FixedColumnWidth(56.0),
                            1: FlexColumnWidth(236.0),
                            2: FlexColumnWidth(68.0),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(children: [
                              TableCell(
                                child: Center(child: Text("${index + 1}")),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    leading: Container(
                                      height: 40,
                                      width: 40,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: getProfileImage(
                                              "${state.participants[index]["user"]["profileImg"]}")),
                                    ),
                                    title: Text(
                                        "${state.participants[index]["user"]["name"] + '  ' + state.participants[0]["user"]["surName"]}"),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Center(
                                      child: getIcon(
                                          "${state.participants[index]["status"]}")),
                                ),
                              ),
                            ])
                          ],
                        );
                      }),
                ),
              ],
            ));
      } else {
        print(state);
        return Container(
          child: Text("Participants is not found"),
        );
      }
    });
  }
}

Widget getIcon(status) {
  print("validate status : ${status}");
  if (status == null) {
    print("get icon by verify status = null");
  } else if (status == "S") {
    return Icon(
      Icons.verified_outlined,
      color: Colors.green,
    );
  } else if (status == "F") {
    return Icon(
      Icons.highlight_off_rounded,
      color: Colors.red,
    );
  } else if (status == "P") {
    return Icon(
      Icons.remove_circle_outline,
      color: Colors.grey,
    );
  }
  return Container();
}
