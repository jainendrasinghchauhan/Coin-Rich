import 'dart:convert';

import 'package:crypto_app/http/apiClient.dart';
import 'package:crypto_app/http/apiurl.dart';
import 'package:crypto_app/screens/listing.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  RxList list = [].obs;
  RxString endPoints = "".obs;
  RxBool isLoading = false.obs;

  getData() async {
    var headers = {
      'X-CMC_PRO_API_KEY': '27ab17d1-215f-49e5-9ca4-afd48810c149',
    };

    var response = await ApiClient()
        .getMethod(url: ApiUrl.searchUrl + endPoints.value, header: headers);

    if (response != null) {
      isLoading.value = false;
    }
    var json_body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      list.value.clear();
      Map data = {};
      data = json_body["data"];

      data.entries.forEach((element) {
        print("----key--" + element.key.toString());
        print("--value--" + element.value.toString());
        list.add(element.value);
      });

      Get.to(() => ListingScreen());
      print(list[0]['name']);
    }
  }
}




// var snackBar = SnackBar(
//           content: Text(json_body["message"]),
//           backgroundColor: AppColors.tealGreen,
//           duration: const Duration(milliseconds: 400));
      // ScaffoldMessenger.of(context!).showSnackBar(snackBar);