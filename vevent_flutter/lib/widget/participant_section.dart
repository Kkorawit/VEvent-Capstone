import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/participant/participant_bloc.dart';
import 'package:vevent_flutter/page/participant_page.dart';
import 'package:vevent_flutter/widget/image.dart';
// import 'package:vevent_flutter/widget/user_profile_section.dart';

class ParticipantSection extends StatefulWidget {
  final String eventId;

  ParticipantSection({required this.eventId});

  @override
  State<ParticipantSection> createState() => _ParticipantSectionState();
}

class _ParticipantSectionState extends State<ParticipantSection> {
  @override
  void initState() {
    print(widget.eventId);
    BlocProvider.of<ParticipantBloc>(context)
        .add(showParticipant(id: widget.eventId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipantBloc, ParticipantState>(
        builder: (context, state) {
      if (state is ParticipantLoadingState || state is ParticipantInitial) {
        return Center(child: CircularProgressIndicator());
      } else if (state is ParticipantFinishState) {
        print("participatn have ${state.participants.length}");
        if (state.participants.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                ),
                SizedBox(height: 24),
                Image(
                  image: AssetImage("assets/images/text_logo.png"),
                  height: 100,
                  width: 148,
                ),
                SizedBox(
                  height: 8,
                ),
                Text("No participants in the event"),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          );
        } else {
          return Column(
            children: [
              Row(
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
                  ),
                  TextButton(
                      onPressed: () {
                        print("see participant more");
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ParticipantPage(eventId: widget.eventId);
                        }));
                      },
                      child: Row(children: [
                        Text("see more"),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 14,
                        )
                      ]))
                ],
              ),
              Container(
                // color: Colors.amber,
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                    itemCount: state.participants.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Table(
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
                                child: ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 8),
                                  leading: Container(
                                    height: 40,
                                    width: 40,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: getProfileImage(
                                            "${state.participants[index]["user"]["profileImg"]}")),
                                  ),
                                  title: Text(
                                      "${state.participants[index]["user"]["name"] + '  ' + state.participants[0]["user"]["surName"]}"),
                                ),
                              ),
                            ])
                          ],
                        ),
                      );
                    }),
              ),
            ],
          );
        }
      } else {
        print(state);
        return Container(
          child: Text("Participants is not found"),
        );
      }
    });
  }
}
