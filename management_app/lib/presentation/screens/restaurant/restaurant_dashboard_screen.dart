import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/data/repositories/statistic_repository.dart';

class RestaurantDashboardScreen extends StatefulWidget {
  const RestaurantDashboardScreen({super.key});

  @override
  State<RestaurantDashboardScreen> createState() =>
      _RestaurantDashboardScreenState();
}

class _RestaurantDashboardScreenState extends State<RestaurantDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color.fromRGBO(5, 167, 248, 1),
                    Color.fromRGBO(5, 167, 248, 1),
                    Color.fromRGBO(214, 250, 113, 1)
                  ])),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Hi ',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Expanded(
                        child: Text(
                          GlobalVariable.profile!.displayName,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis),
                        ),
                      )
                    ],
                  ),
                  const Text(
                    'This is some statistic recently',
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  //revenue month
                  FutureBuilder(
                      future: StatisticRepository()
                          .getRestaurantOverview(DateTime.now(), context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            202, 213, 253, 0.6),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.wallet_rounded,
                                        color: Colors.blue,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Revenue this month',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  159, 159, 159, 1),
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        Text(
                                          NumberFormat.currency(
                                                  locale: 'vi_VN', symbol: '₫')
                                              .format(snapshot
                                                  .data!.totalRevenueInMonth),
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              overflow: TextOverflow.ellipsis),
                                        )
                                      ],
                                    ),
                                    const Expanded(child: SizedBox()),
                                    TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: const Text(
                                        'More',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              //revenue day
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    202, 213, 253, 0.6),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Icon(
                                                Icons.wallet_rounded,
                                                color: Colors.blue,
                                                size: 30,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Revenue',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromRGBO(
                                                          159, 159, 159, 1),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                                Text(
                                                  NumberFormat.currency(
                                                          locale: 'vi_VN',
                                                          symbol: '₫')
                                                      .format(snapshot.data!
                                                          .totalRevenueInDay),
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        const Text(
                                          'Time',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  159, 159, 159, 1),
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        Text(
                                          DateFormat.yMMMd("en_US")
                                              .format(DateTime.now())
                                              .toString(),
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ],
                                    ),
                                    const Expanded(child: SizedBox()),
                                    SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: CircularProgressIndicator(
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        66, 36, 250, 0.2),
                                                strokeWidth: 6,
                                                value: snapshot.data!
                                                        .totalSuccessOrder /
                                                    10,
                                                valueColor:
                                                    const AlwaysStoppedAnimation<
                                                        Color>(Colors.blue),
                                              )),
                                          Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!.totalSuccessOrder
                                                      .toString(),
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                                const Text(
                                                  '/10 Orders',
                                                  maxLines: 1,
                                                  style: TextStyle(
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
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        }
                        return const SizedBox();
                      })
                ],
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: const Icon(
                  CupertinoIcons.bars,
                  size: 22,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
