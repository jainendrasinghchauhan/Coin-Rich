import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import 'connectivity.dart';

class ApiClient {
  final log = Logger();

  Future getMethod({required String url, Map<String, String>? header}) async {
    var response;
    await NetworkCheck().checkConnection().then((con) async {
      if (con) {
        try {
          response = await http.get(Uri.parse(url), headers: header);
          log.i(url);
          log.i(response.statusCode);
          log.i("response=>" + response.body.toString());
          response = response;
        } on Exception catch (e) {
          response = null;
          log.e("Error=>" + e.toString());
        }
      }
    });
    return response;
  }
}
