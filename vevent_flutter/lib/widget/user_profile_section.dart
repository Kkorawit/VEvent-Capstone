import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/user/user_bloc.dart';
import 'package:vevent_flutter/widget/image.dart';

// ignore: must_be_immutable
class ProfileSection extends StatefulWidget {
  late String organizer;
  late String organizerImg;
  final String organizerEmail;

  ProfileSection({required this.organizerEmail});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
    void initState(){
      context.read<UserBloc>().add(getUser(uEmail: widget.organizerEmail));
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoadingState || state is UserInitial) {
          widget.organizer = "londing...";
          widget.organizerImg = "";
        }
        if (state is UserFinishState) {
          widget.organizer = "${state.user["username"]}";
          widget.organizerImg = "${state.user["profileImg"]}";
        } else {
          widget.organizer = "Not found organizer";
          widget.organizerImg = "";
        }

        return Container(
          // Event Owner
          width: 204,
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: getProfileImage(widget.organizerImg),
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
                child: Text("${widget.organizer}",
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 2,
                    style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Widget getProfileImage(img) {
//   print("this is owner profile = " + img);
//   if (img == "") {
//     return const CircularProgressIndicator();
//   } else {
//     return Image.network(img);
//   }
// }
