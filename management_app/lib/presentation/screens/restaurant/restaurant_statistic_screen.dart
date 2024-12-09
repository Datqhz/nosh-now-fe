import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_app/core/utils/time_picker.dart';
import 'package:management_app/data/repositories/statistic_repository.dart';
import 'package:management_app/data/requests/get_restaurant_statistic_request.dart';
import 'package:management_app/data/responses/get_restaurant_statistic_response.dart';

class RestaurantStatisticScreen extends StatefulWidget {
  const RestaurantStatisticScreen({super.key});

  @override
  State<RestaurantStatisticScreen> createState() =>
      _RestaurantStatisticScreenState();
}

class _RestaurantStatisticScreenState extends State<RestaurantStatisticScreen> {
  ValueNotifier<int> currentOption = ValueNotifier(1);
  ValueNotifier<DateTime> currentPick = ValueNotifier(DateTime.now());

  @override
  void initState() {
    super.initState();
  }

  String titleChart() {
    if (currentOption.value == 1) {
      return DateFormat('yyyy-MM-dd').format(currentPick.value);
    } else if (currentOption.value == 2) {
      return '${currentPick.value.year}-${currentPick.value.month}';
    } else {
      return currentPick.value.year.toString();
    }
  }

  Future<RestaurantStatisticData?> fetchData(BuildContext context) async {
    DateTime fromDate, toDate;
    var currentPickedTime = currentPick.value;
    if (currentOption.value == 1) {
      fromDate = DateTime(currentPickedTime.year, currentPickedTime.month,
          currentPickedTime.day);
      var temp = DateTime(currentPickedTime.year, currentPickedTime.month,
          currentPickedTime.day + 1);
      toDate = temp.subtract(const Duration(seconds: 1));
    } else if (currentOption.value == 2) {
      fromDate = DateTime(currentPickedTime.year, currentPickedTime.month);
      var temp = DateTime(currentPickedTime.year, currentPickedTime.month + 1);
      toDate = temp.subtract(const Duration(seconds: 1));
    } else {
      fromDate = DateTime(currentPickedTime.year);
      var temp = DateTime(currentPickedTime.year + 1);
      toDate = temp.subtract(const Duration(seconds: 1));
    }

    final request =
        GetRestaurantStatisticRequest(fromDate: fromDate, toDate: toDate);
    return await StatisticRepository().getRestaurantStatistic(request, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              color: const Color.fromARGB(15, 240, 240, 240),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(226, 226, 226, 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: ValueListenableBuilder(
                          valueListenable: currentOption,
                          builder: (context, value, child) {
                            return Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      currentOption.value = 1;
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: value == 1
                                              ? Colors.black
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        'Day',
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: value == 1
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  49, 49, 49, 1),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      currentOption.value = 2;
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: value == 2
                                              ? Colors.black
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        'Month',
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: value == 2
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  49, 49, 49, 1),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      currentOption.value = 3;
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: value == 3
                                              ? Colors.black
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        'Year',
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: value == 3
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  49, 49, 49, 1),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Revenue detail',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(49, 49, 49, 1),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () async {
                            DateTime? picked =
                                await selectDate(context, currentOption.value);
                            if (picked != null) {
                              currentPick.value = picked;
                            }
                          },
                          child: const Icon(
                            CupertinoIcons.calendar,
                            color: Color.fromRGBO(49, 49, 49, 1),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ValueListenableBuilder(
                          valueListenable: currentPick,
                          builder: (context, value, child) {
                            return Text(
                              'Total revenue in ${titleChart()}',
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(49, 49, 49, 1),
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ValueListenableBuilder(
                        valueListenable: currentPick,
                        builder: (context, value, child) {
                          return FutureBuilder(
                              future: fetchData(context),
                              builder: (context, snapshot) {
                                double revenueTarget = 0;
                                int totalSuccessOrderTarget = 0;
                                int totalRejectOrderTarget = 0;

                                if (currentOption.value == 1) {
                                  revenueTarget = 1000000;
                                  totalSuccessOrderTarget = 10;
                                  totalRejectOrderTarget = 5;
                                } else if (currentOption.value == 2) {
                                  revenueTarget = 10000000;
                                  totalSuccessOrderTarget = 50;
                                  totalRejectOrderTarget = 25;
                                } else {
                                  revenueTarget = 100000000;
                                  totalSuccessOrderTarget = 100;
                                  totalRejectOrderTarget = 40;
                                }
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width),
                                        height:
                                            (MediaQuery.of(context).size.width /
                                                2),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                width: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.2),
                                                height: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.2),
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          66, 36, 250, 0.2),
                                                  strokeWidth: 10,
                                                  value: snapshot
                                                          .data!.totalRevenue /
                                                      revenueTarget,
                                                  valueColor:
                                                      const AlwaysStoppedAnimation<
                                                          Color>(Colors.blue),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    NumberFormat.currency(
                                                            locale: 'vi_VN',
                                                            symbol: '₫')
                                                        .format(snapshot.data!
                                                            .totalRevenue),
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  Text(
                                                    '/${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(revenueTarget)}',
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'Top 5 best-selling',
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(49, 49, 49, 1),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            'Best-selling in ${titleChart()}',
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromRGBO(49, 49, 49, 1),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: BarChartVerticle(
                                          foods: snapshot.data!.topFoods,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      GridView.count(
                                        primary: false,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 12,
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            margin:
                                                const EdgeInsets.only(left: 1),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    offset: Offset(0.2, 0.6),
                                                    blurRadius: 2)
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(CupertinoIcons.news,
                                                        color: Colors.blue[800],
                                                        size: 24),
                                                    const Text(
                                                      'Success order',
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            49, 49, 49, 1),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Expanded(
                                                    child: Stack(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: SizedBox(
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            80),
                                                        height: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            80),
                                                        child:
                                                            CircularProgressIndicator(
                                                          backgroundColor:
                                                              const Color
                                                                  .fromRGBO(66,
                                                                  36, 250, 0.2),
                                                          strokeWidth: 6,
                                                          value: snapshot.data!
                                                                  .totalSuccessOrder /
                                                              totalSuccessOrderTarget,
                                                          valueColor:
                                                              const AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.blue),
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            snapshot.data!
                                                                .totalSuccessOrder
                                                                .toString(),
                                                            maxLines: 1,
                                                            style: const TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                          ),
                                                          Text(
                                                            '/$totalSuccessOrderTarget Orders',
                                                            maxLines: 1,
                                                            style: const TextStyle(
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ))
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            margin:
                                                const EdgeInsets.only(right: 1),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    offset: Offset(0.2, 0.6),
                                                    blurRadius: 2)
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                        CupertinoIcons
                                                            .money_dollar,
                                                        color: Colors.blue[800],
                                                        size: 24),
                                                    const Text(
                                                      'Total revenue',
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            49, 49, 49, 1),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      NumberFormat.currency(
                                                              locale: 'vi_VN',
                                                              symbol: '₫')
                                                          .format(snapshot.data!
                                                              .totalRevenue),
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            49, 49, 49, 1),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Text(
                                                      '/${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(revenueTarget)}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            49, 49, 49, 1),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            margin:
                                                const EdgeInsets.only(left: 1),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    offset: Offset(0.2, 0.6),
                                                    blurRadius: 2)
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(CupertinoIcons.news,
                                                        color: Colors.blue[800],
                                                        size: 24),
                                                    const Text(
                                                      'Rejected orders',
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            49, 49, 49, 1),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Expanded(
                                                    child: Stack(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: SizedBox(
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            80),
                                                        height: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            80),
                                                        child:
                                                            CircularProgressIndicator(
                                                          backgroundColor:
                                                              const Color
                                                                  .fromRGBO(66,
                                                                  36, 250, 0.2),
                                                          strokeWidth: 6,
                                                          value: snapshot.data!
                                                                  .totalSuccessOrder /
                                                              totalSuccessOrderTarget,
                                                          valueColor:
                                                              const AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.blue),
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            snapshot.data!
                                                                .totalRejectedOrder
                                                                .toString(),
                                                            maxLines: 1,
                                                            style: const TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                          ),
                                                          Text(
                                                            '/$totalRejectOrderTarget Orders',
                                                            maxLines: 1,
                                                            style: const TextStyle(
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ))
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(right: 1),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      offset: Offset(0.2, 0.6),
                                                      blurRadius: 1)
                                                ]),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(CupertinoIcons.news,
                                                        color: Colors.blue[800],
                                                        size: 24),
                                                    const Text(
                                                      'Failed orders',
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            49, 49, 49, 1),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Expanded(
                                                    child: Stack(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: SizedBox(
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            80),
                                                        height: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            80),
                                                        child:
                                                            CircularProgressIndicator(
                                                          backgroundColor:
                                                              const Color
                                                                  .fromRGBO(66,
                                                                  36, 250, 0.2),
                                                          strokeWidth: 6,
                                                          value: snapshot.data!
                                                                  .totalSuccessOrder /
                                                              totalSuccessOrderTarget,
                                                          valueColor:
                                                              const AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.blue),
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            snapshot.data!
                                                                .totalFailedOrder
                                                                .toString(),
                                                            maxLines: 1,
                                                            style: const TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                          ),
                                                          Text(
                                                            '/$totalRejectOrderTarget Orders',
                                                            maxLines: 1,
                                                            style: const TextStyle(
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                                return const SizedBox();
                              });
                        }),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                color: const Color.fromRGBO(240, 240, 240, 1),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // drawer
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        CupertinoIcons.arrow_left,
                        size: 24,
                        color: Color.fromRGBO(49, 49, 49, 1),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // do something
                      },
                      child: const Icon(
                        Icons.download,
                        size: 24,
                        color: Color.fromRGBO(49, 49, 49, 1),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BarChartVerticle extends StatelessWidget {
  BarChartVerticle({super.key, required this.foods});

  List<TopFoodData> foods;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: roundToNearest(findMaxRevenue()) / 1.0 + 60,
      ),
    );
  }

  double findMaxRevenue() {
    double rs = 0;
    for (var food in foods) {
      if (food.totalRevenue > rs) {
        rs = food.totalRevenue;
      }
    }
    return rs;
  }

  int roundToNearest(double value) {
    return (value / 1000).round();
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Color.fromRGBO(49, 49, 49, 1),
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(foods[value.toInt()].foodName, style: style),
    );
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    print(value);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(value.toInt().toString(), style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
          axisNameWidget: const Text(
            'Food name',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getLeftTitles,
          ),
          axisNameWidget: const Text(
            'Revenue (k₫)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Color.fromRGBO(255, 198, 86, 1),
          Color.fromRGBO(241, 96, 99, 1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  List<BarChartGroupData> get barGroups => List.generate(
      foods.length,
      (index) => BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: double.parse(
                    (foods[index].totalRevenue / 1000).toStringAsFixed(1)),
                gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: [0],
          ));
}
