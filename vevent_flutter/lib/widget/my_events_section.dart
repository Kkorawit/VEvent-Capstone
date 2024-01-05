import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/event/event_bloc.dart';
import 'package:vevent_flutter/widget/custom_card.dart';

class MyEventsSection extends StatefulWidget {
  const MyEventsSection({super.key});

  @override
  State<MyEventsSection> createState() => _MyEventsSectionState();
}

class _MyEventsSectionState extends State<MyEventsSection> {
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
                return CustomCard(
                    eventId: "${state.events[index]["event"]["id"]}",
                    uEmail: "${state.events[index]["user"]["userEmail"]}",
                    title: "${state.events[index]["event"]["title"]}",
                    startDate: "${state.events[index]["event"]["startDate"]}",
                    location: "${state.events[index]["event"]["locationName"]}",
                    category: "${state.events[index]["event"]["category"]}",
                    createBy: "${state.events[index]["event"]["createBy"]}",
                    eventStatus: "${state.events[index]["status"]}", //รอเปลี่ยนเป็น ${state.events[index]["event"]["eventStatus"]}
                    description:
                        "${state.events[index]["event"]["description"]}",
                    imagePath: "${state.events[index]["event"]["posterImg"]}",
                    validateStatus: "${state.events[index]["status"]}",);
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
