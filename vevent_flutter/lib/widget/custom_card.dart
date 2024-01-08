import 'package:flutter/material.dart';
// import 'package:vevent_flutter/firebase_storage_client.dart';
import '../page/event_detail_page.dart';
import 'package:vevent_flutter/dateTimeFormat.dart';
import 'statusTag.dart';

/// Flutter code sample for custom list items.
class CustomCard extends StatelessWidget {
  final String uEmail;
  final String uEventId;
  final String eventId;
  final String title;
  final String startDate;
  final String location;
  final String category;
  final String createBy;
  final String eventStatus;
  final String description;
  final String imagePath;
  final String validateStatus;

  const CustomCard(
      {super.key,
      required this.uEmail,
      required this.uEventId,
      required this.eventId,
      required this.title,
      required this.startDate,
      required this.location,
      required this.category,
      required this.createBy,
      required this.eventStatus,
      required this.description,
      required this.imagePath,
      required this.validateStatus});
  // final List<dynamic> event;

  @override
  Widget build(BuildContext context) {
    print("imagePath => ${imagePath}");
    var formattedDate = dateTimeFormat("${startDate}");
    print(eventStatus);
    return GestureDetector(
      onTap: () {
        print("Click event " + title);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          print("this is uEmail at customCard => ${uEmail}");
          return EventDetailPage(uEventId: uEventId,);
        }));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(vertical: 12),
        elevation: 0,
        child: Container(
          width: 328,
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // รูปภาพทางซ้าย
              Container(
                width: 100,
                height: 120,
                child: ClipRRect(
                  // clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(10),
                  child: getImage(imagePath),
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
                      StatusTag(validateStatus, 4.0, 8.0)
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

Widget getImage(img) {
  if (img == null) {
    return Image.asset(
      "assets/images/poster.png",
      fit: BoxFit.cover,
    );
  } else {
    return Image.network(
      img,
      fit: BoxFit.fitHeight,
    );
  }
}
