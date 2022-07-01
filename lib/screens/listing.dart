import 'package:crypto_app/controller/listingController.dart';
import 'package:crypto_app/controller/searchController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/app_colors.dart';

class ListingScreen extends StatelessWidget {
  ListingController listingController = Get.put(ListingController());
  SearchController searchController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgScaffold,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        automaticallyImplyLeading: false,
        title: const Text("CoinRich"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.pie_chart_outline,
                      color: AppColors.yellow,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Show Chart",
                      style: TextStyle(
                        color: AppColors.yellow,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Count",
                      style: TextStyle(
                        color: AppColors.yellow,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      " ${searchController.list.length}",
                      style: const TextStyle(
                        color: AppColors.yellow,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Size size = MediaQuery.of(context).size;
                  return GestureDetector(
                    onTap: () {
                      showShiftBottomSheet(context, size, index);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.black),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${searchController.list[index]['name']}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.yellow),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Price",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.grey2),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "\$${searchController.list[index]['quote']['USD']['price'].toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.grey2),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    searchController.list[index]['quote']['USD']
                                                ['percent_change_24h']
                                            .toString()
                                            .contains('-')
                                        ? const RotatedBox(
                                            quarterTurns: 3,
                                            child: Icon(
                                              Icons.arrow_back_sharp,
                                              color: AppColors.red,
                                            ),
                                          )
                                        : const RotatedBox(
                                            quarterTurns: 1,
                                            child: Icon(
                                              Icons.arrow_back_sharp,
                                              color: AppColors.green,
                                            ),
                                          ),
                                    Text(
                                      "${searchController.list[index]['quote']['USD']['percent_change_24h'].toStringAsFixed(2)}%",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.yellow),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Rank",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.grey2),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "${searchController.list[index]['cmc_rank']}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.grey2),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.btnBg,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 2),
                                    child: Text(
                                      "${searchController.list[index]['symbol']}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.grey2),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Icon(
                                  Icons.arrow_circle_right_sharp,
                                  size: 30.0,
                                  color: AppColors.yellow,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 12,
                  );
                },
                itemCount: searchController.list.length)
          ],
        ),
      ),
    );
  }

  showShiftBottomSheet(context, Size size, index) {
    DateTime now = DateTime.now();
    // String formattedDate = DateFormat("${}").format(now);
    // final DateFormat formatter = DateFormat('MM-dd-yyyy');
    // final String formatted = formatter
    //     .format(searchController.list[index]['quote']['USD']['last_updated'] as DateTime);

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        isDismissible: true,
        context: context,
        builder: (_) {
          return Container(
            padding: EdgeInsets.zero,
            height: size.height * 0.45,
            width: size.width,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        "${searchController.list[index]['name']}",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Tags",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Flexible(
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int i) {
                          return Container(
                            decoration:const  BoxDecoration(
                              color: AppColors.shadeOfWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${searchController.list[index]['tags'][i]}",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, int i) {
                          return const SizedBox(
                            width: 4,
                          );
                        },
                        itemCount: searchController.list[index]['tags'].length),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Price Last Updated",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                 const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "${searchController.list[index]['quote']['USD']['last_updated'].toString().substring(0, 10)}",
                    style: TextStyle(fontSize: 20, color: AppColors.green),
                  ),
                 const  SizedBox(
                    height: 55,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 95,
                      color: AppColors.yellow,
                      child: const Center(
                        child: Text(
                          "Close",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
        }).whenComplete(() {});
  }
}
