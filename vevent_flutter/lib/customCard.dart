import 'package:flutter/material.dart';
import 'eventDetail.dart';
import 'package:vevent_flutter/dateTimeFormat.dart';
import 'statusTag.dart';


/// Flutter code sample for custom list items.
class CustomCard extends StatelessWidget {
  final String title;
  final String startDate;
  final String location;
  final String category;
  final String createBy;
  final String eventStatus;
  final String description;
  final String imagePath;
  // final List<dynamic> event;


  CustomCard({
    required this.title,
    required this.startDate,
    required this.location,
    required this.category,
    required this.createBy,
    required this.eventStatus,
    required this.description,
    required this.imagePath,
    // required this.event
  });

  // String title;
  // String startDate;
  // String location;
  // String category;
  // String createBy;
  // String eventStatus;
  // String description;
  // String imagePath;

  @override
  Widget build(BuildContext context) {
    var formattedDate =dateTimeFormat("${startDate}");
    print(eventStatus);

    return GestureDetector(
      onTap: () {
        print("Click event " + title);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return EventDetail(
              title: title,
              startDate: formattedDate,
              location: location,
              category: category,
              createBy: createBy,
              eventStatus: eventStatus,
              description: description,
              imagePath: imagePath);
        }));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(vertical: 12),
        elevation: 2.0,
        child: Container(
          width: 328,
          height: 120,
          child: Row(
            children: [
              // รูปภาพทางซ้าย
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // ข้อมูลทางขวา
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow:
                            TextOverflow.ellipsis, // ถ้าเกินให้ตัดด้วยจุดจุดจุด
                        maxLines: 1,
                      ),
                      SizedBox(height: 8.0),
                      Row(children: [
                        Icon(
                          Icons.calendar_month,
                          size: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(child: Text("${formattedDate}")),
                      ]),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              location,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false, // ถ้าเกินให้ตัดด้วยจุดจุดจุด
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      StatusTag(eventStatus, 4.0, 8.0)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

