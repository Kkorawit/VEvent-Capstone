import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/sign_in/sign_in_bloc.dart';

class SignOutBtn extends StatefulWidget {
  const SignOutBtn({super.key});

  @override
  State<SignOutBtn> createState() => _SignOutBtnState();
}

class _SignOutBtnState extends State<SignOutBtn> {
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      context.read<SignInBloc>().add(signIn(uEmail: null, role: null, displayName: null, profileURL: ""));
    }, icon: const Icon(Icons.logout, color: Colors.white), );
  }
}