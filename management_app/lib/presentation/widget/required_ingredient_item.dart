import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:management_app/data/responses/get_food_byid_response.dart';

class RequiredIngredientItem extends StatelessWidget {
  RequiredIngredientItem(
      {super.key,
      required this.ingredient,
      this.enableEdit = false,
      this.deleteEvent,
      this.updateEvent});

  FoodIngredientData ingredient;
  bool enableEdit;
  Function? updateEvent;
  Function? deleteEvent;
  final TextEditingController _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(ingredient.ingredientImage),
                    fit: BoxFit.cover),
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // food name
                  Text(
                    ingredient.ingredientName,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: Color.fromRGBO(49, 49, 49, 1),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "${ingredient.requiredAmount.toStringAsFixed(2)} ${ingredient.unit}",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                      height: 1.2,
                      color: Color.fromRGBO(49, 49, 49, 1),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            if (enableEdit) ...[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              elevation: 0,
                              backgroundColor: Colors.white,
                              child: Container(
                                height: 210,
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
                                      "Amount",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _controller,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                hintText: 'Amount',
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
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Amount is required';
                                              }
                                              return null;
                                            },
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
                                                color: Color.fromRGBO(
                                                    153, 162, 232, 1)),
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
                                            if (_formKey.currentState!
                                                .validate()) {
                                              var amount = double.parse(
                                                  _controller.text.trim());
                                              ingredient.requiredAmount =
                                                  amount;
                                              updateEvent!(ingredient);
                                              Navigator.pop(context);
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 10),
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(
                                                    153, 162, 232, 1)),
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
                      deleteEvent!(ingredient);
                      // remove of the list
                    },
                    child: const Icon(
                      CupertinoIcons.xmark,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                ],
              )
            ]
          ],
        ));
  }
}