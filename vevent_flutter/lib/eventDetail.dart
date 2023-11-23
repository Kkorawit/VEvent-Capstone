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

  EventDetail({
    required this.title, 
    required this.startDate, 
    required this.location, 
    required this.category,
    required this.createBy, 
    required this.eventStatus, 
    required this.description, 
    required this.imagePath
      });

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
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.home_sharp),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(widget.createBy, style: TextStyle(fontSize: 12))
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
                    Icon(Icons.location_on_sharp),
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
                height: 32,
              ),
              Container(
                child: Text(
                  widget.description,
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ));
  }
}
