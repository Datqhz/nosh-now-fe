import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:management_app/core/services/image_storage_service.dart';
import 'package:management_app/core/utils/image.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/models/food_data.dart';
import 'package:management_app/data/repositories/category_repository.dart';
import 'package:management_app/data/repositories/food_repository.dart';
import 'package:management_app/data/requests/create_food_request.dart';
import 'package:management_app/data/requests/update_food_request.dart';
import 'package:management_app/data/responses/get_categories_response.dart';
import 'package:management_app/data/responses/get_food_byid_response.dart';

class ModifyFoodScreen extends StatefulWidget {
  ModifyFoodScreen({
    super.key,
    this.food,
  });

  GetFoodByIdData? food;

  @override
  State<ModifyFoodScreen> createState() => _ModifyFoodScreenState();
}

class _ModifyFoodScreenState extends State<ModifyFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final ValueNotifier<XFile?> _foodImage = ValueNotifier(null);
  List<GetCategoriesData> _categories = [];
  final ValueNotifier<String?> _categorySelected = ValueNotifier(null);

  @override
  void initState() {
    _fetchDropdownData();
    initWidget();
    super.initState();
  }

  Future<void> _fetchDropdownData() async {
    _categories = await CategoryRepository().getCategories(context);
    for (var item in _categories) {
      if (item.categoryId == widget.food!.category.categoryId) {
        _categorySelected.value = item.categoryName;
        break;
      }
    }
    setState(() {});
  }

  Future<void> initWidget() async {
    if (widget.food != null) {
      _nameController.text = widget.food!.foodName;
      _priceController.text = widget.food!.foodPrice.toString();
      _desController.text = widget.food!.foodDescription;
      _categorySelected.value = widget.food!.category.categoryName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              children: [
                // food image
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 2.4,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: [
                                  ValueListenableBuilder(
                                      valueListenable: _foodImage,
                                      builder: (context, value, child) {
                                        if (widget.food != null) {
                                          return Image(
                                            image: value != null
                                                ? FileImage(File(value.path))
                                                    as ImageProvider<Object>
                                                : NetworkImage(
                                                    widget.food!.foodImage),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.4,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.cover,
                                          );
                                        }
                                        return Image(
                                          image: value != null
                                              ? FileImage(File(value.path))
                                                  as ImageProvider<Object>
                                              : const AssetImage(
                                                  'assets/images/black.jpg'),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.4,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        );
                                      }),
                                  GestureDetector(
                                    onTap: () async {
                                      XFile? img =
                                          await pickAnImageFromGallery();
                                      if (img != null) {
                                        _foodImage.value = img;
                                      }
                                    },
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.4,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Icon(
                                          CupertinoIcons.photo,
                                          color: Colors.white,
                                          size: 80,
                                        )),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Food name',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromRGBO(55, 55, 55, 0.5),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    // food name input
                                    TextFormField(
                                      controller: _nameController,
                                      decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  118, 118, 118, 1),
                                              width:
                                                  1), // Màu viền khi không được chọn
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(35, 35, 35, 1),
                                            width: 1,
                                          ),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(182, 0, 0, 1),
                                            width: 1,
                                          ),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(182, 0, 0, 1),
                                            width: 1,
                                          ),
                                        ),
                                        errorStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(182, 0, 0, 1)),
                                        border: InputBorder.none,
                                      ),
                                      style: const TextStyle(
                                          color: Color.fromRGBO(49, 49, 49, 1),
                                          fontSize: 14,
                                          decoration: TextDecoration.none),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter food name.";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text(
                                      'Price',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromRGBO(55, 55, 55, 0.5),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    // price input
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _priceController,
                                      decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  118, 118, 118, 1),
                                              width:
                                                  1), // Màu viền khi không được chọn
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(35, 35, 35, 1),
                                            width: 1,
                                          ),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(182, 0, 0, 1),
                                            width: 1,
                                          ),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(182, 0, 0, 1),
                                            width: 1,
                                          ),
                                        ),
                                        errorStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(182, 0, 0, 1)),
                                        border: InputBorder.none,
                                      ),
                                      style: const TextStyle(
                                          color: Color.fromRGBO(49, 49, 49, 1),
                                          fontSize: 14,
                                          decoration: TextDecoration.none),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter price";
                                        } else if (double.parse(value) <= 0) {
                                          return "Price need larger than 0";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    // describe
                                    const Text(
                                      'Description',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromRGBO(55, 55, 55, 0.5),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    TextFormField(
                                      controller: _desController,
                                      decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  118, 118, 118, 1),
                                              width:
                                                  1), // Màu viền khi không được chọn
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(35, 35, 35, 1),
                                            width: 1,
                                          ),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(182, 0, 0, 1),
                                            width: 1,
                                          ),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(182, 0, 0, 1),
                                            width: 1,
                                          ),
                                        ),
                                        errorStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(182, 0, 0, 1)),
                                        border: InputBorder.none,
                                      ),
                                      style: const TextStyle(
                                          color: Color.fromRGBO(49, 49, 49, 1),
                                          fontSize: 14,
                                          decoration: TextDecoration.none),
                                    ),
                                    const Text(
                                      'Category',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromRGBO(55, 55, 55, 0.5),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    DropdownButtonFormField<String>(
                                      dropdownColor: Colors.white,
                                      isExpanded: true,
                                      style: const TextStyle(
                                          color: Color.fromRGBO(49, 49, 49, 1),
                                          overflow: TextOverflow.ellipsis),
                                      icon: const Icon(
                                        CupertinoIcons.chevron_down,
                                        size: 14,
                                        color: Color.fromRGBO(118, 118, 118, 1),
                                      ),
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  118, 118, 118, 1),
                                              width:
                                                  1), // Màu viền khi không được chọn
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(182, 0, 0, 1),
                                            width: 1,
                                          ),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(182, 0, 0, 1),
                                            width: 1,
                                          ),
                                        ),
                                        errorStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(182, 0, 0, 1)),
                                      ),
                                      value: _categorySelected.value,
                                      items: _categories
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item.categoryName,
                                                child: Text(
                                                  item.categoryName,
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        _categorySelected.value = value!;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select an option';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      width: double.infinity,
                                      height: 44,
                                      child: TextButton(
                                        onPressed: () async {
                                          if (_foodImage.value == null &&
                                              widget.food == null) {
                                            showSnackBar(context,
                                                'Please choose your food image');
                                            return;
                                          }

                                          String? newImg = '';
                                          if (widget.food != null) {
                                            newImg = widget.food!.foodImage;
                                          }
                                          if (_foodImage.value != null) {
                                            newImg = await ImageStorageService
                                                .uploadFoodImage(
                                                    _foodImage.value);
                                          }

                                          if (_formKey.currentState!
                                              .validate()) {
                                            final name =
                                                _nameController.text.trim();
                                            final price =
                                                _priceController.text.trim();
                                            final des =
                                                _desController.text.trim();
                                            GetCategoriesData? category;
                                            _categories.forEach((e) {
                                              if (e.categoryName ==
                                                  _categorySelected.value) {
                                                category = e;
                                              }
                                            });

                                            var foodData;
                                            if (widget.food != null) {
                                              var request = UpdateFoodRequest(
                                                  foodId: widget.food!.foodId,
                                                  categoryId:
                                                      category!.categoryId,
                                                  foodDescription: des,
                                                  foodImage: newImg!,
                                                  foodName: name,
                                                  foodPrice:
                                                      double.parse(price),
                                                  ingredients: []);
                                              var result =
                                                  await FoodRepository()
                                                      .updateFood(
                                                          request, context);
                                              if (result) {
                                                foodData = FoodData(
                                                    foodId: widget.food!.foodId,
                                                    foodName: name,
                                                    foodImage: newImg,
                                                    price: double.parse(price));
                                              }
                                            } else {
                                              var request = CreateFoodRequest(
                                                  categoryId:
                                                      category!.categoryId,
                                                  foodDescription: des,
                                                  foodImage: newImg!,
                                                  foodName: name,
                                                  foodPrice:
                                                      double.parse(price),
                                                  ingredients: []);
                                              var result =
                                                  await FoodRepository()
                                                      .createFood(
                                                          request, context);
                                              if (result != null) {
                                                foodData = FoodData(
                                                    foodId: result,
                                                    foodName: name,
                                                    foodImage: newImg,
                                                    price: double.parse(price));
                                              }
                                            }
                                            if (foodData != null) {
                                              Navigator.pop(context, foodData);
                                            }
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            foregroundColor:
                                                const Color.fromRGBO(
                                                    240, 240, 240, 1),
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        child: const Text('Save'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // App bar
                Positioned(
                  top: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            CupertinoIcons.arrow_left,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
