import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/sign_in/sign_in_bloc.dart';

class ProfilePage extends StatefulWidget {
  final String imgProfile;
  final String uEmail;
  final String userName;

  const ProfilePage(
      {super.key,
      required this.imgProfile,
      required this.uEmail,
      required this.userName});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.amber,
        // alignment: Alignment.bottomCenter,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image(
                image: NetworkImage(widget.imgProfile),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  height: MediaQuery.of(context).size.height * 0.46,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                    child: Column(children: [
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              widget.userName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.mail_outline, size: 16),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  widget.uEmail,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Terms and Condition'),
                                  content: const Text(
                                      'โหลนถ่ายทำบึ้มสตูดิโอ เพลซไฟต์ แคร์ป๊อป สเตชัน ฟิวเจอร์เกสต์เฮาส์ อึ๋มเยอบีร่าไฮแจ็คมยุราภิรมย์คาเฟ่ ช็อปพีเรียดนอร์ทธัมโม พุทธภูมิปัจฉิมนิเทศ โบรชัวร์ฮองเฮาตรวจทานเซ็นเซอร์แผดเผา เซฟตี้ซิตีโปรเจกเตอร์ แพทเทิร์นเป็นไง ซิตี้เวิร์ค แพทเทิร์นศิลปวัฒนธรรม เจลป่าไม้ แดนซ์มุมมอง แพตเทิร์นปาสคาลออดิทอเรียมยอมรับสตีลพีเรียดโรแมนติก คาราโอเกะโปรเจ็กต์วืดไทม์ ดอกเตอร์หลวงปู่ไรเฟิลอึ๋ม คอรัปชั่นปูอัด เซอร์โอวัลตินหลินจือ วอลนัท ก่อนหน้าพันธกิจเครปมิลค์รามเทพ ซีเรียสโชว์รูมรีเสิร์ชเลกเชอร์ เคลมแฟ็กซ์โปรเจกต์ฮวงจุ้ยราชานุญาต น้องใหม่ชัวร์ เลสเบี้ยนคอลัมน์ซาร์ดีนสโรชา แครกเกอร์ยนตรกรรมเอ๋อไฟลต์ไทม์ อุเทน กุมภาพันธ์สัมนาแบ็กโฮ เชอร์รี่อุด้ง เบนโลอินดอร์เจี๊ยว',
                                      overflow: TextOverflow.clip,
                                      maxLines: 10),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(236, 233, 250, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.shield_outlined,
                                          size: 24,
                                          color: Color.fromRGBO(69, 32, 204, 1),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          "Terms and Conditions",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(69, 32, 204, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.arrow_forward_ios,
                                        size: 24,
                                        color: Color.fromRGBO(69, 32, 204, 1)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<SignInBloc>().add(signIn(
                                    uEmail: null,
                                    role: null,
                                    displayName: null,
                                    profileURL: ""));
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(236, 233, 250, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.logout,
                                            size: 24,
                                            color:
                                                Color.fromRGBO(69, 32, 204, 1)),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          "Sign-out",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  69, 32, 204, 1)),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.arrow_forward_ios,
                                        size: 24,
                                        color: Color.fromRGBO(69, 32, 204, 1)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
