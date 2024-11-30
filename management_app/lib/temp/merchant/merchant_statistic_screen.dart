// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class MerchantStatisticScreen extends StatefulWidget {
//   const MerchantStatisticScreen({super.key});

//   @override
//   State<MerchantStatisticScreen> createState() =>
//       _MerchantStatisticScreenState();
// }

// class _MerchantStatisticScreenState extends State<MerchantStatisticScreen> {
//   ValueNotifier<int> currentOption = ValueNotifier(1);
//   ValueNotifier<DateTime> currentPick = ValueNotifier(DateTime.now());

//   String titleChart() {
//     if (currentOption.value == 1) {
//       return DateFormat('yyyy-MM-dd').format(currentPick.value);
//     } else if (currentOption.value == 2) {
//       return '${currentPick.value.year}-${currentPick.value.month}';
//     } else {
//       return currentPick.value.year.toString();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           color: const Color.fromARGB(15, 240, 240, 240),
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 70,
//                 ),
//                 Container(
//                   height: 36,
//                   decoration: BoxDecoration(
//                       color: const Color.fromRGBO(226, 226, 226, 1),
//                       borderRadius: BorderRadius.circular(20)),
//                   child: ValueListenableBuilder(
//                       valueListenable: currentOption,
//                       builder: (context, value, child) {
//                         return Row(
//                           children: [
//                             Expanded(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   currentOption.value = 1;
//                                 },
//                                 child: Container(
//                                   height: double.infinity,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                       color: value == 1
//                                           ? Colors.black
//                                           : Colors.transparent,
//                                       borderRadius: BorderRadius.circular(20)),
//                                   child: Text(
//                                     'Day',
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       fontWeight: FontWeight.bold,
//                                       color: value == 1
//                                           ? Colors.white
//                                           : const Color.fromRGBO(49, 49, 49, 1),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   currentOption.value = 2;
//                                 },
//                                 child: Container(
//                                   height: double.infinity,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                       color: value == 2
//                                           ? Colors.black
//                                           : Colors.transparent,
//                                       borderRadius: BorderRadius.circular(20)),
//                                   child: Text(
//                                     'Month',
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       fontWeight: FontWeight.bold,
//                                       color: value == 2
//                                           ? Colors.white
//                                           : const Color.fromRGBO(49, 49, 49, 1),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   currentOption.value = 3;
//                                 },
//                                 child: Container(
//                                   height: double.infinity,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                       color: value == 3
//                                           ? Colors.black
//                                           : Colors.transparent,
//                                       borderRadius: BorderRadius.circular(20)),
//                                   child: Text(
//                                     'Year',
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       fontWeight: FontWeight.bold,
//                                       color: value == 3
//                                           ? Colors.white
//                                           : const Color.fromRGBO(49, 49, 49, 1),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         );
//                       }),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: [
//                     const Text(
//                       'Revenue detail',
//                       maxLines: 1,
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromRGBO(49, 49, 49, 1),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     const Expanded(child: SizedBox()),
//                     GestureDetector(
//                       onTap: () async {
//                         DateTime? picked =
//                             await selectDate(context, currentOption.value);
//                         if (picked != null) {
//                           print(picked.toString());
//                           currentPick.value = picked;
//                         }
//                       },
//                       child: const Icon(
//                         CupertinoIcons.calendar,
//                         color: Color.fromRGBO(49, 49, 49, 1),
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ValueListenableBuilder(
//                       valueListenable: currentPick,
//                       builder: (context, value, child) {
//                         return Text(
//                           'Total revenue in ${titleChart()}',
//                           textAlign: TextAlign.left,
//                           maxLines: 1,
//                           style: const TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromRGBO(49, 49, 49, 1),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         );
//                       }),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 ValueListenableBuilder(
//                     valueListenable: currentPick,
//                     builder: (context, value, child) {
//                       return SizedBox(
//                         width: (MediaQuery.of(context).size.width),
//                         height: (MediaQuery.of(context).size.width / 2),
//                         child: FutureBuilder(
//                             future: StatisticRepository()
//                                 .getRevenueOfMerchantByTime(
//                                     GlobalVariable.currentUid,
//                                     currentOption.value,
//                                     value),
//                             builder: (context, snapshot) {
//                               double target = 0;
//                               if (currentOption.value == 1) {
//                                 target = 1000000;
//                               } else if (currentOption.value == 2) {
//                                 target = 10000000;
//                               } else {
//                                 target = 100000000;
//                               }
//                               if (snapshot.connectionState ==
//                                       ConnectionState.done &&
//                                   snapshot.hasData) {
//                                 return Stack(
//                                   children: [
//                                     Align(
//                                       alignment: Alignment.center,
//                                       child: SizedBox(
//                                         width:
//                                             (MediaQuery.of(context).size.width /
//                                                 2.2),
//                                         height:
//                                             (MediaQuery.of(context).size.width /
//                                                 2.2),
//                                         child: CircularProgressIndicator(
//                                           backgroundColor: const Color.fromRGBO(
//                                               66, 36, 250, 0.2),
//                                           strokeWidth: 10,
//                                           value: snapshot.data! / target,
//                                           valueColor:
//                                               const AlwaysStoppedAnimation<
//                                                   Color>(Colors.blue),
//                                         ),
//                                       ),
//                                     ),
//                                     Center(
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             NumberFormat.currency(
//                                                     locale: 'vi_VN',
//                                                     symbol: '₫')
//                                                 .format(snapshot.data!),
//                                             maxLines: 1,
//                                             style: const TextStyle(
//                                                 fontSize: 16.0,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.black,
//                                                 overflow:
//                                                     TextOverflow.ellipsis),
//                                           ),
//                                           Text(
//                                             '/${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(target)}',
//                                             maxLines: 1,
//                                             style: const TextStyle(
//                                                 fontSize: 14.0,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Colors.black,
//                                                 overflow:
//                                                     TextOverflow.ellipsis),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 );
//                               }
//                               return Stack(
//                                 children: [
//                                   Align(
//                                     alignment: Alignment.center,
//                                     child: SizedBox(
//                                       width:
//                                           (MediaQuery.of(context).size.width /
//                                               2.2),
//                                       height:
//                                           (MediaQuery.of(context).size.width /
//                                               2.2),
//                                       child: const CircularProgressIndicator(
//                                         backgroundColor:
//                                             Color.fromRGBO(66, 36, 250, 0.2),
//                                         strokeWidth: 10,
//                                         value: 0,
//                                         valueColor:
//                                             AlwaysStoppedAnimation<Color>(
//                                                 Colors.blue),
//                                       ),
//                                     ),
//                                   ),
//                                   Center(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         const Text(
//                                           '0',
//                                           maxLines: 1,
//                                           style: TextStyle(
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.black,
//                                               overflow: TextOverflow.ellipsis),
//                                         ),
//                                         Text(
//                                           '/$target₫',
//                                           maxLines: 1,
//                                           style: const TextStyle(
//                                               fontSize: 14.0,
//                                               fontWeight: FontWeight.w400,
//                                               color: Colors.black,
//                                               overflow: TextOverflow.ellipsis),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               );
//                             }),
//                       );
//                     }),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text(
//                   'Top 5 best-selling',
//                   maxLines: 1,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromRGBO(49, 49, 49, 1),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ValueListenableBuilder(
//                       valueListenable: currentPick,
//                       builder: (context, value, child) {
//                         return Text(
//                           'Best-selling in ${titleChart()}',
//                           textAlign: TextAlign.center,
//                           maxLines: 1,
//                           style: const TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromRGBO(49, 49, 49, 1),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         );
//                       }),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 ValueListenableBuilder(
//                     valueListenable: currentPick,
//                     builder: (context, value, child) {
//                       return FutureBuilder(
//                           future: StatisticRepository().getTop5FoodBestSelling(
//                               GlobalVariable.currentUid,
//                               currentOption.value,
//                               value),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                     ConnectionState.done &&
//                                 snapshot.hasData) {
//                               return AspectRatio(
//                                 aspectRatio: 1,
//                                 child: BarChartVerticle(
//                                   foods: snapshot.data!,
//                                 ),
//                               );
//                             }
//                             return AspectRatio(
//                               aspectRatio: 1,
//                               child: BarChartVerticle(foods: []),
//                             );
//                           });
//                     }),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 GridView.count(
//                   primary: false,
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 2,
//                   crossAxisCount: 2,
//                   childAspectRatio: 1,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.white,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(CupertinoIcons.news,
//                                   color: Colors.blue[800], size: 24),
//                               const Text(
//                                 'Total order',
//                                 textAlign: TextAlign.center,
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color.fromRGBO(49, 49, 49, 1),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           Expanded(
//                             child: ValueListenableBuilder(
//                                 valueListenable: currentPick,
//                                 builder: (context, value, child) {
//                                   return FutureBuilder(
//                                       future: StatisticRepository()
//                                           .getTotalOrderOfUserByTimeAndRole(
//                                               GlobalVariable.currentUid,
//                                               GlobalVariable.roleId,
//                                               currentOption.value,
//                                               value),
//                                       builder: (context, snapshot) {
//                                         int target = 0;
//                                         if (currentOption.value == 1) {
//                                           target = 10;
//                                         } else if (currentOption.value == 2) {
//                                           target = 50;
//                                         } else {
//                                           target = 100;
//                                         }
//                                         if (snapshot.connectionState ==
//                                                 ConnectionState.done &&
//                                             snapshot.hasData) {
//                                           return Stack(
//                                             children: [
//                                               Align(
//                                                 alignment: Alignment.center,
//                                                 child: SizedBox(
//                                                   width: (MediaQuery.of(context)
//                                                               .size
//                                                               .width /
//                                                           2 -
//                                                       80),
//                                                   height:
//                                                       (MediaQuery.of(context)
//                                                                   .size
//                                                                   .width /
//                                                               2 -
//                                                           80),
//                                                   child:
//                                                       CircularProgressIndicator(
//                                                     backgroundColor:
//                                                         const Color.fromRGBO(
//                                                             66, 36, 250, 0.2),
//                                                     strokeWidth: 6,
//                                                     value:
//                                                         snapshot.data! / target,
//                                                     valueColor:
//                                                         const AlwaysStoppedAnimation<
//                                                             Color>(Colors.blue),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Center(
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   children: [
//                                                     Text(
//                                                       snapshot.data!.toString(),
//                                                       maxLines: 1,
//                                                       style: const TextStyle(
//                                                           fontSize: 16.0,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           color: Colors.black,
//                                                           overflow: TextOverflow
//                                                               .ellipsis),
//                                                     ),
//                                                     Text(
//                                                       '/$target Orders',
//                                                       maxLines: 1,
//                                                       style: const TextStyle(
//                                                           fontSize: 14.0,
//                                                           fontWeight:
//                                                               FontWeight.w400,
//                                                           color: Colors.black,
//                                                           overflow: TextOverflow
//                                                               .ellipsis),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           );
//                                         }
//                                         return Stack(
//                                           children: [
//                                             Align(
//                                               alignment: Alignment.center,
//                                               child: SizedBox(
//                                                 width: (MediaQuery.of(context)
//                                                             .size
//                                                             .width /
//                                                         2 -
//                                                     80),
//                                                 height: (MediaQuery.of(context)
//                                                             .size
//                                                             .width /
//                                                         2 -
//                                                     80),
//                                                 child:
//                                                     const CircularProgressIndicator(
//                                                   backgroundColor:
//                                                       Color.fromRGBO(
//                                                           66, 36, 250, 0.2),
//                                                   strokeWidth: 6,
//                                                   value: 0,
//                                                   valueColor:
//                                                       AlwaysStoppedAnimation<
//                                                           Color>(Colors.blue),
//                                                 ),
//                                               ),
//                                             ),
//                                             Center(
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 children: [
//                                                   const Text(
//                                                     '0',
//                                                     maxLines: 1,
//                                                     style: const TextStyle(
//                                                         fontSize: 16.0,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color: Colors.black,
//                                                         overflow: TextOverflow
//                                                             .ellipsis),
//                                                   ),
//                                                   Text(
//                                                     '/$target Orders',
//                                                     maxLines: 1,
//                                                     style: const TextStyle(
//                                                         fontSize: 14.0,
//                                                         fontWeight:
//                                                             FontWeight.w400,
//                                                         color: Colors.black,
//                                                         overflow: TextOverflow
//                                                             .ellipsis),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )
//                                           ],
//                                         );
//                                       });
//                                 }),
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.white,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(CupertinoIcons.money_dollar,
//                                   color: Colors.blue[800], size: 24),
//                               const Text(
//                                 'Total revenue',
//                                 textAlign: TextAlign.center,
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color.fromRGBO(49, 49, 49, 1),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           Expanded(
//                             child: ValueListenableBuilder(
//                                 valueListenable: currentPick,
//                                 builder: (context, value, child) {
//                                   return FutureBuilder(
//                                       future: StatisticRepository()
//                                           .getRevenueOfMerchantByTime(
//                                               GlobalVariable.currentUid,
//                                               currentOption.value,
//                                               value),
//                                       builder: (context, snapshot) {
//                                         double target = 0;
//                                         if (currentOption.value == 1) {
//                                           target = 1000000;
//                                         } else if (currentOption.value == 2) {
//                                           target = 10000000;
//                                         } else {
//                                           target = 100000000;
//                                         }
//                                         if (snapshot.connectionState ==
//                                                 ConnectionState.done &&
//                                             snapshot.hasData) {
//                                           return Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text(
//                                                 NumberFormat.currency(
//                                                         locale: 'vi_VN',
//                                                         symbol: '₫')
//                                                     .format(snapshot.data),
//                                                 textAlign: TextAlign.center,
//                                                 maxLines: 1,
//                                                 style: const TextStyle(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Color.fromRGBO(
//                                                       49, 49, 49, 1),
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 '/${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(target)}',
//                                                 textAlign: TextAlign.center,
//                                                 maxLines: 1,
//                                                 style: const TextStyle(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Color.fromRGBO(
//                                                       49, 49, 49, 1),
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                 ),
//                                               ),
//                                             ],
//                                           );
//                                         }
//                                         return Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             const Text(
//                                               '0',
//                                               textAlign: TextAlign.center,
//                                               maxLines: 1,
//                                               style: const TextStyle(
//                                                 fontSize: 16.0,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Color.fromRGBO(
//                                                     49, 49, 49, 1),
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                             Text(
//                                               '/${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(target)}',
//                                               textAlign: TextAlign.center,
//                                               maxLines: 1,
//                                               style: const TextStyle(
//                                                 fontSize: 16.0,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Color.fromRGBO(
//                                                     49, 49, 49, 1),
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                           ],
//                                         );
//                                       });
//                                 }),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 100,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           top: 0,
//           left: 0,
//           right: 0,
//           child: Container(
//             height: 50,
//             color: const Color.fromRGBO(240, 240, 240, 1),
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // drawer
//                 GestureDetector(
//                   onTap: () {
//                     Scaffold.of(context).openDrawer();
//                   },
//                   child: const Icon(
//                     CupertinoIcons.bars,
//                     size: 24,
//                     color: Color.fromRGBO(49, 49, 49, 1),
//                   ),
//                 ),
//                 // search merchant
//                 GestureDetector(
//                   onTap: () {
//                     // do something
//                   },
//                   child: const Icon(
//                     Icons.download,
//                     size: 24,
//                     color: Color.fromRGBO(49, 49, 49, 1),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// class BarChartVerticle extends StatelessWidget {
//   BarChartVerticle({super.key, required this.foods});

//   List<TopFood> foods;
//   @override
//   Widget build(BuildContext context) {
//     return BarChart(
//       BarChartData(
//         barTouchData: barTouchData,
//         titlesData: titlesData,
//         borderData: borderData,
//         barGroups: barGroups,
//         gridData: const FlGridData(show: true, drawVerticalLine: false),
//         alignment: BarChartAlignment.spaceAround,
//         maxY: roundToNearest(findMaxRevenue()) / 1.0 + 60,
//       ),
//     );
//   }

//   double findMaxRevenue() {
//     double rs = 0;
//     for (var food in foods) {
//       if (food.revenue > rs) {
//         rs = food.revenue;
//       }
//     }
//     return rs;
//   }

//   int roundToNearest(double value) {
//     return (value / 1000).round();
//   }

//   BarTouchData get barTouchData => BarTouchData(
//         enabled: false,
//         touchTooltipData: BarTouchTooltipData(
//           getTooltipColor: (group) => Colors.transparent,
//           tooltipPadding: EdgeInsets.zero,
//           tooltipMargin: 8,
//           getTooltipItem: (
//             BarChartGroupData group,
//             int groupIndex,
//             BarChartRodData rod,
//             int rodIndex,
//           ) {
//             return BarTooltipItem(
//               rod.toY.round().toString(),
//               const TextStyle(
//                 color: Color.fromRGBO(49, 49, 49, 1),
//                 fontWeight: FontWeight.bold,
//               ),
//             );
//           },
//         ),
//       );

//   Widget getTitles(double value, TitleMeta meta) {
//     const style = const TextStyle(
//       color: Colors.black,
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//     );

//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 4,
//       child: Text(foods[value.toInt()].foodName, style: style),
//     );
//   }

//   Widget getLeftTitles(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Colors.black,
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//     );
//     print(value);
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 4,
//       child: Text(value.toInt().toString(), style: style),
//     );
//   }

//   FlTitlesData get titlesData => FlTitlesData(
//         show: true,
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             getTitlesWidget: getTitles,
//           ),
//           axisNameWidget: const Text(
//             'Food name',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//             ),
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             getTitlesWidget: getLeftTitles,
//           ),
//           axisNameWidget: const Text(
//             'Revenue (k₫)',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//             ),
//           ),
//         ),
//         topTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         rightTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//       );

//   FlBorderData get borderData => FlBorderData(
//         show: false,
//       );

//   LinearGradient get _barsGradient => const LinearGradient(
//         colors: [
//           Color.fromRGBO(255, 198, 86, 1),
//           Color.fromRGBO(241, 96, 99, 1),
//         ],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       );

//   List<BarChartGroupData> get barGroups => List.generate(
//       foods.length,
//       (index) => BarChartGroupData(
//             x: index,
//             barRods: [
//               BarChartRodData(
//                 toY: double.parse(
//                     (foods[index].revenue / 1000).toStringAsFixed(1)),
//                 gradient: _barsGradient,
//               )
//             ],
//             showingTooltipIndicators: [0],
//           ));
// }
