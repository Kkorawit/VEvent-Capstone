import 'package:flutter/material.dart';

class SignOutBtn extends StatefulWidget {
  const SignOutBtn({super.key});

  @override
  State<SignOutBtn> createState() => _SignOutBtnState();
}

class _SignOutBtnState extends State<SignOutBtn> {
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){}, icon: Icon(Icons.logout, color: Colors.white), );
  }
}