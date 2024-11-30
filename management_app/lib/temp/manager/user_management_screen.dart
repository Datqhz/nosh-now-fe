// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// class UserManagementScreen extends StatefulWidget {
//   const UserManagementScreen({super.key});

//   @override
//   State<UserManagementScreen> createState() => _UserManagementScreenState();
// }

// class _UserManagementScreenState extends State<UserManagementScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   ValueNotifier<List<Eater>?> eaters = ValueNotifier(null);
//   ValueNotifier<List<Merchant>?> merchants = ValueNotifier(null);
//   ValueNotifier<List<Shipper>?> shippers = ValueNotifier(null);

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     eaters.value = await EaterRepository().getAllEater();
//     merchants.value = await MerchantRepository().getAllMerchant();
//     shippers.value = await ShipperRepository().getAllShipper();
//   }

//   Widget eaterView() {
//     return ValueListenableBuilder(
//         valueListenable: eaters,
//         builder: (context, value, child) {
//           if (value != null) {
//             return Container(
//               height: MediaQuery.of(context).size.height,
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 120,
//                     ),
//                     ...List.generate(
//                       value.length,
//                       (index) => GestureDetector(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 6),
//                           child: UserItem(
//                             avatar: value[index].avatar,
//                             name: value[index].displayName,
//                             joinedDate: value[index].account!.createdDate,
//                             type: 1,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 80,
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }
//           return const Center(
//             child: SpinKitCircle(
//               color: Colors.black,
//               size: 50,
//             ),
//           );
//         });
//   }

//   Widget merchantView() {
//     return ValueListenableBuilder(
//         valueListenable: merchants,
//         builder: (context, value, child) {
//           if (value != null) {
//             return Container(
//               height: MediaQuery.of(context).size.height,
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 120,
//                     ),
//                     ...List.generate(
//                       value.length,
//                       (index) => GestureDetector(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 6),
//                           child: UserItem(
//                             avatar: value[index].avatar,
//                             name: value[index].displayName,
//                             joinedDate: value[index].account!.createdDate,
//                             type: 2,
//                             status: value[index].status ? 1 : 2,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 80,
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }
//           return const Center(
//             child: SpinKitCircle(
//               color: Colors.black,
//               size: 50,
//             ),
//           );
//         });
//   }

//   Widget shipperView() {
//     return ValueListenableBuilder(
//         valueListenable: shippers,
//         builder: (context, value, child) {
//           if (value != null) {
//             return Container(
//               height: MediaQuery.of(context).size.height,
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 120,
//                     ),
//                     ...List.generate(
//                       value.length,
//                       (index) => GestureDetector(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 6),
//                           child: UserItem(
//                             avatar: value[index].avatar,
//                             name: value[index].displayName,
//                             joinedDate: value[index].account!.createdDate,
//                             type: 2,
//                             status: value[index].status ? 3 : 4,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 80,
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }
//           return const Center(
//             child: SpinKitCircle(
//               color: Colors.black,
//               size: 50,
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       child: Stack(
//         children: [
//           TabBarView(
//             controller: _tabController,
//             children: [
//               eaterView(),
//               merchantView(),
//               shipperView(),
//             ],
//           ),
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               color: const Color.fromRGBO(240, 240, 240, 1),
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // drawer
//                       GestureDetector(
//                         onTap: () {
//                           // do something
//                           Scaffold.of(context).openDrawer();
//                         },
//                         child: const Icon(
//                           CupertinoIcons.bars,
//                           size: 24,
//                           color: Color.fromRGBO(49, 49, 49, 1),
//                         ),
//                       ),
//                       // search merchant
//                       GestureDetector(
//                         onTap: () {
//                           // do something
//                         },
//                         child: const Icon(
//                           CupertinoIcons.search,
//                           size: 24,
//                           color: Color.fromRGBO(49, 49, 49, 1),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   TabBar(
//                     unselectedLabelColor:
//                         const Color.fromRGBO(170, 184, 194, 1),
//                     indicatorSize: TabBarIndicatorSize.label,
//                     indicatorWeight: 3,
//                     indicatorColor: Colors.black,
//                     dividerColor: Colors.transparent,
//                     controller: _tabController,
//                     tabs: const [
//                       Text(
//                         'Eater',
//                         maxLines: 1,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color.fromRGBO(49, 49, 49, 1),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       Text(
//                         'Merchant',
//                         maxLines: 1,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color.fromRGBO(49, 49, 49, 1),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       Text(
//                         'Shipper',
//                         maxLines: 1,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color.fromRGBO(49, 49, 49, 1),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
