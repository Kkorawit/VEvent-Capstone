import 'package:flutter/material.dart';
import 'package:vevent_flutter/page/qr_code_page.dart';

class GenerateQRCodeSection extends StatefulWidget {
  // late String qrData;
  late String qrStart = DateTime.now().toUtc().toIso8601String();
  final String eventID;
  late int duration = 0;
  late String currentDateTime;

  GenerateQRCodeSection({super.key, required this.eventID});


  @override
  State<GenerateQRCodeSection> createState() => _GenerateQRCodeSectionState();
}

class _GenerateQRCodeSectionState extends State<GenerateQRCodeSection> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(
          "QR Code Generate",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 24,),
        Card(
          elevation: 8,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            // margin: EdgeInsets.all(40),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Column(
              children: [
              Image(
                  image: AssetImage("assets/images/qr_code.png"), height: 155.56),
              SizedBox(height: 40,),
              Text(
                "Set a time limit to indicate the expiration period.",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 24,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: (){
                        setState(() {
                        widget.duration > 0 ? widget.duration-- : widget.duration = 0; 
                        });
                      }, 
                      child: Icon(Icons.remove, size: 24,)
                    ),
                    Text("${widget.duration} : 00", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),),
                    TextButton(
                      onPressed: (){
                        setState(() {
                        widget.duration < 1440 ? widget.duration++ : widget.duration = 1440;
                        });
                      },
                      child: Icon(Icons.add, size: 24,)
                    ),
                ]),
              ),
              SizedBox(height: 24,),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                  widget.qrStart = DateTime.now().toUtc().toIso8601String();  
                  });
                  print(widget.qrStart);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return QRCodePage(qrStart:widget.qrStart, eventId: widget.eventID, duration: widget.duration,);
                  }));
                },
                child: Text("Create QR Code")
              )
            ]),
          ),
        ),
      ]),
    );
  }
}
