import 'package:vevent_flutter/provider/participant_provider.dart';

class ParticipantRepo {
  final ParticipantProvider provider;

  ParticipantRepo({required this.provider});

  Future<List<dynamic>> getParticipantByEventID(String eid) async {
    final List participants;
    print("in participant repo");
    print("${eid}");

    participants = await provider.getParticipantByEventID(eid);
    return participants;
  }
}
