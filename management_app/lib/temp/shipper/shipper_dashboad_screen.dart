// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';


// class ShipperDashboardScreen extends StatelessWidget {
//   ShipperDashboardScreen({super.key});
//   ValueNotifier<int> orderCount = ValueNotifier(0);
//   Future<void> getNumOfOrder() async {
//     orderCount.value = await StatisticRepository()
//         .getTotalOrderOfUserByTimeAndRole(GlobalVariable.currentUid,
//             GlobalVariable.roleId, 1, DateTime.now());
//   }

//   @override
//   Widget build(BuildContext context) {
//     getNumOfOrder();
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Container(
//               height: 300,
//               decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                     Color.fromRGBO(5, 167, 248, 1),
//                     Color.fromRGBO(5, 167, 248, 1),
//                     Color.fromRGBO(214, 250, 113, 1)
//                   ])),
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               color: Colors.transparent,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 60,
//                   ),
//                   Row(
//                     children: [
//                       const Text(
//                         'Hi ',
//                         maxLines: 1,
//                         style: const TextStyle(
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.white,
//                             overflow: TextOverflow.ellipsis),
//                       ),
//                       Expanded(
//                         child: Text(
//                           GlobalVariable.user.displayName,
//                           maxLines: 1,
//                           style: const TextStyle(
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               overflow: TextOverflow.ellipsis),
//                         ),
//                       )
//                     ],
//                   ),
//                   const Text(
//                     'This is some statistic recently',
//                     maxLines: 1,
//                     style: TextStyle(
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.white,
//                         overflow: TextOverflow.ellipsis),
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),

//                   //revenue month
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 10),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: const Color.fromRGBO(202, 213, 253, 0.6),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: const Icon(
//                             Icons.wallet_rounded,
//                             color: Colors.blue,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 8,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Earning this month',
//                               maxLines: 1,
//                               style: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.w400,
//                                   color: Color.fromRGBO(159, 159, 159, 1),
//                                   overflow: TextOverflow.ellipsis),
//                             ),
//                             FutureBuilder(
//                                 future: StatisticRepository()
//                                     .getEanrningOfShipperByTime(
//                                         GlobalVariable.currentUid,
//                                         2,
//                                         DateTime.now()),
//                                 builder: (context, snapshot) {
//                                   if (snapshot.connectionState ==
//                                           ConnectionState.done &&
//                                       snapshot.hasData) {
//                                     return Text(
//                                       NumberFormat.currency(
//                                               locale: 'vi_VN', symbol: '₫')
//                                           .format(snapshot.data),
//                                       maxLines: 1,
//                                       style: const TextStyle(
//                                           fontSize: 16.0,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                           overflow: TextOverflow.ellipsis),
//                                     );
//                                   }
//                                   return const SizedBox();
//                                 }),
//                           ],
//                         ),
//                         const Expanded(child: SizedBox()),
//                         TextButton(
//                           onPressed: () {},
//                           style: TextButton.styleFrom(
//                               backgroundColor: Colors.blue,
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10))),
//                           child: const Text(
//                             'More',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   //revenue day
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: const Color.fromRGBO(
//                                         202, 213, 253, 0.6),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: const Icon(
//                                     Icons.wallet_rounded,
//                                     color: Colors.blue,
//                                     size: 30,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 8,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Earning',
//                                       maxLines: 1,
//                                       style: TextStyle(
//                                           fontSize: 16.0,
//                                           fontWeight: FontWeight.w400,
//                                           color:
//                                               Color.fromRGBO(159, 159, 159, 1),
//                                           overflow: TextOverflow.ellipsis),
//                                     ),
//                                     FutureBuilder(
//                                         future: StatisticRepository()
//                                             .getEanrningOfShipperByTime(
//                                                 GlobalVariable.currentUid,
//                                                 1,
//                                                 DateTime.now()),
//                                         builder: (context, snapshot) {
//                                           if (snapshot.connectionState ==
//                                                   ConnectionState.done &&
//                                               snapshot.hasData) {
//                                             return Text(
//                                               NumberFormat.currency(
//                                                       locale: 'vi_VN',
//                                                       symbol: '₫')
//                                                   .format(snapshot.data),
//                                               maxLines: 1,
//                                               style: const TextStyle(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.black,
//                                                   overflow:
//                                                       TextOverflow.ellipsis),
//                                             );
//                                           }
//                                           return const SizedBox();
//                                         }),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 12,
//                             ),
//                             const Text(
//                               'Time',
//                               maxLines: 1,
//                               style: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.w400,
//                                   color: Color.fromRGBO(159, 159, 159, 1),
//                                   overflow: TextOverflow.ellipsis),
//                             ),
//                             Text(
//                               DateFormat.yMMMd("en_US")
//                                   .format(DateTime.now())
//                                   .toString(),
//                               maxLines: 1,
//                               style: const TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                   overflow: TextOverflow.ellipsis),
//                             ),
//                           ],
//                         ),
//                         const Expanded(child: SizedBox()),
//                         SizedBox(
//                           height: 100,
//                           width: 100,
//                           child: Stack(
//                             children: [
//                               SizedBox(
//                                 height: 100,
//                                 width: 100,
//                                 child: ValueListenableBuilder(
//                                     valueListenable: orderCount,
//                                     builder: (context, value, child) {
//                                       return CircularProgressIndicator(
//                                         backgroundColor: const Color.fromRGBO(
//                                             66, 36, 250, 0.2),
//                                         strokeWidth: 6,
//                                         value: value / 10,
//                                         valueColor:
//                                             const AlwaysStoppedAnimation<Color>(
//                                                 Colors.blue),
//                                       );
//                                     }),
//                               ),
//                               Center(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     ValueListenableBuilder(
//                                         valueListenable: orderCount,
//                                         builder: (context, value, child) {
//                                           return Text(
//                                             value.toString(),
//                                             maxLines: 1,
//                                             style: const TextStyle(
//                                                 fontSize: 16.0,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.black,
//                                                 overflow:
//                                                     TextOverflow.ellipsis),
//                                           );
//                                         }),
//                                     const Text(
//                                       '/10 Orders',
//                                       maxLines: 1,
//                                       style: const TextStyle(
//                                           fontSize: 14.0,
//                                           fontWeight: FontWeight.w400,
//                                           color: Colors.black,
//                                           overflow: TextOverflow.ellipsis),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 20,
//               left: 20,
//               child: GestureDetector(
//                 onTap: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//                 child: const Icon(
//                   CupertinoIcons.bars,
//                   size: 22,
//                   color: Colors.white,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
