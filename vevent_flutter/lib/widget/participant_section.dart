import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/participant/participant_bloc.dart';
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
      }

      if (state is ParticipantFinishState) {
        return Column(
          children: [
            Text("Participant"),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                  itemCount: state.participants.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Container(
                      margin: EdgeInsets.all(8),
                      width: 204,
                      child: Row(
                        children: [
                          Text("${index + 1}"),
                          Container(
                            width: 42,
                            height: 42,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: getEventImage(
                                  "${state.participants[0]["user"]["profileImg"]}"),
                            ),
                          ),
                          Expanded(
                              child: Row(
                            children: [
                              Text("${state.participants[0]["user"]["name"]}",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 14)),
                              Padding(padding: EdgeInsets.all(4.0)),
                              Text(
                                  "${state.participants[0]["user"]["surName"]}")
                            ],
                          )),
                        ],
                      ),
                    ));
                  }),
            ),
          ],
        );
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/text_logo.png"),
                height: 100,
                width: 148,
              ),
              SizedBox(
                height: 8,
              ),
              Text("No participating events"),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        );
      }
    });
  }
}
