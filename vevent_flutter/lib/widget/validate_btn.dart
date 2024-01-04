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
  //   context.read<ValidationBloc>().add(validateGPS(uEmail: widget.uEmail, eId: widget.eId));
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return switch (state) {
          ValidationInitial() => ElevatedButton(
              onPressed: () => context
                  .read<ValidationBloc>()
                  .add(validateGPS(uEmail: widget.uEmail, eId: widget.eventId)),
              child: Text("Confirm Validation")),
          ValidationLoadingState() => Center(
                child: Container(
              child: CircularProgressIndicator(),
            )),
          ValidationFinishState() => ElevatedButton(
              onPressed: () => context
                  .read<ValidationBloc>()
                  .add(validateGPS(uEmail: widget.uEmail, eId: widget.eventId)),
              child: Text("Confirm Validation")),
          ValidationErrorState() => SnackBar(
              content: Text(state.message),
            ),
        };
      },
    );
  }
}

Future<void> statePop() async {
  BlocListener<ValidationBloc, ValidationState>(
    listener: (context, state) {
      // TODO: implement listenerprint(state);
      if (state is ValidationLoadingState || state is ValidationInitial) {
        print(state);
      }
      if (state is ValidationFinishState) {
        print(state);
        print("In statePop -> ${state.validateRes}");
      } else {
        print(state);
      }
    },
  );
}
