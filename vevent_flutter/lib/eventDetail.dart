import 'package:flutter/material.dart';

class EventDetail extends StatefulWidget {
  final String title;
  final String startDate;
  final String location;
  final String category;
  final String createBy;
  final String eventStatus;
  final String description;
  final String imagePath;

  EventDetail(
      {required this.title,
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
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage(widget.imagePath),
                  width: 400,
                ),
              ),
              SizedBox(height: 16),
              Container(
                // width: 204,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 204,
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Icon(Icons.home_sharp),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            // width: 160,
                            child: Text(
                                /*widget.createBy*/ "สาขาวิศวกรรมสิ่งแวดล้อมและการจัดการภัยพิบัติ มหาวิทยาลัยมหิดล",
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 2,
                                style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 16),
                      margin: const EdgeInsets.only(left: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(100, 236, 233, 250),
                      ),
                      child: Text(
                        "${widget.eventStatus}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(100, 69, 32, 204),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                // margin: EdgeInsets.only(left: 8),
                // padding: EdgeInsets.all(2),
                // color: Colors.amber,
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(
                      width: 8,
                    ),
                    Text(widget.location,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false, // ถ้าเกินให้ตัดด้วยจุดจุดจุด
                        maxLines: 1,
                        style: TextStyle(fontSize: 16))
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                // padding: const EdgeInsets.symmetric(
                //           vertical: 8, horizontal: 8),
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Color.fromARGB(100, 69, 32, 204),
                //     width: 1,
                //     style: BorderStyle.solid,
                //     // strokeAlign:
                //   ),
                //   borderRadius: BorderRadius.circular(8)
                // ),
                child: Row(
                  children: [
                    Icon(Icons.category),
                    SizedBox(
                      width: 4,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 16),
                      margin: const EdgeInsets.only(left: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(100, 236, 233, 250),
                      ),
                      child: Text(
                        widget.category,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "รายละเอียด",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              ElevatedButton(
                onPressed: () {}, //if onPressed : null , button is disable
                child: Text("Confirm participation"),
              )
            ],
          ),
        ));
  }
}
