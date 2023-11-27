import 'package:flutter/material.dart';
import 'eventDetail.dart';
import 'package:vevent_flutter/dateTimeFormat.dart';


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
  if (eStatus == "A") { // [A/P/Pending] mean event is pending
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(100, 236, 233, 250),
      ),
      child: Text(
        "Pending",
        style: TextStyle(
          fontSize: 12,
          color: Color.fromARGB(100, 69, 32, 204),
        ),
      ),
    );
  } else if (eStatus == "D") { // [D/S/Success] mean event is success
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(100, 197, 245, 196),
      ),
      child: Text(
        "Success",
        style: TextStyle(
          fontSize: 12,
          color: Color.fromARGB(100, 11, 91, 9),
        ),
      ),
    );
  }else if(eStatus == "I"){ // [I/In review] mean event is in review
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(100, 239, 176, 8),
      ),
      child: Text(
        "In review",
        style: TextStyle(
          fontSize: 12,
          color: Color.fromARGB(99, 109, 81, 5),
        ),
      ),
    );
  }else if(eStatus == "F"){ // [F/Fail] mean event is fail
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(100, 216, 50, 50),
      ),
      child: Text(
        "Fail",
        style: TextStyle(
          fontSize: 12,
          color: Color.fromARGB(100, 69, 10, 10),
        ),
      ),
    );
  }else{
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(97, 243, 243, 243),
      ),
      child: Text(
        "-",
        style: TextStyle(
          fontSize: 12,
          color: Color.fromARGB(100, 81, 81, 81),
        ),
      ),
    );
  }


}
