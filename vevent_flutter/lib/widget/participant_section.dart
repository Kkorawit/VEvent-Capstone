import 'package:flutter/material.dart';
// import 'package:vevent_flutter/widget/user_profile_section.dart';

class ParticipantSection extends StatefulWidget {
  const ParticipantSection({super.key});

  @override
  State<ParticipantSection> createState() => _ParticipantSectionState();
}

class _ParticipantSectionState extends State<ParticipantSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Participant"),
        TextButton(onPressed: (){
          
        }, child: Text("see more")),
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                    child: Container(
                  // Event Owner
                  width: 204,
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset("assets/images/default_profile.png"),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        // width: 160,
                        child: Text("participant name",
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                            style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ));
              }),
        ),
      ],
    );
  }
}
