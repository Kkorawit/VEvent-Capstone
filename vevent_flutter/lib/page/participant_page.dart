import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/participant/participant_bloc.dart';
import 'package:vevent_flutter/widget/image.dart';
import 'package:vevent_flutter/widget/participant_card.dart';

// ignore: must_be_immutable
class ParticipantPage extends StatefulWidget {
  late String eventId;

  ParticipantPage({super.key, required this.eventId});

  @override
  State<ParticipantPage> createState() => _ParticipantPageState();
}

class _ParticipantPageState extends State<ParticipantPage> {
  @override
  void initState() {
    debugPrint("ส่ง event id ${widget.eventId}");
    context.read<ParticipantBloc>().add(showParticipant(id: widget.eventId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipantBloc, ParticipantState>(
        builder: (context, state) {
      if (state is ParticipantLoadingState || state is ParticipantInitial) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else if (state is ParticipantFinishState) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
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
                          const Text(
                            "Participant",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.person_2_outlined,
                            color: Colors.black,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${state.participants.length}",
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(56.0),
                    1: FlexColumnWidth(236.0),
                    2: FlexColumnWidth(68.0),
                  },
                  children: const [
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: ListView.builder(
                      itemCount: state.participants.length,
                      itemBuilder: (context, index) {
                        return participantCard(
                            position: "participantPage",
                            index: "${index + 1}",
                            profileImg:
                                "${state.participants[index]["user"]["profileImg"]}",
                            name:
                                "${state.participants[index]["user"]["name"]}",
                            surName:
                                "${state.participants[index]["user"]["surName"]}",
                            status: "${state.participants[index]["status"]}");
                        // return Table(
                        //   columnWidths: const {
                        //     0: FixedColumnWidth(56.0),
                        //     1: FlexColumnWidth(236.0),
                        //     2: FlexColumnWidth(68.0),
                        //   },
                        //   defaultVerticalAlignment:
                        //       TableCellVerticalAlignment.middle,
                        //   children: [
                        //     TableRow(children: [
                        //       TableCell(
                        //         child: Center(child: Text("${index + 1}")),
                        //       ),
                        //       TableCell(
                        //         child: Padding(
                        //           padding: const EdgeInsets.symmetric(vertical: 8),
                        //           child: ListTile(
                        //             contentPadding: const EdgeInsets.all(0),
                        //             leading: SizedBox(
                        //               height: 40,
                        //               width: 40,
                        //               child: ClipRRect(
                        //                   borderRadius:
                        //                       BorderRadius.circular(10),
                        //                   child: getProfileImage(
                        //                       "${state.participants[index]["user"]["profileImg"]}")),
                        //             ),
                        //             title: Text(
                        //                 "${state.participants[index]["user"]["name"] + '  ' + state.participants[0]["user"]["surName"]}"),
                        //           ),
                        //         ),
                        //       ),
                        //       TableCell(
                        //         child: Padding(
                        //           padding: const EdgeInsets.symmetric(vertical: 16),
                        //           child: Center(
                        //               child: getIcon(
                        //                   "${state.participants[index]["status"]}")),
                        //         ),
                        //       ),
                        //     ])
                        //   ],
                        // );
                      }),
                ),
              ],
            ));
      } else {
        debugPrint("$state");
        return const Text("Participants is not found");
      }
    });
  }
}

Widget getIcon(status) {
  debugPrint("validate status : $status");
  if (status == null) {
    debugPrint("get icon by verify status = null");
  } else if (status == "S") {
    return const Icon(
      Icons.verified_outlined,
      color: Colors.green,
    );
  } else if (status == "F") {
    return const Icon(
      Icons.highlight_off_rounded,
      color: Colors.red,
    );
  } else if (status == "P") {
    return const Icon(
      Icons.remove_circle_outline,
      color: Colors.grey,
    );
  }
  return Container();
}
