import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/participant/participant_bloc.dart';
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
    BlocProvider.of<ParticipantBloc>(context)
        .add(showParticipant(id: widget.eventId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipantBloc, ParticipantState>(
        builder: (context, state) {
      if (state is ParticipantLoadingState || state is ParticipantInitial) {
        return Scaffold(
          // appBar: AppBar(),
          body: Center(child: CircularProgressIndicator()),
        );
      }

      if (state is ParticipantFinishState) {
        return Scaffold(
          body: ListView.builder(
              itemCount: state.participants.length,
              itemBuilder: (context, index) {
                return Card(
                    child: Container(
                  // Event Owner
                  width: 204,
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          // child: Image.asset("assets/images/default_profile.png"),
                          child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/vevent-capstone.appspot.com/o/NK-2%2FProfile_image%2Forganiz-1.png?alt=media&token=36c3a6e0-2658-4e1d-b9ee-fbc2cec6ce13"),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        // width: 160,
                        child: Text("participant name",
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                            style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ));
              }),
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
