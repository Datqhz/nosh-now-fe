// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import 'package:provider/provider.dart';

// class FoodDetailManagementScreen extends StatelessWidget {
//   FoodDetailManagementScreen({
//     super.key,
//     required this.food,
//   });

//   Food food;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
//       body: SafeArea(
//         child: Consumer<FoodListProvider>(builder: (context, provider, child) {
//           final updatedFood = provider.foods
//               .firstWhere((f) => f.foodId == food.foodId, orElse: () => food);
//           return Stack(
//             children: [
//               // food image
//               Column(
//                 children: [
//                   Image(
//                     image: MemoryImage(
//                         convertBase64ToUint8List(updatedFood.foodImage)),
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height / 2.4,
//                     fit: BoxFit.cover,
//                   ),
//                 ],
//               ),
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   height: MediaQuery.of(context).size.height / 1.7,
//                   width: MediaQuery.of(context).size.width,
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   decoration: const BoxDecoration(
//                     color: Color.fromRGBO(240, 240, 240, 1),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(40),
//                       topRight: Radius.circular(40),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         height: 32,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               updatedFood.foodName,
//                               textAlign: TextAlign.left,
//                               maxLines: 1,
//                               style: const TextStyle(
//                                 fontSize: 22.0,
//                                 fontWeight: FontWeight.w800,
//                                 height: 1.2,
//                                 color: Color.fromRGBO(49, 49, 49, 1),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 12,
//                           ),
//                           Text(
//                             NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
//                                 .format(updatedFood.price),
//                             textAlign: TextAlign.center,
//                             maxLines: 1,
//                             style: const TextStyle(
//                               fontSize: 22.0,
//                               fontWeight: FontWeight.w800,
//                               height: 1.2,
//                               color: Color.fromRGBO(49, 49, 49, 1),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 12,
//                       ),
//                       Expanded(
//                         child: Text(
//                           updatedFood.foodDescribe,
//                           textAlign: TextAlign.left,
//                           maxLines: 10,
//                           style: const TextStyle(
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.w400,
//                             height: 1.2,
//                             color: Color.fromRGBO(49, 49, 49, 1),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ),
//                       const Expanded(child: SizedBox()),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // App bar
//               Positioned(
//                 top: 20,
//                 left: 20,
//                 right: 20,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: Container(
//                         height: 30,
//                         width: 30,
//                         decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.6),
//                             borderRadius: BorderRadius.circular(50)),
//                         child: const Icon(
//                           CupertinoIcons.arrow_left,
//                           color: Colors.black,
//                           size: 22,
//                         ),
//                       ),
//                     ),
//                     PopupMenuButton<String>(
//                       icon: Container(
//                         height: 30,
//                         width: 30,
//                         decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.6),
//                             borderRadius: BorderRadius.circular(50)),
//                         child: const Icon(
//                           CupertinoIcons.ellipsis_vertical,
//                           color: Colors.black,
//                           size: 22,
//                         ),
//                       ),
//                       color: Colors.white,
//                       onSelected: (value) async {
//                         if (value == 'Update') {
//                           Food? temp = await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       ModifyFoodScreen(food: food)));
//                           if (temp != null) {
//                             Provider.of<FoodListProvider>(context,
//                                     listen: false)
//                                 .updateFood(updatedFood.foodId, temp);
//                           }
//                         } else if (value == 'Delete') {
//                           bool rs = await FoodRepository()
//                               .deleteFood(updatedFood.foodId);
//                           if (rs) {
//                             showSnackBar(context, 'Delete food successful');
//                             Provider.of<FoodListProvider>(context,
//                                     listen: false)
//                                 .deleteFood(updatedFood.foodId);
//                             Navigator.pop(context);
//                           }
//                         }
//                       },
//                       itemBuilder: (BuildContext context) {
//                         return {'Update', 'Delete'}.map((String choice) {
//                           return PopupMenuItem<String>(
//                             value: choice,
//                             child: Text(
//                               choice,
//                               style: TextStyle(
//                                   color: choice == 'Delete'
//                                       ? Colors.red
//                                       : Colors.black),
//                             ),
//                           );
//                         }).toList();
//                       },
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
