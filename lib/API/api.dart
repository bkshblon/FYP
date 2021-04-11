import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  Future getMethod() async {
    var theUrl = 'http://192.168.254.2/sensors/getData.php';
    var res = await http
        .get(Uri.parse(theUrl), headers: {"Accept": "application/json"});
    var responsBody = json.decode(res.body);
    print(responsBody);
    // responsBody.forEach((data) {
    // var a = data['latitude'];
    // });wait
    return responsBody;
  }
}
//List le lang gardai xa
