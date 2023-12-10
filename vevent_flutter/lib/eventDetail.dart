import 'package:flutter/material.dart';
import 'location.dart';
import 'statusTag.dart';
import 'get_user.dart';

// ignore: must_be_immutable
class EventDetail extends StatefulWidget {
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

  EventDetail(
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
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(fontSize: 24),
          ),
          // backgroundColor: Color.fromARGB(100, 69, 32, 204),
        ),
        body: FutureBuilder(
            future: getUser(uEmail: widget.createBy),
            builder: (context, snapshot) {
              print("${snapshot.data}");
              print("${snapshot.data?["username"]}");
              widget.eventOwner = "${snapshot.data?["username"]}";
              print(widget.imagePath);
              print(
                  "this is owner profile at futurebuilder => ${snapshot.data?["profileImg"]}");
              if (!snapshot.hasData) {
                return Center(
                  child: const CircularProgressIndicator(
                    backgroundColor: Color.fromARGB(100, 181, 166, 235),
                    color: Color.fromARGB(100, 69, 32, 204),
                    value: 0.75,
                  ),
                );
                // return Center(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Image(
                //         image: AssetImage("assets/images/text_logo.png"),
                //         height: 100,
                //         width: 148,
                //       ),
                //       SizedBox(
                //         height: 8,
                //       ),
                //       Text("No Detail"),
                //       SizedBox(
                //         height: 8,
                //       ),
                //     ],
                //   ),
                // );
              } else {
                return Stack(
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
                              padding:
                                  const EdgeInsets.fromLTRB(16, 24, 16, 32),
                              child: ListView(
                                controller: scrollController,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 40,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                                                      "${snapshot.data?["profileImg"]}"),
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
                                                    style: TextStyle(
                                                        fontSize: 12)),
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
                                          margin:
                                              const EdgeInsets.only(left: 4),
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
                                  Location(widget.eventId, widget.uEmail, widget.eventStatus),
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                );
              }
            }));
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
