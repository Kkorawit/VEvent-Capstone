import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/gps/gps_bloc.dart';
// import 'package:vevent_flutter/bloc/validation/validation_bloc.dart';

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
    return BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            if (state is GpsInitial) {
              return ElevatedButton(
                  onPressed: (){
                    context.read<GpsBloc>().add(
                      gpsValidation(uEmail: widget.uEmail, eId: widget.eventId));
                    // ElevatedButton(onPressed: scanQR, child: Text("Scan QR Code"));
                  },
                  child: const Text("Confirm Validation"));
            }
            if (state is GpsLoadingState) {
              return ElevatedButton.icon(
                onPressed: null,
                icon: const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                ),
                label: const Padding(
                  padding: EdgeInsets.only(left: 6),
                  child:
                      Text("Loading...", style: TextStyle(color: Colors.white)),
                ),
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(100, 69, 32, 204)),
                ),
              );
            } else {
              return ElevatedButton(
                  onPressed: () => context.read<GpsBloc>().add(
                      gpsValidation(uEmail: widget.uEmail, eId: widget.eventId)),
                  child: const Text("Confirm Validation"));
            }
          },
        );
  }
}