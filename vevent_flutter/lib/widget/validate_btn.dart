import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/validation/validation_bloc.dart';

class ValidateButton extends StatefulWidget {
  final String uEmail;
  final String eventId;

  ValidateButton({required this.uEmail, required this.eventId});

  @override
  State<ValidateButton> createState() => _ValidateButtonState();
}

class _ValidateButtonState extends State<ValidateButton> {
  // @override
  // void initState(){
  //   context.read<ValidationBloc>().close();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
                                  builder: (context, state) {
                                    if (state is ValidationInitial) {
                                      return ElevatedButton(
                                          onPressed: () => context
                                              .read<ValidationBloc>()
                                              .add(validateGPS(
                                                  uEmail: widget.uEmail,
                                                  eId: widget.eventId)),
                                          child: Text("Confirm Validation"));
                                    }
                                    if (state is ValidationLoadingState) {
                                      return ElevatedButton.icon(
                                        onPressed: null,
                                        icon: SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white),
                                        ),
                                        label: Padding(
                                          padding: EdgeInsets.only(left: 6),
                                          child: Text("Loading...",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Color.fromARGB(
                                                      100, 69, 32, 204)),
                                        ),
                                      );
                                    } else {
                                      return ElevatedButton(
                                          onPressed: () => context
                                              .read<ValidationBloc>()
                                              .add(validateGPS(
                                                  uEmail: widget.uEmail,
                                                  eId: widget.eventId)),
                                          child: Text("Confirm Validation"));
                                    }
                                  },
                                );
  }
}


