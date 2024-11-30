// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class FoodManagementItem extends StatelessWidget {
//   FoodManagementItem({super.key, required this.food});

//   Food food;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       padding: const EdgeInsets.only(bottom: 8, top: 12),
//       decoration: const BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             color: Color.fromRGBO(159, 159, 159, 1),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Row(children: [
//         // food image
//         Expanded(
//           child: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           FoodDetailManagementScreen(food: food)));
//             },
//             child: Row(
//               children: [
//                 Container(
//                   height: 80,
//                   width: 80,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: MemoryImage(
//                             convertBase64ToUint8List(food.foodImage)),
//                         fit: BoxFit.cover),
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 12,
//                 ),
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // food name
//                       Text(
//                         food.foodName,
//                         textAlign: TextAlign.center,
//                         maxLines: 1,
//                         style: const TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w600,
//                           height: 1.2,
//                           color: Color.fromRGBO(49, 49, 49, 1),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 6,
//                       ),
//                       Text(
//                         NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
//                             .format(food.price),
//                         textAlign: TextAlign.center,
//                         maxLines: 1,
//                         style: const TextStyle(
//                           fontSize: 14.0,
//                           fontWeight: FontWeight.w300,
//                           height: 1.2,
//                           color: Color.fromRGBO(49, 49, 49, 1),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 8,
//                 )
//               ],
//             ),
//           ),
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             GestureDetector(
//               onTap: () async {
//                 Food? temp = await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ModifyFoodScreen(food: food)));
//                 if (temp != null) {
//                   // ignore: use_build_context_synchronously
//                   Provider.of<FoodListProvider>(context, listen: false)
//                       .updateFood(food.foodId, temp);
//                 }
//               },
//               child: const Icon(
//                 CupertinoIcons.pencil,
//                 color: Colors.black,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(
//               height: 6,
//             ),
//             GestureDetector(
//               onTap: () async {
//                 showDeleteDialog(
//                   context,
//                   'food',
//                   food.foodName,
//                   () async {
//                     bool rs = await FoodRepository().deleteFood(food.foodId);
//                     if (rs) {
//                       showSnackBar(context, 'Delete food successful');
//                       Provider.of<FoodListProvider>(context, listen: false)
//                           .deleteFood(food.foodId);
//                       Navigator.pop(context);
//                     }
//                   },
//                 );
//               },
//               child: const Icon(
//                 CupertinoIcons.trash,
//                 color: Colors.red,
//                 size: 24,
//               ),
//             ),
//           ],
//         )
//       ]),
//     );
//   }
// }
