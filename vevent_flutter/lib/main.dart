
import 'package:flutter/material.dart';
import 'eventList.dart';
// import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of my app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vevent App',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromRGBO(69, 32, 204, 1.0)),
      ),
      home: const MyHomePage(title: 'VEvent'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  List eventImg = ["assets/images/poster.png","assets/images/poster.png","assets/images/poster.png"];
  List eventTitle = ["อาสาเติมสี แต้มฝันให้น้อง ณ โรงเรียนวัดบางในน้อย นครปฐม","ปั้น EM Ball บำบัดน้ำเสียเพื่อชุมชน อา 05 พย 66 (BTS คลองสาน)","เก็บขยะชายหาด อนุรักษ์ทรัพยากรป่าชายเลน จ.ระยอง"];
  List eventStartDate = ["11/11/2023  9:30:00 AM","11/5/2023  9:30:00 AM","11/12/2023  9:30:00 AM"];
  List eventLocation= ["โรงเรียนวัดบางในน้อย อ.บางเลน จ.นครปฐม","ลานกิจกรรมท่าดินแดง BTS คลองสาน สายสีทอง","สะพานรักษ์แสม ต.เนินฆ้อ อ.แกลง จ.ระยอง"];
//  title, event start date, location
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 56),
        child:Column(
          children: getMenu(eventTitle.length),
        ),
      ),
    );
  }

  List<Widget> getMenu(int count){
    List<Widget> menu = [];
    for (var i = 0; i < count; i++){
      menu.add(EventList(eventTitle[i], eventStartDate[i], eventImg[i], eventLocation[i]));
      menu.add(SizedBox(height: 8.0));
    }
    print(menu);
    return menu;
  }



}


// ListView.builder(
//             itemCount: menuName.length,
//             itemBuilder: (BuildContext context, int index) {
//               // FoodMenu food = menu[index];
//               return Column(
//                 children: [
//                   FoodMenu(menuName[index], menuPrice[index], menuImg[index])
//                 ],
//               );
//             }),