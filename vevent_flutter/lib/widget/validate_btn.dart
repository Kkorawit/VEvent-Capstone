import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/validation/validation_bloc.dart';

class ValidateButton extends StatefulWidget {
  final String uEmail;
  final String eventId;
  final String eventStatus;
  final String validateStatus;

  const ValidateButton(
      {super.key,
      required this.uEmail,
      required this.eventId,
      required this.eventStatus,
      required this.validateStatus});

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
    if (widget.eventStatus == "ON") {
      if (widget.validateStatus == "IP" || widget.validateStatus == "F") {
        return BlocBuilder<ValidationBloc, ValidationState>(
          builder: (context, state) {
            if (state is ValidationInitial) {
              return ElevatedButton(
                  onPressed: () => context.read<ValidationBloc>().add(
                      validateGPS(uEmail: widget.uEmail, eId: widget.eventId)),
                  child: Text("Confirm Validation"));
            }
            if (state is ValidationLoadingState) {
              return ElevatedButton.icon(
                onPressed: null,
                icon: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                ),
                label: Padding(
                  padding: EdgeInsets.only(left: 6),
                  child:
                      Text("Loading...", style: TextStyle(color: Colors.white)),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(100, 69, 32, 204)),
                ),
              );
            } else {
              return ElevatedButton(
                  onPressed: () => context.read<ValidationBloc>().add(
                      validateGPS(uEmail: widget.uEmail, eId: widget.eventId)),
                  child: Text("Confirm Validation"));
            }
          },
        );
      } else if (widget.validateStatus == "S") {
        return ElevatedButton(
            onPressed: null, child: Text("Confirm Validation"));
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}
