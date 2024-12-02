import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:management_app/core/services/image_storage_service.dart';
import 'package:management_app/core/utils/dialog.dart';
import 'package:management_app/core/utils/image.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/models/ingredient_unit.dart';
import 'package:management_app/data/providers/ingredient_list_provider.dart';
import 'package:management_app/data/repositories/ingredient_repository.dart';
import 'package:management_app/data/requests/update_ingredient_request.dart';
import 'package:management_app/data/responses/get_ingredients_response.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class IngredientManagementItem extends StatelessWidget {
  IngredientManagementItem({super.key, required this.ingredient});

  GetIngredientsData ingredient;
  ValueNotifier<XFile?> image = ValueNotifier(null);
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _increaseController = TextEditingController();
  final List<IngredientUnit> _units = IngredientUnit.values;
  final ValueNotifier<String> _unitSelected =
      ValueNotifier(IngredientUnit.g.name);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(bottom: 8, top: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(159, 159, 159, 1),
            width: 1,
          ),
        ),
      ),
      child: Row(children: [
        // food image
        Expanded(
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(ingredient.image), fit: BoxFit.cover),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ingredient.name,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: Color.fromRGBO(49, 49, 49, 1),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Stock: ${ingredient.quantity}${ingredient.unit.name}",
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                      color: Color.fromRGBO(49, 49, 49, 1),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _controller.text = ingredient.name;
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        child: Container(
                          height: 380,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Update ingredient",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
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
                                        child: ValueListenableBuilder(
                                            valueListenable: image,
                                            builder: (context, value, child) {
                                              return Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: Image(
                                                  image: value != null
                                                      ? FileImage(
                                                              File(value.path))
                                                          as ImageProvider<
                                                              Object>
                                                      : NetworkImage(
                                                          ingredient.image),
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _controller,
                                      decoration: InputDecoration(
                                          hintText: 'Ingredient name',
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black
                                                      .withOpacity(0.8),
                                                  width: 1)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black
                                                      .withOpacity(0.8),
                                                  width: 2))),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        decoration: TextDecoration.none,
                                        decorationThickness: 0,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Ingredient name is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 4,
                                          child: TextFormField(
                                            controller: _increaseController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                hintText: 'Increase quantity',
                                                hintStyle: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.8),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight
                                                        .w400),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.8),
                                                            width: 1)),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.8),
                                                            width: 2))),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              decoration: TextDecoration.none,
                                              decorationThickness: 0,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child:
                                              DropdownButtonFormField<String>(
                                            dropdownColor: Colors.white,
                                            isExpanded: false,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    49, 49, 49, 1),
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            icon: const Icon(
                                              CupertinoIcons.chevron_down,
                                              size: 14,
                                              color: Color.fromRGBO(
                                                  118, 118, 118, 1),
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
                                                  color: Color.fromRGBO(
                                                      182, 0, 0, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      182, 0, 0, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              errorStyle: TextStyle(
                                                  color: Color.fromRGBO(
                                                      182, 0, 0, 1)),
                                            ),
                                            value: _unitSelected.value,
                                            items: _units
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item.name,
                                                      child: Text(
                                                        item.name,
                                                      ),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              _unitSelected.value = value!;
                                            },
                                          ),
                                        ),
                                      ],
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor:
                                          Colors.black.withOpacity(0.6),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromRGBO(153, 162, 232, 1)),
                                      backgroundColor: Colors.transparent,
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
                                      if (_formKey.currentState!.validate()) {
                                        final ingredientName =
                                            _controller.text.trim();
                                        String? newImg = ingredient.image;
                                        double newQuantity =
                                            ingredient.quantity;
                                        var increase =
                                            _increaseController.text.trim();
                                        if (increase.isNotEmpty) {
                                          newQuantity += double.parse(increase);
                                        }
                                        if (image.value != null) {
                                          newImg = await ImageStorageService
                                              .uploadIngredientImage(
                                                  image.value);
                                        }

                                        var newUnit;
                                        for (var unit in _units) {
                                          if (unit.name ==
                                              _unitSelected.value) {
                                            newUnit = unit;
                                            break;
                                          }
                                        }
                                        var request = UpdateIngredientRequest(
                                            ingredientId: ingredient.id,
                                            ingredientName: ingredientName,
                                            image: newImg!,
                                            quantity: newQuantity,
                                            unit: newUnit);
                                        final rs = await IngredientRepository()
                                            .updateIngredient(request, context);
                                        if (rs) {
                                          ingredient.name = ingredientName;
                                          ingredient.image = newImg;
                                          ingredient.quantity = newQuantity;
                                          ingredient.unit = newUnit;
                                          Provider.of<IngredientListProvider>(
                                                  context,
                                                  listen: false)
                                              .updateIngredient(
                                                  ingredient.id, ingredient);
                                          Navigator.pop(context);
                                        } else {
                                          showSnackBar(
                                              context, "Can't save your data");
                                        }
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromRGBO(153, 162, 232, 1)),
                                      backgroundColor: Colors.transparent,
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
                CupertinoIcons.pencil,
                color: Colors.black,
                size: 24,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            GestureDetector(
              onTap: () async {
                showDeleteDialog(context, 'ingredient', ingredient.name,
                    () async {
                  bool rs = await IngredientRepository()
                      .deleteIngredient(ingredient.id, context);
                  if (rs) {
                    Provider.of<IngredientListProvider>(context, listen: false)
                        .deleteIngredient(ingredient.id);
                  } else {
                    showSnackBar(context, "Can't delete this ingredient");
                  }
                  Navigator.pop(context);
                });
              },
              child: const Icon(
                CupertinoIcons.trash,
                color: Colors.red,
                size: 24,
              ),
            ),
          ],
        )
      ]),
    );
  }
}
