class ValidationResponse {
  final String vStatus;
  final int? httpStatus;
  final String? displacement;

  ValidationResponse({required this.vStatus, required this.httpStatus, required this.displacement});
  
  factory ValidationResponse.fromJson(Map<String, dynamic> json){
    return ValidationResponse(
      vStatus: json["VStatus"] ?? "", 
      httpStatus: json["HTTP_Status"] ?? null, 
      displacement: json["Displacement"] ?? null
    );
  }


}