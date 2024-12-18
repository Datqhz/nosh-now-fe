import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:management_app/core/services/image_storage_service.dart';
import 'package:management_app/core/utils/image.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/models/food_data.dart';
import 'package:management_app/data/models/ingredient_unit.dart';
import 'package:management_app/data/repositories/category_repository.dart';
import 'package:management_app/data/repositories/food_repository.dart';
import 'package:management_app/data/repositories/ingredient_repository.dart';
import 'package:management_app/data/requests/create_food_request.dart';
import 'package:management_app/data/requests/update_food_request.dart';
import 'package:management_app/data/responses/get_categories_response.dart';
import 'package:management_app/data/responses/get_food_byid_response.dart';
import 'package:management_app/data/responses/get_ingredients_response.dart';
import 'package:management_app/presentation/widget/add_required_ingredient_item.dart';
import 'package:management_app/presentation/widget/required_ingredient_item.dart';

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
  final ValueNotifier<List<GetIngredientsData>> ingredients = ValueNotifier([]);
  final ValueNotifier<List<FoodIngredientData>> ingredientsPicked =
      ValueNotifier([]);
  final ValueNotifier<List<int>> ingredientsDeleted = ValueNotifier([]);
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
    if (widget.food != null) {
      for (var item in _categories) {
        if (item.categoryId == widget.food!.category.categoryId) {
          _categorySelected.value = item.categoryName;
          break;
        }
      }
    }
    var temp = await IngredientRepository().getIngredients(context);
    if (widget.food != null) {
      var ingredientIds =
          widget.food!.foodIngredients.map((x) => x.ingredientId).toList();
      temp.removeWhere((x) => ingredientIds.contains(x.id));
    }

    ingredients.value = temp;
    setState(() {});
  }

  void addNewIngredient(FoodIngredientData ingredient) {
    var temp1 = ingredientsPicked.value;
    temp1.add(ingredient);
    ingredientsPicked.value = List.from(temp1);

    var temp2 = ingredients.value;
    temp2.removeWhere((x) => x.id == ingredient.ingredientId);
    ingredients.value = List.from(temp2);
  }

  void updateIngredient(FoodIngredientData data) {
    var temp2 = ingredientsPicked.value;
    temp2.removeWhere((x) => x.ingredientName == data.ingredientName);
    temp2.add(data);
    ingredientsPicked.value = List.from(temp2);
  }

  void removeIngredient(FoodIngredientData ingredient) {
    var data = GetIngredientsData(
        id: ingredient.ingredientId,
        name: ingredient.ingredientName,
        image: ingredient.ingredientImage,
        quantity: 0,
        unit:
            IngredientUnit.values.firstWhere((x) => x.name == ingredient.unit));
    var temp1 = ingredients.value;
    temp1.add(data);
    ingredients.value = temp1;

    var temp2 = ingredientsPicked.value;
    temp2.remove(ingredient);
    ingredientsPicked.value = List.from(temp2);

    if (ingredient.requiredIngredientId != 0) {
      var temp3 = ingredientsDeleted.value;
      temp3.add(ingredient.requiredIngredientId);
      ingredientsDeleted.value = List.from(temp3);
    }
  }

  Future<void> initWidget() async {
    if (widget.food != null) {
      var food = widget.food;
      _nameController.text = food!.foodName;
      _priceController.text = food.foodPrice.toString();
      _desController.text = food.foodDescription;
      _categorySelected.value = food.category.categoryName;
      ingredientsPicked.value = food.foodIngredients;
    }
  }

  List<ModifyRequiredIngredient> handleDataBeforeUpdate() {
    var requiredIngredients = <ModifyRequiredIngredient>[];

    for (var i in ingredientsPicked.value) {
      // handle if add new/update
      var newRequired = ModifyRequiredIngredient(
          ingredientId: i.ingredientId,
          quantity: i.requiredAmount,
          modifyOption: i.requiredIngredientId == 0 ? 0 : 1,
          requiredIngredientId:
              i.requiredIngredientId == 0 ? 0 : i.requiredIngredientId);
      requiredIngredients.add(newRequired);
    }

    // handle if delete
    for (var i in ingredientsDeleted.value) {
      var newRequired = ModifyRequiredIngredient(
          ingredientId: 0,
          quantity: 1,
          modifyOption: 2,
          requiredIngredientId: i);
      requiredIngredients.add(newRequired);
    }

    print(requiredIngredients.toString());

    return requiredIngredients;
  }

  List<RequiredIngredient> handleDataBeforeCreate() {
    var requiredIngredients = <RequiredIngredient>[];
    for (var i in ingredientsPicked.value) {
      // handle if add new
      if (i.requiredIngredientId == 0) {
        var newRequired = RequiredIngredient(
          ingredientId: i.ingredientId,
          quantity: i.requiredAmount,
        );
        requiredIngredients.add(newRequired);
        continue;
      }
    }
    return requiredIngredients;
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
                                    const SizedBox(
                                      height: 8,
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
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Ingredients',
                                          textAlign: TextAlign.left,
                                          maxLines: 10,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            height: 1.2,
                                            color:
                                                Color.fromRGBO(49, 49, 49, 1),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    elevation: 0,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Container(
                                                      height: 420,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20,
                                                          vertical: 12),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          const Text(
                                                            "Ingredients",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          SizedBox(
                                                            height: 260,
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                children: List
                                                                    .generate(
                                                                  ingredients
                                                                      .value
                                                                      .length,
                                                                  (index) =>
                                                                      AddRequiredIngredientItem(
                                                                    ingredient:
                                                                        ingredients
                                                                            .value[index],
                                                                    callback:
                                                                        addNewIngredient,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          const Expanded(
                                                              child: SizedBox(
                                                            height: 1,
                                                          )),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  foregroundColor: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.6),
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          16,
                                                                      vertical:
                                                                          10),
                                                                  textStyle: const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Color.fromRGBO(
                                                                          153,
                                                                          162,
                                                                          232,
                                                                          1)),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  "CANCEL",
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 40,
                                                              ),
                                                              TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  if (_formKey
                                                                      .currentState!
                                                                      .validate()) {}
                                                                },
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  foregroundColor:
                                                                      Colors
                                                                          .black,
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          16,
                                                                      vertical:
                                                                          10),
                                                                  textStyle: const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Color.fromRGBO(
                                                                          153,
                                                                          162,
                                                                          232,
                                                                          1)),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  "SAVE",
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: const Icon(
                                            CupertinoIcons.add,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    ValueListenableBuilder(
                                        valueListenable: ingredientsPicked,
                                        builder: (context, ingredient, child) {
                                          return Column(
                                            children: List.generate(
                                                ingredient.length,
                                                (index) =>
                                                    RequiredIngredientItem(
                                                      ingredient:
                                                          ingredient[index],
                                                      enableEdit: true,
                                                      deleteEvent:
                                                          removeIngredient,
                                                      updateEvent:
                                                          updateIngredient,
                                                    )),
                                          );
                                        }),
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
                                              var requiredIngredients =
                                                  handleDataBeforeUpdate();
                                              var request = UpdateFoodRequest(
                                                  foodId: widget.food!.foodId,
                                                  categoryId:
                                                      category!.categoryId,
                                                  foodDescription: des,
                                                  foodImage: newImg!,
                                                  foodName: name,
                                                  foodPrice:
                                                      double.parse(price),
                                                  ingredients:
                                                      requiredIngredients);
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
                                              var requiredIngredients =
                                                  handleDataBeforeCreate();
                                              var request = CreateFoodRequest(
                                                  categoryId:
                                                      category!.categoryId,
                                                  foodDescription: des,
                                                  foodImage: newImg!,
                                                  foodName: name,
                                                  foodPrice:
                                                      double.parse(price),
                                                  ingredients:
                                                      requiredIngredients);
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
