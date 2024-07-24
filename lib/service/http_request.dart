import 'package:http/http.dart' as http;

Future<String> httpRequest(double? lat, double? lon) async {
  var url = Uri.parse('https://api.weatherapi.com/v1//forecast.json');
  var response = await http.post(url, body: {'key': '056b41180fa14eed85a74652242206', 'q': '$lat,$lon', 'days': '10'});
  if (response.statusCode == 200){
    return response.body;
  } else {
    return 'Error! ${response.statusCode}';
  }
}