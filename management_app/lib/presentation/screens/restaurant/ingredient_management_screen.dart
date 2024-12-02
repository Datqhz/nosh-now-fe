import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:management_app/core/services/image_storage_service.dart';
import 'package:management_app/core/utils/image.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/models/ingredient_unit.dart';
import 'package:management_app/data/providers/ingredient_list_provider.dart';
import 'package:management_app/data/repositories/ingredient_repository.dart';
import 'package:management_app/data/requests/create_ingredient_request.dart';
import 'package:management_app/data/responses/get_ingredients_response.dart';
import 'package:management_app/presentation/widget/ingredient_management_item.dart';
import 'package:provider/provider.dart';

class IngredientManagementScreen extends StatefulWidget {
  const IngredientManagementScreen({super.key});

  @override
  State<IngredientManagementScreen> createState() =>
      _IngredientManagementScreenState();
}

class _IngredientManagementScreenState
    extends State<IngredientManagementScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<XFile?> image = ValueNotifier(null);
  final List<IngredientUnit> _units = IngredientUnit.values;
  final ValueNotifier<String> _unitSelected =
      ValueNotifier(IngredientUnit.g.name);

  @override
  void initState() {
    super.initState();
    Provider.of<IngredientListProvider>(context, listen: false)
        .fetchIngredients(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Text(
                      'Ingredients',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        color: Color.fromRGBO(49, 49, 49, 1),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Consumer<IngredientListProvider>(
                        builder: (context, provider, child) {
                      if (provider.isLoading == true) {
                        return const Center(
                          child: SpinKitCircle(
                            color: Colors.black,
                            size: 50,
                          ),
                        );
                      }
                      return Column(
                        children:
                            List.generate(provider.ingredients.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: IngredientManagementItem(
                              ingredient: provider.ingredients[index],
                            ),
                          );
                        }),
                      );
                    }),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Row(
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
                          // add category
                          GestureDetector(
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      elevation: 0,
                                      backgroundColor: Colors.white,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 12),
                                        height: 380,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              "Create ingredient",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        XFile? img =
                                                            await pickAnImageFromGallery();
                                                        image.value = img;
                                                      },
                                                      child:
                                                          ValueListenableBuilder(
                                                              valueListenable:
                                                                  image,
                                                              builder: (context,
                                                                  value,
                                                                  child) {
                                                                return Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .black,
                                                                          width:
                                                                              1),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6)),
                                                                  child: Image(
                                                                    image: value !=
                                                                            null
                                                                        ? FileImage(
                                                                            File(
                                                                                value.path)) as ImageProvider<
                                                                            Object>
                                                                        : const AssetImage(
                                                                            'assets/images/add_image_icon.png'),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                );
                                                              }),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextFormField(
                                                    controller: _controller,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            'Ingredient name',
                                                        hintStyle: TextStyle(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.8),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8),
                                                                    width: 1)),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(0.8),
                                                                    width: 2))),
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      decoration:
                                                          TextDecoration.none,
                                                      decorationThickness: 0,
                                                    ),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Ingredient name is required';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Flexible(
                                                          flex: 4,
                                                          child: TextFormField(
                                                            controller:
                                                                _quantityController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration: InputDecoration(
                                                                hintText:
                                                                    'Quantity',
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8),
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                                enabledBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors.black.withOpacity(
                                                                            0.8),
                                                                        width:
                                                                            1)),
                                                                focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.8),
                                                                        width: 2))),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              decorationThickness:
                                                                  0,
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          flex: 1,
                                                          child:
                                                              DropdownButtonFormField<
                                                                  String>(
                                                            dropdownColor:
                                                                Colors.white,
                                                            isExpanded: false,
                                                            style: const TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        49,
                                                                        49,
                                                                        49,
                                                                        1),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                            icon: const Icon(
                                                              CupertinoIcons
                                                                  .chevron_down,
                                                              size: 14,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      118,
                                                                      118,
                                                                      118,
                                                                      1),
                                                            ),
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            118,
                                                                            118,
                                                                            118,
                                                                            1),
                                                                    width:
                                                                        1), // Màu viền khi không được chọn
                                                              ),
                                                              errorBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          182,
                                                                          0,
                                                                          0,
                                                                          1),
                                                                  width: 1,
                                                                ),
                                                              ),
                                                              focusedErrorBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          182,
                                                                          0,
                                                                          0,
                                                                          1),
                                                                  width: 1,
                                                                ),
                                                              ),
                                                              errorStyle: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          182,
                                                                          0,
                                                                          0,
                                                                          1)),
                                                            ),
                                                            value: _unitSelected
                                                                .value,
                                                            items: _units
                                                                .map((item) =>
                                                                    DropdownMenuItem<
                                                                        String>(
                                                                      value: item
                                                                          .name,
                                                                      child:
                                                                          Text(
                                                                        item.name,
                                                                      ),
                                                                    ))
                                                                .toList(),
                                                            onChanged: (value) {
                                                              _unitSelected
                                                                      .value =
                                                                  value!;
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
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
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: Colors
                                                        .black
                                                        .withOpacity(0.6),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16,
                                                        vertical: 10),
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            153, 162, 232, 1)),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: const Text(
                                                    "CANCEL",
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 40,
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      final name = _controller
                                                          .text
                                                          .trim();
                                                      final quantity =
                                                          double.parse(
                                                              _quantityController
                                                                  .text
                                                                  .trim());
                                                      String? imageUrl = '';

                                                      if (image.value != null) {
                                                        imageUrl =
                                                            await ImageStorageService
                                                                .uploadIngredientImage(
                                                                    image
                                                                        .value);
                                                      } else {
                                                        showSnackBar(context,
                                                            'Please choose image');
                                                        return;
                                                      }
                                                      var newUnit;
                                                      for (var unit in _units) {
                                                        if (unit.name ==
                                                            _unitSelected
                                                                .value) {
                                                          newUnit = unit;
                                                          break;
                                                        }
                                                      }
                                                      var request =
                                                          CreateIngredientRequest(
                                                              ingredientName:
                                                                  name,
                                                              image: imageUrl!,
                                                              quantity:
                                                                  quantity,
                                                              unit: newUnit);

                                                      final rs =
                                                          await IngredientRepository()
                                                              .createIngredient(
                                                                  request,
                                                                  context);
                                                      if (rs != null) {
                                                        var newIngredient =
                                                            GetIngredientsData(
                                                                id: rs,
                                                                name: name,
                                                                image: imageUrl,
                                                                quantity:
                                                                    quantity,
                                                                unit: newUnit);
                                                        Provider.of<IngredientListProvider>(
                                                                context,
                                                                listen: false)
                                                            .addIngredient(
                                                                newIngredient);
                                                        Navigator.pop(context);
                                                        _controller.text = '';
                                                        _quantityController
                                                            .text = '';
                                                        image.value = null;
                                                      } else {
                                                        showSnackBar(context,
                                                            "Can't save your data");
                                                      }
                                                    }
                                                  },
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.black,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16,
                                                        vertical: 10),
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            153, 162, 232, 1)),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: const Text(
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
                              size: 24,
                              color: Color.fromRGBO(49, 49, 49, 1),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
