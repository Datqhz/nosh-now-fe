import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/streams/change_stream.dart';
import 'package:management_app/core/utils/image.dart';
import 'package:management_app/core/utils/validate.dart';
import 'package:management_app/data/repositories/restaurant_repository.dart';
import 'package:management_app/data/requests/update_profile_request.dart';

class ModifyProfileScreen extends StatefulWidget {
  ModifyProfileScreen({super.key, required this.stream});

  ChangeStream stream;

  @override
  State<ModifyProfileScreen> createState() => _ModifyProfileScreenState();
}

class _ModifyProfileScreenState extends State<ModifyProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  ValueNotifier<XFile?> avatar = ValueNotifier(null);
  ValueNotifier<String> coordinator = ValueNotifier('');

  Future<void> setInitValue() async {
    _displayNameController.text = GlobalVariable.profile!.displayName;
    _phoneController.text = GlobalVariable.profile!.phone;
  }

  @override
  void initState() {
    setInitValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 70,
                            ),
                            //avatar
                            GestureDetector(
                              onTap: () async {
                                XFile? img = await pickAnImageFromGallery();
                                avatar.value = img;
                              },
                              child: SizedBox(
                                height: 100,
                                child: Stack(
                                  children: [
                                    ValueListenableBuilder(
                                        valueListenable: avatar,
                                        builder: (context, value, child) {
                                          return CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 50,
                                            foregroundImage: value != null
                                                ? FileImage(File(value.path))
                                                    as ImageProvider<Object>
                                                : NetworkImage(GlobalVariable.profile!.avatar)
                                          );
                                        }),
                                    Positioned(
                                      bottom: 0,
                                      right: 16,
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                        child: const Icon(
                                          CupertinoIcons.pencil,
                                          size: 16,
                                          color:
                                              Color.fromRGBO(240, 240, 240, 1),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Display name',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromRGBO(55, 55, 55, 0.5),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    // display name input
                                    TextFormField(
                                      controller: _displayNameController,
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
                                          return "Please enter your display name.";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text(
                                      'Phone',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromRGBO(55, 55, 55, 0.5),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    // phone input
                                    TextFormField(
                                      controller: _phoneController,
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
                                          return "Please enter your phone.";
                                        } else if (containsWhitespace(value)) {
                                          return "Phone must not contain any whitespace.";
                                        } else if (!validatePhone(value)) {
                                          return "Phone invalid.";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            CupertinoIcons.arrow_left,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text(
                          'Edit profile',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(49, 49, 49, 1),
                              overflow: TextOverflow.ellipsis),
                        ),
                        const Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              // Preprocess data
                              final name = _displayNameController.text.trim();
                              final phone = _phoneController.text.trim();
                              final request = UpdateProfileRequest(
                                displayname: name,
                                phoneNumber: phone, 
                                avatar: GlobalVariable.profile!.avatar
                              );

                              /* TODO: Handle upload image to cloudinary */
                              // if (avatar.value != null) {
                              //   base64 = await convertToBase64(avatar.value!);
                              // }

                              final result = await RestaurantRepository().updateProfile(request, context);
                              if(result){
                                GlobalVariable.profile!.displayName = name;
                                GlobalVariable.profile!.phone = name;
                                widget.stream.notifyChange();
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: const Text(
                            'Save',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(49, 49, 49, 1),
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
