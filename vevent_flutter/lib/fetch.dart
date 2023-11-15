import 'package:http/http.dart' as http;

class fetch {

  void main(List<String> arguments) async {
  var url =Uri.https('https://fakestoreapi.com/products');

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    print('200 OK.');
  } else {
    print('Not OK.');
  }
  
}
}