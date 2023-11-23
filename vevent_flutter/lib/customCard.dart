

import 'package:flutter/material.dart';
import 'EventDetail.dart';

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

  CustomCard(
      {required this.title,
      required this.startDate,
      required this.location,
      required this.category,
      required this.createBy,
      required this.eventStatus,
      required this.description,
      required this.imagePath,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Click event " + title);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return EventDetail(
            title,
            startDate,
            location,
            category,
            createBy,
            eventStatus,
            description,
            imagePath,
          );
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
                        Expanded(child: Text(startDate)),
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
                      statusTag(eventStatus),
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

Widget statusTag(String eStatus) {
  if (eStatus == "Active") {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(100, 236, 233, 250),
      ),
      child: Text(
        eStatus,
        style: TextStyle(
          fontSize: 12,
          color: Color.fromARGB(100, 69, 32, 204),
        ),
      ),
    );
  } else {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(100, 243, 243, 243),
      ),
      child: Text(
        eStatus,
        style: TextStyle(
          fontSize: 12,
          color: Color.fromARGB(100, 81, 81, 81),
        ),
      ),
    );
  }
}
