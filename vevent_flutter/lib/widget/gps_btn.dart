import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/validation/validation_bloc.dart';

// ignore: must_be_immutable
class GPSBtn extends StatefulWidget {
  final String uEmail;
  final String eventId;
  final String eventStatus;
  final String validateStatus;
  final String validationType;
  late String qrRes;

  GPSBtn({super.key, required this.uEmail, required this.eventId, required this.eventStatus, required this.validateStatus, required this.validationType});


  @override
  State<GPSBtn> createState() => _GPSBtnState();
}

class _GPSBtnState extends State<GPSBtn> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
          builder: (context, state) {
            if (state is ValidationInitial) {
              return ElevatedButton(
                  onPressed: (){
                    context.read<ValidationBloc>().add(
                      validateGPS(uEmail: widget.uEmail, eId: widget.eventId));
                    // ElevatedButton(onPressed: scanQR, child: Text("Scan QR Code"));
                  },
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
  }
}