// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ModifyFoodScreen extends StatefulWidget {
//   ModifyFoodScreen({
//     super.key,
//     this.food,
//   });

//   Food? food;

//   @override
//   State<ModifyFoodScreen> createState() => _ModifyFoodScreenState();
// }

// class _ModifyFoodScreenState extends State<ModifyFoodScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _desController = TextEditingController();
//   final ValueNotifier<XFile?> _avatar = ValueNotifier(null);

//   @override
//   void initState() {
//     super.initState();
//     if (widget.food != null) {
//       _nameController.text = widget.food!.foodName;
//       _priceController.text = widget.food!.price.toString();
//       _desController.text = widget.food!.foodDescribe;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//             return Stack(
//               children: [
//                 // food image
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height,
//                   width: MediaQuery.of(context).size.width,
//                   child: SingleChildScrollView(
//                     child: ConstrainedBox(
//                       constraints:
//                           BoxConstraints(minHeight: constraints.maxHeight),
//                       child: IntrinsicHeight(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height / 2.4,
//                               width: MediaQuery.of(context).size.width,
//                               child: Stack(
//                                 children: [
//                                   ValueListenableBuilder(
//                                       valueListenable: _avatar,
//                                       builder: (context, value, child) {
//                                         if (widget.food != null) {
//                                           return Image(
//                                             image: value != null
//                                                 ? FileImage(File(value.path))
//                                                     as ImageProvider<Object>
//                                                 : MemoryImage(
//                                                     convertBase64ToUint8List(
//                                                         widget
//                                                             .food!.foodImage)),
//                                             height: MediaQuery.of(context)
//                                                     .size
//                                                     .height /
//                                                 2.4,
//                                             width: MediaQuery.of(context)
//                                                 .size
//                                                 .width,
//                                             fit: BoxFit.cover,
//                                           );
//                                         }
//                                         return Image(
//                                           image: value != null
//                                               ? FileImage(File(value.path))
//                                                   as ImageProvider<Object>
//                                               : const AssetImage(
//                                                   'assets/images/black.jpg'),
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height /
//                                               2.4,
//                                           width:
//                                               MediaQuery.of(context).size.width,
//                                           fit: BoxFit.cover,
//                                         );
//                                       }),
//                                   GestureDetector(
//                                     onTap: () async {
//                                       XFile? img =
//                                           await pickAnImageFromGallery();
//                                       if (img != null) {
//                                         _avatar.value = img;
//                                       }
//                                     },
//                                     child: Container(
//                                         height:
//                                             MediaQuery.of(context).size.height /
//                                                 2.4,
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         color: Colors.black.withOpacity(0.3),
//                                         child: const Icon(
//                                           CupertinoIcons.photo,
//                                           color: Colors.white,
//                                           size: 80,
//                                         )),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 12,
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 20),
//                               child: Form(
//                                 key: _formKey,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Food name',
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           color:
//                                               Color.fromRGBO(55, 55, 55, 0.5),
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                     // food name input
//                                     TextFormField(
//                                       controller: _nameController,
//                                       decoration: const InputDecoration(
//                                         enabledBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: Color.fromRGBO(
//                                                   118, 118, 118, 1),
//                                               width:
//                                                   1), // Màu viền khi không được chọn
//                                         ),
//                                         focusedBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color:
//                                                 Color.fromRGBO(35, 35, 35, 1),
//                                             width: 1,
//                                           ),
//                                         ),
//                                         errorBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: Color.fromRGBO(182, 0, 0, 1),
//                                             width: 1,
//                                           ),
//                                         ),
//                                         focusedErrorBorder:
//                                             UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: Color.fromRGBO(182, 0, 0, 1),
//                                             width: 1,
//                                           ),
//                                         ),
//                                         errorStyle: TextStyle(
//                                             color:
//                                                 Color.fromRGBO(182, 0, 0, 1)),
//                                         border: InputBorder.none,
//                                       ),
//                                       style: const TextStyle(
//                                           color: Color.fromRGBO(49, 49, 49, 1),
//                                           fontSize: 14,
//                                           decoration: TextDecoration.none),
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return "Please enter food name.";
//                                         }
//                                         return null;
//                                       },
//                                     ),
//                                     const SizedBox(
//                                       height: 12,
//                                     ),
//                                     const Text(
//                                       'Price',
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           color:
//                                               Color.fromRGBO(55, 55, 55, 0.5),
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                     // price input
//                                     TextFormField(
//                                       keyboardType: TextInputType.number,
//                                       controller: _priceController,
//                                       decoration: const InputDecoration(
//                                         enabledBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: Color.fromRGBO(
//                                                   118, 118, 118, 1),
//                                               width:
//                                                   1), // Màu viền khi không được chọn
//                                         ),
//                                         focusedBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color:
//                                                 Color.fromRGBO(35, 35, 35, 1),
//                                             width: 1,
//                                           ),
//                                         ),
//                                         errorBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: Color.fromRGBO(182, 0, 0, 1),
//                                             width: 1,
//                                           ),
//                                         ),
//                                         focusedErrorBorder:
//                                             UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: Color.fromRGBO(182, 0, 0, 1),
//                                             width: 1,
//                                           ),
//                                         ),
//                                         errorStyle: TextStyle(
//                                             color:
//                                                 Color.fromRGBO(182, 0, 0, 1)),
//                                         border: InputBorder.none,
//                                       ),
//                                       style: const TextStyle(
//                                           color: Color.fromRGBO(49, 49, 49, 1),
//                                           fontSize: 14,
//                                           decoration: TextDecoration.none),
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return "Please enter price";
//                                         } else if (double.parse(value) <= 0) {
//                                           return "Price need larger than 0";
//                                         }
//                                         return null;
//                                       },
//                                     ),
//                                     const SizedBox(
//                                       height: 12,
//                                     ),
//                                     // describe
//                                     const Text(
//                                       'Describe',
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           color:
//                                               Color.fromRGBO(55, 55, 55, 0.5),
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                     TextFormField(
//                                       controller: _desController,
//                                       decoration: const InputDecoration(
//                                         enabledBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: Color.fromRGBO(
//                                                   118, 118, 118, 1),
//                                               width:
//                                                   1), // Màu viền khi không được chọn
//                                         ),
//                                         focusedBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color:
//                                                 Color.fromRGBO(35, 35, 35, 1),
//                                             width: 1,
//                                           ),
//                                         ),
//                                         errorBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: Color.fromRGBO(182, 0, 0, 1),
//                                             width: 1,
//                                           ),
//                                         ),
//                                         focusedErrorBorder:
//                                             UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: Color.fromRGBO(182, 0, 0, 1),
//                                             width: 1,
//                                           ),
//                                         ),
//                                         errorStyle: TextStyle(
//                                             color:
//                                                 Color.fromRGBO(182, 0, 0, 1)),
//                                         border: InputBorder.none,
//                                       ),
//                                       style: const TextStyle(
//                                           color: Color.fromRGBO(49, 49, 49, 1),
//                                           fontSize: 14,
//                                           decoration: TextDecoration.none),
//                                     ),
//                                     const SizedBox(
//                                       height: 40,
//                                     ),
//                                     //button sign up
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 30),
//                                       width: double.infinity,
//                                       height: 44,
//                                       child: TextButton(
//                                         onPressed: () async {
//                                           if (_avatar.value == null &&
//                                               widget.food == null) {
//                                             showSnackBar(context,
//                                                 'Please choose your food image');
//                                             return;
//                                           }
//                                           if (_formKey.currentState!
//                                               .validate()) {
//                                             final name =
//                                                 _nameController.text.trim();
//                                             final price =
//                                                 _priceController.text.trim();
//                                             final des =
//                                                 _desController.text.trim();
//                                             Food? rs;
//                                             Food? tempFood;
//                                             if (widget.food != null) {
//                                               tempFood = widget.food!;
//                                               tempFood.foodName = name;
//                                               tempFood.price =
//                                                   double.parse(price);
//                                               tempFood.foodDescribe = des;
//                                               if (_avatar.value != null) {
//                                                 tempFood.foodImage =
//                                                     await convertToBase64(
//                                                         _avatar.value!);
//                                               }
//                                               rs = await FoodRepository()
//                                                   .update(
//                                                       tempFood,
//                                                       GlobalVariable
//                                                           .currentUid);
//                                             } else {
//                                               print("add");
//                                               var tempBase64 =
//                                                   await convertToBase64(
//                                                       _avatar.value!);
//                                               tempFood = Food(
//                                                   foodId: 0,
//                                                   foodName: name,
//                                                   foodImage: tempBase64,
//                                                   foodDescribe: des,
//                                                   price: double.parse(price),
//                                                   status: 1);
//                                               rs = await FoodRepository()
//                                                   .create(
//                                                       tempFood,
//                                                       GlobalVariable
//                                                           .currentUid);
//                                             }
//                                             if (rs != null) {
//                                               showSnackBar(
//                                                   context, 'Save successful');
//                                               Navigator.pop(context, rs);
//                                             } else {
//                                               showSnackBar(context,
//                                                   'Something wrong when try to save food');
//                                             }
//                                           }
//                                         },
//                                         style: TextButton.styleFrom(
//                                             backgroundColor: Colors.black,
//                                             foregroundColor:
//                                                 const Color.fromRGBO(
//                                                     240, 240, 240, 1),
//                                             textStyle: const TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600),
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(8))),
//                                         child: const Text('Save'),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 12,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 // App bar
//                 Positioned(
//                   top: 20,
//                   left: 20,
//                   right: 20,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap: () => Navigator.pop(context),
//                         child: Container(
//                           height: 30,
//                           width: 30,
//                           decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.6),
//                               borderRadius: BorderRadius.circular(50)),
//                           child: const Icon(
//                             CupertinoIcons.arrow_left,
//                             color: Colors.black,
//                             size: 22,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
