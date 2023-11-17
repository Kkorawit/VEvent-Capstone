import 'package:flutter/material.dart';

class EventDetail extends StatefulWidget {
  String title;
  String startDate;
  String img;
  String location;

  EventDetail(this.title, this.startDate, this.img, this.location);

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
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage(widget.img),
                  width: 400,
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                child: Row(
                  children: [
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text(
                          widget.startDate.toString(),
                          style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                          ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 24,),
              Container(
                child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse semper ex vitae dolor facilisis, venenatis elementum risus tempor. Nulla porta risus eu ante sodales elementum. Praesent ac sem odio.'),
              ),
              SizedBox(height: 64,),
              ElevatedButton(
                onPressed: (){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Buying Successful!', style: TextStyle(fontWeight: FontWeight.bold),),
                      backgroundColor: Colors.green,
                      )
                  );
                },
                child: Text('BUY'))
            ],
          ),
        ));
  }
}