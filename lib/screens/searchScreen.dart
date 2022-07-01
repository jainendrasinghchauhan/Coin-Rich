import 'package:crypto_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/searchController.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchController _searchController = Get.put(SearchController());
    final TextEditingController searchController = TextEditingController();

    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.bgScaffold,
        appBar: AppBar(
          backgroundColor: AppColors.black,
          automaticallyImplyLeading: false,
          title: const Text("CoinRich"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 90,
              child: TextFormField(
                inputFormatters: [UpperCaseTextFormatter()],
                controller: searchController,
                onChanged: (input) {
                  // ignore: unrelated_type_equality_checks
                  if (input.isEmpty) {
                    _searchController.endPoints.value = "";
                  }
                  _searchController.endPoints.value = input;
                },
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey2),
                cursorColor: AppColors.grey2,
                decoration: InputDecoration(
                  fillColor: AppColors.black,
                  filled: true,
                  isDense: true,
                  hintText: "Enter Coin Symbol",
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w600, color: AppColors.grey2),
                  contentPadding: const EdgeInsets.only(
                    bottom: 15,
                    left: 20,
                    top: 15,
                    right: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.grey2,
                    size: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: !_searchController.isLoading.value
                  ? () {
                      _searchController.getData();
                      _searchController.isLoading.value = true;
                      if (_searchController.endPoints.value.length == 0) {
                        _searchController.endPoints.value = "";
                        var snackBar = const SnackBar(
                            content: Text(
                              "Type in to search",
                              style: TextStyle(color: AppColors.grey2),
                            ),
                            backgroundColor: AppColors.black,
                            duration: Duration(milliseconds: 2000));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  : null,
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * .90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.yellow),
                child: !_searchController.isLoading.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "SEARCH",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 30.0,
                            color: AppColors.black,
                          ),
                        ],
                      )
                    : Center(
                        child: Container(
                            height: 30,
                            width: 30,
                            child: const CircularProgressIndicator(
                              color: AppColors.black,
                            )),
                      ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
