// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ManagerStatisticScreen extends StatefulWidget {
//   const ManagerStatisticScreen({super.key});

//   @override
//   State<ManagerStatisticScreen> createState() => _ManagerStatisticScreenState();
// }

// class _ManagerStatisticScreenState extends State<ManagerStatisticScreen> {
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
//           color: const Color.fromRGBO(240, 240, 240, 1),
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
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Statistic in ${titleChart()}',
//                         maxLines: 1,
//                         style: const TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromRGBO(49, 49, 49, 1),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 12,
//                     ),
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
//                 GridView.count(
//                   primary: false,
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 8,
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
//                                           .getTotalOrderByTime(
//                                               currentOption.value, value),
//                                       builder: (context, snapshot) {
//                                         int target = 0;
//                                         if (currentOption.value == 1) {
//                                           target = 100;
//                                         } else if (currentOption.value == 2) {
//                                           target = 5000;
//                                         } else {
//                                           target = 10000;
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
//                                                     style: TextStyle(
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
//                                 'Total transaction',
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
//                                           .getTotalTransaction(
//                                               currentOption.value, value),
//                                       builder: (context, snapshot) {
//                                         double target = 0;
//                                         if (currentOption.value == 1) {
//                                           target = 5000000;
//                                         } else if (currentOption.value == 2) {
//                                           target = 50000000;
//                                         } else {
//                                           target = 1000000000;
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
//                                               style: TextStyle(
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
//                               Icon(Icons.shopify_outlined,
//                                   color: Colors.blue[800], size: 24),
//                               const Text(
//                                 'New merchants',
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
//                                           .getNumOfNewUser(
//                                               3, currentOption.value, value),
//                                       builder: (context, snapshot) {
//                                         if (snapshot.connectionState ==
//                                                 ConnectionState.done &&
//                                             snapshot.hasData) {
//                                           return Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text(
//                                                 snapshot.data.toString(),
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
//                                               const Text(
//                                                 'Merchants',
//                                                 textAlign: TextAlign.center,
//                                                 maxLines: 1,
//                                                 style: TextStyle(
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
//                                         return const Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               '0',
//                                               textAlign: TextAlign.center,
//                                               maxLines: 1,
//                                               style: TextStyle(
//                                                 fontSize: 16.0,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Color.fromRGBO(
//                                                     49, 49, 49, 1),
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                             Text(
//                                               'Merchants',
//                                               textAlign: TextAlign.center,
//                                               maxLines: 1,
//                                               style: TextStyle(
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
//                               Icon(Icons.motorcycle,
//                                   color: Colors.blue[800], size: 24),
//                               const Text(
//                                 'New shippers',
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
//                                           .getNumOfNewUser(
//                                               4, currentOption.value, value),
//                                       builder: (context, snapshot) {
//                                         if (snapshot.connectionState ==
//                                                 ConnectionState.done &&
//                                             snapshot.hasData) {
//                                           return Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text(
//                                                 snapshot.data.toString(),
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
//                                               const Text(
//                                                 'Shippers',
//                                                 textAlign: TextAlign.center,
//                                                 maxLines: 1,
//                                                 style: TextStyle(
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
//                                         return const Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               '0',
//                                               textAlign: TextAlign.center,
//                                               maxLines: 1,
//                                               style: TextStyle(
//                                                 fontSize: 16.0,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Color.fromRGBO(
//                                                     49, 49, 49, 1),
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                             Text(
//                                               'Shippers',
//                                               textAlign: TextAlign.center,
//                                               maxLines: 1,
//                                               style: TextStyle(
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
