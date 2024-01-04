import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vevent_flutter/bloc/user/user_bloc.dart';
import 'package:vevent_flutter/bloc/validation/validation_bloc.dart';
import 'package:vevent_flutter/widget/validate_btn.dart';
// import '../location.dart';
import '../widget/statusTag.dart';

// ignore: must_be_immutable
class EventDetailPage extends StatefulWidget {
  final String eventId;
  final String uEmail;
  final String title;
  final String startDate;
  final String location;
  final String category;
  final String createBy;
  final String eventStatus;
  final String description;
  final String imagePath;
  String? eventOwner;
  String? ownerProfile;

  EventDetailPage(
      {required this.eventId,
      required this.uEmail,
      required this.title,
      required this.startDate,
      required this.location,
      required this.category,
      required this.createBy,
      required this.eventStatus,
      required this.description,
      required this.imagePath});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  void initState() {
    //เป็นการเรียกใช้งานครั้งเดียว
    context.read<UserBloc>().add(getUser(uEmail: widget.createBy));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        print(state);
        if (state is UserLoadingState || state is UserInitial) {
          print(state);
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is UserFinishState) {
          print("in BlocListener => state is ${state}");
          widget.eventOwner = "${state.user["username"]}";
          widget.ownerProfile = "${state.user["profileImg"]}";
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
                      content: Row(children: [
                        Text(state.validateRes.vStatus),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                            "The distance between your current location and the event location is ${state.validateRes.displacement}")
                      ]),
                    ));

                    await Future.delayed(Duration(seconds: 2));
                    Navigator.of(context).pop();

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
                                      Container(
                                        // Event Owner
                                        width: 204,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 36,
                                              height: 36,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: getProfileImage(
                                                    widget.ownerProfile),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              // width: 160,
                                              child: Text(
                                                  "${widget.eventOwner}",
                                                  /*"สาขาวิศวกรรมสิ่งแวดล้อมและการจัดการภัยพิบัติ มหาวิทยาลัยมหิดล"*/
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  maxLines: 2,
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          child: StatusTag(
                                              widget.eventStatus, 6, 16)),
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
                                  // margin: EdgeInsets.only(left: 8),
                                  // padding: EdgeInsets.all(2),
                                  // color: Colors.amber,
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
                                        // padding: const EdgeInsets.symmetric(
                                        //     vertical: 6, horizontal: 16),
                                        margin: const EdgeInsets.only(left: 4),
                                        // decoration: BoxDecoration(
                                        //   borderRadius: BorderRadius.circular(15),
                                        //   color: Color.fromARGB(100, 236, 233, 250),
                                        // ),
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
                                // ValidateButton(uEmail: widget.uEmail, eventId: widget.eventId)
                                BlocBuilder<ValidationBloc, ValidationState>(
                                  builder: (context, state) {
                                    if (state is ValidationInitial) {
                                      return ElevatedButton(
                                          onPressed: () => context
                                              .read<ValidationBloc>()
                                              .add(validateGPS(
                                                  uEmail: widget.uEmail,
                                                  eId: widget.eventId)),
                                          child: Text("Confirm Validation"));
                                    }
                                    if (state is ValidationLoadingState) {
                                      return ElevatedButton.icon(
                                        onPressed: null,
                                        icon: SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white),
                                        ),
                                        label: Padding(
                                          padding: EdgeInsets.only(left: 6),
                                          child: Text("Loading...",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Color.fromARGB(
                                                      100, 69, 32, 204)),
                                        ),
                                      );
                                    } else {
                                      return ElevatedButton(
                                          onPressed: () => context
                                              .read<ValidationBloc>()
                                              .add(validateGPS(
                                                  uEmail: widget.uEmail,
                                                  eId: widget.eventId)),
                                          child: Text("Confirm Validation"));
                                    }
                                  },
                                )
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
          return Container(
            child: Text("Event detail is not found"),
          );
        }
      },
    );
  }
}

Widget getProfileImage(img) {
  print("this is owner profile = " + img);
  if (img == null) {
    // return CircleAvatar(child: Icon(Icons.home_work),backgroundColor: Color.fromARGB(100, 218, 210, 245),);
    return Image.asset("/assets/images/default_profile.png");
  } else {
    return Image.network(img);
  }
}
