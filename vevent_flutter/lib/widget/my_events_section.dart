import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/event/event_bloc.dart';
import 'package:vevent_flutter/page/event_detail_page.dart';
import 'package:vevent_flutter/widget/custom_card.dart';

class MyEventsSection extends StatefulWidget {
  // String uEmail = "Laure-CA03@example.com";
  String uEmail = "organization-01@example.com";
  // String uRole = "Participant";
  String uRole = "Organization";

  // MyEventsSection({super.key});

  @override
  State<MyEventsSection> createState() => _MyEventsSectionState();
}

class _MyEventsSectionState extends State<MyEventsSection> {
  @override
  void initState() {
    //เป็นการเรียกใช้งานครั้งเดียว
    BlocProvider.of<EventBloc>(context)
        .add(showEventList(uEmail: widget.uEmail, uRole: widget.uRole));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(builder: (context, state) {
      print(state);
      if (state is EventLoadingState || state is EventInitial) {
        return Scaffold(
          // appBar: AppBar(),
          body: Center(child: CircularProgressIndicator()),
        );
      }
      if (state is EventFinishState) {
        return Scaffold(
          // appBar: AppBar(),
          body: ListView.builder(
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                if (widget.uRole == "Participant") {
                  return GestureDetector(
                    onTap: () {
                      print("Click event " +
                          "${state.events[index]["event"]["title"]}");
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
                      startDate: "${state.events[index]["event"]["startDate"]}",
                      location:
                          "${state.events[index]["event"]["locationName"]}",
                      category: "${state.events[index]["event"]["category"]}",
                      createBy: "${state.events[index]["event"]["createBy"]}",
                      eventStatus:
                          "${state.events[index]["eventStatus"]}", //รอเปลี่ยนเป็น ${state.events[index]["event"]["eventStatus"]}
                      description:
                          "${state.events[index]["event"]["description"]}",
                      imagePath: "${state.events[index]["event"]["posterImg"]}",
                      status:
                          "${state.events[index]["status"]}", //validateStatus
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      print("Click event " + "${state.events[index]["title"]}");
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
                          "${state.events[index]["eventStatus"]}", //รอเปลี่ยนเป็น ${state.events[index]["event"]["eventStatus"]}
                      status: "${state.events[index]["eventStatus"]}",
                    ),
                  );
                }
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
