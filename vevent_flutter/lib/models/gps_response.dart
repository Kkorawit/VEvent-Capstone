class GpsResponse {
  final String vStatus;
  final int? httpStatus;
  final String? displacement;

  GpsResponse({required this.vStatus, required this.httpStatus, required this.displacement});
  
  factory GpsResponse.fromJson(Map<String, dynamic> json){
    return GpsResponse(
      vStatus: json["VStatus"] ?? "", 
      httpStatus: json["HTTP_Status"] ?? null, 
      displacement: json["Displacement"] ?? null
    );
  }


}