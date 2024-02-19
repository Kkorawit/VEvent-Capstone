import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/event/event_bloc.dart';
import 'package:vevent_flutter/page/event_detail_page.dart';
import 'package:vevent_flutter/widget/custom_card.dart';
// import 'package:vevent_flutter/widget/filter_banner.dart';
// import 'dart:ui';

// ignore: must_be_immutable
class MyEventsSection extends StatefulWidget {
  final String uEmail;
  final String uRole;

  const MyEventsSection({super.key, required this.uEmail, required this.uRole});

  @override
  State<MyEventsSection> createState() => _MyEventsSectionState();
}

class _MyEventsSectionState extends State<MyEventsSection> {
  @override
  void initState() {
    //only use when this page/section is builded.
    print("In my event section -> ${widget.uRole}");

    // context.read<EventBloc>().add(showEventList(uEmail: widget.uEmail, uRole: widget.uRole, selectedStatus: "All"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(builder: (context, state) {
      debugPrint("$state");
      if (state is EventLoadingState || state is EventInitial) {
        return const Scaffold(
          // appBar: AppBar(),
          body: Center(child: CircularProgressIndicator()),
        );
      }
      if (state is EventFinishState) {
        if (state.events.isEmpty) {
          String noEventMes = widget.uRole == "Participant" ? "No participating events" : "No events created";
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
                Text( noEventMes ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          );
        } else {
          if (widget.uRole == "Participant") {
            return Scaffold(
              // appBar: AppBar(),
              body: ListView.builder(
                  itemCount: state.events.length,
                  itemBuilder: (context, index) {
                    //CustomCard for event that participant registered
                    return GestureDetector(
                      onTap: () {
                        debugPrint(
                            "Click event ${state.events[index]["event"]["title"]}");
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return EventDetailPage(
                            uEventId: "${state.events[index]["user_event_id"]}",
                            uRole: widget.uRole,
                          );
                        }));
                      },
                      child: CustomCard(
                        title: "${state.events[index]["event"]["title"]}",
                        startDate:
                            "${state.events[index]["event"]["startDate"]}",
                        location:
                            "${state.events[index]["event"]["locationName"]}",
                        category: "${state.events[index]["event"]["category"]}",
                        createBy: "${state.events[index]["event"]["createBy"]}",
                        eventStatus:
                            "${state.events[index]["eventStatus"]}", // status of event [UP,ON,CO,CE]
                        description:
                            "${state.events[index]["event"]["description"]}",
                        imagePath:
                            "${state.events[index]["event"]["posterImg"]}",
                        status:
                            "${state.events[index]["status"]}", //validate Status of user_event
                      ),
                    );
                  }),
            );
          } else if (widget.uRole == "Organization") {
            return Scaffold(
              // appBar: AppBar(),
              body: ListView.builder(
                  itemCount: state.events.length,
                  itemBuilder: (context, index) {
                    //CustomCard for event that organization created
                    return GestureDetector(
                      onTap: () {
                        debugPrint(
                            "Click event ${state.events[index]["title"]}");
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return EventDetailPage(
                            uEventId: "${state.events[index]["id"]}",
                            uRole: widget.uRole,
                          );
                        }));
                      },
                      child: CustomCard(
                        title: "${state.events[index]["title"]}",
                        startDate: "${state.events[index]["startDate"]}",
                        location: "${state.events[index]["locationName"]}",
                        category: "${state.events[index]["category"]}",
                        createBy: "${state.events[index]["createBy"]}",
                        description: "${state.events[index]["description"]}",
                        imagePath: "${state.events[index]["posterImg"]}",
                        eventStatus:
                            "${state.events[index]["eventStatus"]}", // status of event [UP,ON,CO,CE]
                        status:
                            "${state.events[index]["eventStatus"]}", // status of event [UP,ON,CO,CE]
                      ),
                    );
                  }),
            );
          } else {
            return const Center(
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
        }
      } else if (state is EventErrorState) {
        return Center(
          child: Text(state.message),
        );
      } else {
        return const Center(
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
