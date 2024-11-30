// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:provider/provider.dart';

// class FoodManagementScreen extends StatefulWidget {
//   const FoodManagementScreen({super.key});

//   @override
//   State<FoodManagementScreen> createState() => _FoodManagementScreenState();
// }

// class _FoodManagementScreenState extends State<FoodManagementScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final ValueNotifier _isShowSeachBar = ValueNotifier(false);

//   @override
//   void initState() {
//     super.initState();
//     Provider.of<FoodListProvider>(context, listen: false)
//         .fetchFoods(GlobalVariable.currentUid);
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
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 70,
//               ),
//               ValueListenableBuilder(
//                   valueListenable: _isShowSeachBar,
//                   builder: (context, value, child) {
//                     if (value) {
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 12),
//                         child: TextFormField(
//                           controller: _nameController,
//                           decoration: InputDecoration(
//                             suffixIcon: IconButton(
//                                 onPressed: () {
//                                   Provider.of<FoodListProvider>(context,
//                                           listen: false)
//                                       .filterFoodByName('');
//                                   _nameController.text = '';
//                                 },
//                                 icon: const Icon(
//                                   CupertinoIcons.xmark,
//                                   color: Color.fromRGBO(49, 49, 49, 1),
//                                   size: 18,
//                                 )),
//                             enabledBorder: const UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Color.fromRGBO(159, 159, 159, 1),
//                                   width: 1), // Màu viền khi không được chọn
//                             ),
//                             focusedBorder: const UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Color.fromRGBO(159, 159, 159, 1),
//                                 width: 1,
//                               ),
//                             ),
//                             hintText: 'ex. Pho, Pizza',
//                             hintStyle: const TextStyle(
//                                 color: Color.fromRGBO(49, 49, 49, 0.5)),
//                             border: InputBorder.none,
//                           ),
//                           style: const TextStyle(
//                               color: Color.fromRGBO(49, 49, 49, 1),
//                               fontSize: 14,
//                               decoration: TextDecoration.none),
//                           onChanged: (value) {
//                             Provider.of<FoodListProvider>(context,
//                                     listen: false)
//                                 .filterFoodByName(value);
//                           },
//                         ),
//                       );
//                     }
//                     return const SizedBox();
//                   }),
//               Row(
//                 children: [
//                   const Text(
//                     'Your foods',
//                     maxLines: 1,
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromRGBO(49, 49, 49, 1),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   const Expanded(child: SizedBox()),
//                   IconButton(
//                       onPressed: () {
//                         _isShowSeachBar.value = !_isShowSeachBar.value;
//                       },
//                       icon: const Icon(
//                         CupertinoIcons.search,
//                         color: Color.fromRGBO(49, 49, 49, 1),
//                       ))
//                 ],
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               // list merchant
//               Expanded(
//                 child: Consumer<FoodListProvider>(
//                     builder: (context, provider, child) {
//                   if (provider.isLoading) {
//                     return const Center(
//                         child: SpinKitCircle(
//                       color: Colors.black,
//                       size: 50,
//                     ));
//                   }
//                   return ListView.builder(
//                     itemCount: provider.foods.length,
//                     itemBuilder: (context, index) {
//                       final item = provider.foods[index];
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 8),
//                         child: FoodManagementItem(
//                           food: item,
//                         ),
//                       );
//                     },
//                   );
//                 }),
//               ),
//               const SizedBox(
//                 height: 70,
//               ),
//             ],
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
//                 // add
//                 GestureDetector(
//                   onTap: () async {
//                     Food? temp = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ModifyFoodScreen()));
//                     if (temp != null) {
//                       Provider.of<FoodListProvider>(context, listen: false)
//                           .addFood(temp);
//                     }
//                   },
//                   child: const Icon(
//                     CupertinoIcons.add,
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
