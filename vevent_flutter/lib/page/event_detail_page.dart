import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/event_detail/event_detail_bloc.dart';
import 'package:vevent_flutter/bloc/participant/participant_bloc.dart';
import 'package:vevent_flutter/bloc/validation/validation_bloc.dart';
import 'package:vevent_flutter/dateTimeFormat.dart';
import 'package:vevent_flutter/widget/participant_section.dart';
import 'package:vevent_flutter/widget/user_profile_section.dart';
import 'package:vevent_flutter/widget/validate_btn.dart';
import '../widget/statusTag.dart';

// ignore: must_be_immutable
class EventDetailPage extends StatefulWidget {
  late String uEmail;
  late String eventId;
  late String title;
  late String startDate;
  late String location;
  late String category;
  late String createBy;
  late String eventStatus;
  late String description;
  late String imagePath;
  late String? validateStatus;
  late String status;
  late String organizer;
  late String organizerProfile;
  final String uEventId;
  final String uRole;

  EventDetailPage({required this.uEventId, required this.uRole});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  void initState() {
    context
        .read<EventDetailBloc>()
        .add(getEventDetail(id: widget.uEventId, uRole: widget.uRole));

    super.initState();
  }

  Widget actionSection(String uRole) {
    if (uRole == "Participant") {
      return ValidateButton(
          uEmail: widget.uEmail,
          eventId: widget.eventId,
          eventStatus: widget.eventStatus,
          validateStatus: widget.validateStatus!);
    } else {
      return ParticipantSection(
        eventId: widget.eventId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailBloc, EventDetailState>(
      builder: (context, state) {
        print(state);
        if (state is EventDetailLoadingState || state is EventDetailInitial) {
          print(state);
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is EventDetailFinishState) {
          if (widget.uRole == "Participant") {
            widget.eventId = "${state.event["event"]["id"]}";
            widget.uEmail = "${state.event["user"]["userEmail"]}";
            widget.title = "${state.event["event"]["title"]}";
            widget.startDate =
                dateTimeFormat("${state.event["event"]["startDate"]}");
            widget.location = "${state.event["event"]["locationName"]}";
            widget.category = "${state.event["event"]["category"]}";
            widget.createBy = "${state.event["event"]["createBy"]}";
            widget.eventStatus = "${state.event["event"]["eventStatus"]}";
            widget.description = "${state.event["event"]["description"]}";
            widget.imagePath = "${state.event["event"]["posterImg"]}";
            widget.validateStatus = "${state.event["status"]}";
            widget.status = "${state.event["status"]}";
          } else {
            widget.eventId = "${state.event["id"]}";
            widget.uEmail = "${state.event["createBy"]}";
            widget.title = "${state.event["title"]}";
            widget.startDate = dateTimeFormat("${state.event["startDate"]}");
            widget.location = "${state.event["locationName"]}";
            widget.category = "${state.event["category"]}";
            widget.createBy = "${state.event["createBy"]}";
            widget.eventStatus = "${state.event["eventStatus"]}";
            widget.description = "${state.event["description"]}";
            widget.imagePath = "${state.event["posterImg"]}";
            widget.validateStatus = null;
            widget.status = "${state.event["eventStatus"]}";
          }

          // context.read<UserBloc>().add(getUser(uEmail: widget.createBy));

          print("in BlocListener => state is ${state}");
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.title,
                style: TextStyle(fontSize: 24),
              ),
            ),
            body: BlocListener<ValidationBloc, ValidationState>(
              listener: (context, state) async {
                // Color snackBarColor;
                if (state is ValidationFinishState) {
                  if (state.validateRes.httpStatus == 200) {
                    // switch (state.validateRes.vStatus) {
                    //   case 'Success':
                    //     snackBarColor = Colors.green;
                    //     break;
                    //   case 'Fail':
                    //     snackBarColor = Colors.red;
                    //     break;
                    //   default : snackBarColor = Colors.green;
                    // }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: state.validateRes.vStatus == "Success"
                          ? Colors.green
                          : Colors.red,
                      content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.validateRes.vStatus,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                                "The distance between your current location and the event location is ${state.validateRes.displacement}")
                          ]),
                    ));

                    await Future.delayed(Duration(seconds: 1));
                    //อาจมีปัญหาเรื่องลำดับการแสดงผลถ้ามีก็อาจเปลี่ยน snackbar เป็น alert dialog ดูก่อน
                    context.read<EventDetailBloc>().add(getEventDetail(
                        id: widget.uEventId, uRole: widget.uRole));
                    // Navigator.of(context).pop();
                  } else {
                    // snackBarColor = Colors.yellow;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.yellow,
                      content: Row(children: [
                        Text(state.validateRes.vStatus),
                      ]),
                    ));
                    await Future.delayed(Duration(seconds: 2));
                    Navigator.of(context).pop();
                  }
                }
                if (state is ValidationErrorState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              child: Stack(
                children: [
                  Image(
                    image: NetworkImage(widget.imagePath),
                    fit: BoxFit.fitHeight,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.38,
                  ),
                  DraggableScrollableSheet(
                      initialChildSize: 0.6,
                      maxChildSize: 0.8,
                      minChildSize: 0.6,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                            child: ListView(
                              controller: scrollController,
                              children: [
                                Center(
                                  child: Container(
                                    width: 40,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Container(
                                  // width: 204,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ProfileSection(
                                          organizerEmail: widget.createBy),
                                      Container(
                                          child:
                                              StatusTag(widget.status, 6, 16)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  widget.title,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_month),
                                      SizedBox(width: 8),
                                      Text(
                                        widget.startDate,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text(widget.location,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap:
                                                false, // ถ้าเกินให้ตัดด้วยจุดจุดจุด
                                            maxLines: 1,
                                            style: TextStyle(fontSize: 16)),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.category),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: const EdgeInsets.only(left: 4),
                                        child: Text(
                                          widget.category,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "รายละเอียด",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        widget.description,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Container(child: actionSection(widget.uRole))
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          );
        } else {
          print(state);
          return Container(
            child: Text("Event detail is not found"),
          );
        }
      },
    );
  }
}

// Widget getProfileImage(img) {
//   print("this is owner profile = " + img);
//   if (img == "") {
//     // return CircleAvatar(child: Icon(Icons.home_work),backgroundColor: Color.fromARGB(100, 218, 210, 245),);
//     return Image(
//       image: AssetImage("assets/images/default_profile.png"),
//     );
//   } else {
//     return Image.asset(
//       "assets/images/poster.png",
//     );
//     // return Image.network(img);
//   }
// }
