import 'package:flutter/material.dart';
import 'eventDetail.dart';

// class FoodMenu{
//   String name;
//   int price;
//   String img;

//   FoodMenu(this.name, this.price, this.img);

// }

class EventList extends StatelessWidget {
  String title;
  String startDate;
  String img;
  String location;

  EventList(this.title, this.startDate, this.img, this.location);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('เลือกกิจกรรม ${title}');
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return EventDetail(this.title, this.startDate, this.img, this.location);
        }
        )
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(4, 2, 2, 4),
        decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(16),
            border:
                Border.all(style: BorderStyle.solid, color: Colors.black12)),
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ 
            Row(children: [
              Text("fdfgd"),
              Column(
                children: [
                  Flexible(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: title,
                  style:TextStyle(fontSize: 16, color: Colors.black)
                ))),
            Text(
              startDate,
              style: TextStyle(fontSize: 16),
            ),
            Flexible(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: location,
                  style:TextStyle(fontSize: 16, color: Colors.black)
                )))
                ],
              )
            ],),
          ],
        ),
      ),
    );
  }
}