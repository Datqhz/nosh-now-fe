import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:management_app/core/services/image_storage_service.dart';
import 'package:management_app/core/utils/image.dart';
import 'package:management_app/data/providers/category_list_provider.dart';
import 'package:management_app/data/repositories/category_repository.dart';
import 'package:management_app/data/requests/update_category_request.dart';
import 'package:management_app/data/responses/get_categories_response.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategoryManagementItem extends StatelessWidget {
  CategoryManagementItem({super.key, required this.category});

  GetCategoriesData category;
  ValueNotifier<XFile?> image = ValueNotifier(null);
  final TextEditingController _controller = TextEditingController();
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
                      image: NetworkImage(category.categoryImage),
                      fit: BoxFit.cover),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  category.categoryName,
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
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _controller.text = category.categoryName;
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Update category",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Form(
                                key: _formKey,
                                child: TextFormField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                      hintText: 'Category name',
                                      hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              width: 1)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.black.withOpacity(0.8),
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
                                      return 'Category name is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () async {
                                    XFile? img = await pickAnImageFromGallery();
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
                                                  BorderRadius.circular(6)),
                                          child: Image(
                                            image: value != null
                                                ? FileImage(File(value.path))
                                                    as ImageProvider<Object>
                                                : NetworkImage(category.categoryImage),
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      }),
                                ),
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
                                        String? newImg = category.categoryImage;
                                        final name = _controller.text.trim();
                                          if (image.value != null) {
                                            newImg = await ImageStorageService
                                                .uploadCategoryImage(
                                                    image.value);
                                          }

                                        var request = UpdateCategoryRequest
                                        (categoryId: category.categoryId, 
                                        categoryName: name, 
                                        image: newImg!);

                                        final rs = await CategoryRepository()
                                            .updateCategory(request,  context);
                                        if (rs) {
                                          var temp = category;
                                          temp.categoryImage = newImg;
                                          temp.categoryName = name;
                                          Provider.of<CategoryListProvider>(
                                                  context,
                                                  listen: false)
                                              .updateCategory(
                                                  category.categoryId, temp);
                                          Navigator.pop(context);
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
                // showDeleteDialog(context, 'category', category.categoryName,
                //     () async {
                //   bool rs = await CategoryRepository()
                //       .deleteCategory(category.categoryId);
                //   if (rs) {
                //     Provider.of<CategoryListProvider>(context, listen: false)
                //         .deleteCategory(category.categoryId);
                //     showSnackBar(context, "Delete successful");
                //   } else {
                //     showSnackBar(context, "Can't delete this category");
                //   }
                //   Navigator.pop(context);
                // });
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
