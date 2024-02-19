import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/event/event_bloc.dart';
import 'package:vevent_flutter/bloc/event_detail/event_detail_bloc.dart';
import 'package:vevent_flutter/bloc/participant/participant_bloc.dart';
import 'package:vevent_flutter/bloc/qrcode/qrcode_bloc.dart';
// import 'package:vevent_flutter/bloc/participant/participant_bloc.dart';
import 'package:vevent_flutter/bloc/validation/validation_bloc.dart';
import 'package:vevent_flutter/models/date_time_format.dart';
import 'package:vevent_flutter/models/filter.dart';
// import 'package:vevent_flutter/models/filter.dart';
import 'package:vevent_flutter/widget/gen_qrcode.dart';
import 'package:vevent_flutter/widget/participant_section.dart';
// ignore: unused_import
import 'package:vevent_flutter/widget/scan_qrcode_btn.dart';
import 'package:vevent_flutter/widget/user_profile_section.dart';
import 'package:vevent_flutter/widget/validate_btn.dart';
import '../widget/status_tag.dart';

// ignore: must_be_immutable
class EventDetailPage extends StatefulWidget {
  late String uEmail;
  late String eventId;
  late String title;
  late String startDate;
  late String endDate;
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
  late String validationType;

  EventDetailPage({super.key, required this.uEventId, required this.uRole});

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

  Widget actionSection(String uRole, String validationType) {
    if (uRole == "Participant") {
      return ValidateButton(
        uEmail: widget.uEmail,
        uEventId: widget.uEventId,
        eventId: widget.eventId,
        eventStatus: widget.eventStatus,
        validateStatus: widget.validateStatus!,
        validationType: widget.validationType,
      );
    } else {
      if (validationType.contains("QR_CODE") && widget.eventStatus == "ON") {
        return Column(
          children: [
            GenerateQRCodeSection(
                eventID: widget.eventId,
                eventStartDate: widget.startDate,
                eventEndDate: widget.endDate,
                eventTitle: widget.title),
            const SizedBox(
              height: 24,
            ),
            ParticipantSection(
              eventId: widget.eventId,
            )
          ],
        );
      } else {
        return ParticipantSection(
          eventId: widget.eventId,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailBloc, EventDetailState>(
      builder: (context, state) {
        debugPrint("$state");
        if (state is EventDetailLoadingState || state is EventDetailInitial) {
          debugPrint("$state");
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is EventDetailFinishState) {
          if (widget.uRole == "Participant") {
            widget.eventId = "${state.event["event"]["id"]}";
            widget.uEmail = "${state.event["user"]["userEmail"]}";
            widget.title = "${state.event["event"]["title"]}";
            widget.startDate =
                dateTimeFormat("${state.event["event"]["startDate"]}");
            widget.endDate = "${state.event["event"]["endDate"]}";
            widget.location = "${state.event["event"]["locationName"]}";
            widget.category = "${state.event["event"]["category"]}";
            widget.createBy = "${state.event["event"]["createBy"]}";
            widget.eventStatus = "${state.event["event"]["eventStatus"]}";
            widget.description = "${state.event["event"]["description"]}";
            widget.imagePath = "${state.event["event"]["posterImg"]}";
            widget.validateStatus = "${state.event["status"]}";
            widget.status = "${state.event["status"]}";
            widget.validationType = "${state.event["event"]["validationType"]}";

            debugPrint(widget.eventStatus);
          } else {
            widget.eventId = "${state.event["id"]}";
            widget.uEmail = "${state.event["createBy"]}";
            widget.title = "${state.event["title"]}";
            widget.startDate = dateTimeFormat("${state.event["startDate"]}");
            widget.endDate = "${state.event["endDate"]}";
            widget.location = "${state.event["locationName"]}";
            widget.category = "${state.event["category"]}";
            widget.createBy = "${state.event["createBy"]}";
            widget.eventStatus = "${state.event["eventStatus"]}";
            widget.description = "${state.event["description"]}";
            widget.imagePath = "${state.event["posterImg"]}";
            widget.validateStatus = null;
            widget.status = "${state.event["eventStatus"]}";
            widget.validationType = "${state.event["validationType"]}";
          context
        .read<ParticipantBloc>()
        .add(showParticipant(id: widget.uEventId)); //uEventID == eventID in Organization
          }

          // context.read<UserBloc>().add(getUser(uEmail: widget.createBy));
          debugPrint("in BlocListener => state is $state");
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.title,
                style: const TextStyle(fontSize: 24),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<EventBloc>().add(showEventList(
                      uEmail: widget.uEmail,
                      uRole: widget.uRole,
                      selectedStatus: EventFilter.filterStatus,
                      sortBy: EventFilter.sortBy));
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: MultiBlocListener(
              listeners: [
                BlocListener<ValidationBloc, ValidationState>(
                    listener: (context, state) async {
                  if (state is ValidationFinishState) {
                    if (state.validateRes.httpStatus == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: state.validateRes.vStatus == "Success"
                            ? Colors.green
                            : Colors.red,
                        content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.validateRes.vStatus,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                  "The distance between your current location and the event location is ${state.validateRes.displacement}")
                            ]),
                      ));
                      await Future.delayed(const Duration(seconds: 1));
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
                      await Future.delayed(const Duration(seconds: 2));
                      Navigator.of(context).pop();
                    }
                  }
                  if (state is ValidationErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                }),
                BlocListener<QrcodeBloc, QrcodeState>(
                    listener: (context, state) async {
                  if (state is QrcodeFinishState) {
                    if (state.res.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.res.body),
                        backgroundColor: Colors.green,
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.res.body),
                        backgroundColor: Colors.red,
                      ));
                    }
                    await Future.delayed(const Duration(seconds: 1));
                    context.read<EventDetailBloc>().add(getEventDetail(
                        id: widget.uEventId, uRole: widget.uRole));
                    // Navigator.of(context).pop();
                  }
                  if (state is QrcodeErrorState) {
                    if (state.message.contains("RangeError (index)")) {
                      debugPrint(state.message);
                      // if (kDebugMode) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(content: Text(state.message)));
                      // }
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  }
                }),
              ],
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
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ProfileSection(
                                        organizerEmail: widget.createBy),
                                    Container(
                                        child: StatusTag(widget.status, 6, 16)),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Start: ${widget.startDate}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        // Text(" - "),
                                        Text(
                                          "End: ${dateTimeFormat(widget.endDate)}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(widget.location,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap:
                                              false, // ถ้าเกินให้ตัดด้วยจุดจุดจุด
                                          maxLines: 1,
                                          style: const TextStyle(fontSize: 16)),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.category),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      margin: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        widget.category,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "รายละเอียด",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      widget.description,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                // GenerateQRCodeSection(eventID: widget.eventId),
                                Container(
                                    child: actionSection(
                                        widget.uRole, widget.validationType))
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
          debugPrint("$state");
          return const Text("Event detail is not found");
        }
      },
    );
  }
}
