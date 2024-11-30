import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:management_app/core/utils/validate.dart';
import 'package:management_app/data/repositories/account_repository.dart';
import 'package:management_app/data/requests/change_password_request.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _retypeController = TextEditingController();
  final ValueNotifier<bool> _oldPassObscure = ValueNotifier(true);
  final ValueNotifier<bool> _newPassObscure = ValueNotifier(true);
  final ValueNotifier<bool> _retypePassObscure = ValueNotifier(true);

  @override
  void initState() {
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
                              height: 80,
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
                                      'Old password',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromRGBO(55, 55, 55, 0.5),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    // password input
                                    ValueListenableBuilder(
                                        valueListenable: _oldPassObscure,
                                        builder: (context, value, child) {
                                          return TextFormField(
                                            controller: _oldPassController,
                                            obscureText: value,
                                            decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  _oldPassObscure.value =
                                                      !_oldPassObscure.value;
                                                },
                                                icon: value
                                                    ? const Icon(CupertinoIcons
                                                        .eye_slash)
                                                    : const Icon(
                                                        CupertinoIcons.eye),
                                              ),
                                              suffixStyle: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      49, 49, 49, 1)),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        118, 118, 118, 1),
                                                    width:
                                                        1), // Màu viền khi không được chọn
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      35, 35, 35, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              errorBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      182, 0, 0, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      182, 0, 0, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              errorStyle: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      182, 0, 0, 1)),
                                              border: InputBorder.none,
                                            ),
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    49, 49, 49, 1),
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.none),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter your current password.";
                                              } else if (containsWhitespace(
                                                  value)) {
                                                return "Password must not contain any whitespace.";
                                              } else if (value.length < 6) {
                                                return "Password must be at least 6 characters.";
                                              }
                                              return null;
                                            },
                                          );
                                        }),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text(
                                      'New password',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromRGBO(55, 55, 55, 0.5),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    // password input
                                    ValueListenableBuilder(
                                        valueListenable: _newPassObscure,
                                        builder: (context, value, child) {
                                          return TextFormField(
                                            controller: _newPassController,
                                            obscureText: value,
                                            decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  _newPassObscure.value =
                                                      !_newPassObscure.value;
                                                },
                                                icon: value
                                                    ? const Icon(CupertinoIcons
                                                        .eye_slash)
                                                    : const Icon(
                                                        CupertinoIcons.eye),
                                              ),
                                              suffixStyle: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      49, 49, 49, 1)),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        118, 118, 118, 1),
                                                    width:
                                                        1), // Màu viền khi không được chọn
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      35, 35, 35, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              errorBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      182, 0, 0, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      182, 0, 0, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              errorStyle: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      182, 0, 0, 1)),
                                              border: InputBorder.none,
                                            ),
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    49, 49, 49, 1),
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.none),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter your new password.";
                                              } else if (containsWhitespace(
                                                  value)) {
                                                return "Password must not contain any whitespace.";
                                              } else if (value.length < 6) {
                                                return "Password must be at least 6 characters.";
                                              }
                                              return null;
                                            },
                                          );
                                        }),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text(
                                      'Re-type new password',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromRGBO(55, 55, 55, 0.5),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    // password input
                                    ValueListenableBuilder(
                                        valueListenable: _retypePassObscure,
                                        builder: (context, value, child) {
                                          return TextFormField(
                                            controller: _retypeController,
                                            obscureText: value,
                                            decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  _retypePassObscure.value =
                                                      !_retypePassObscure.value;
                                                },
                                                icon: value
                                                    ? const Icon(CupertinoIcons
                                                        .eye_slash)
                                                    : const Icon(
                                                        CupertinoIcons.eye),
                                              ),
                                              suffixStyle: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      49, 49, 49, 1)),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        118, 118, 118, 1),
                                                    width:
                                                        1), // Màu viền khi không được chọn
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      35, 35, 35, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              errorBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      182, 0, 0, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      182, 0, 0, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              errorStyle: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      182, 0, 0, 1)),
                                              border: InputBorder.none,
                                            ),
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    49, 49, 49, 1),
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.none),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please re-enter your new password.";
                                              } else if (containsWhitespace(
                                                  value)) {
                                                return "Password must not contain any whitespace.";
                                              } else if (value.length < 6) {
                                                return "Password must be at least 6 characters.";
                                              } else if (value !=
                                                  _newPassController.text
                                                      .trim()) {
                                                return "Your re-type password is incorrect";
                                              }
                                              return null;
                                            },
                                          );
                                        }),
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
                          'Change password',
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
                              final oldPassword = _oldPassController.text.trim();
                              final newPassword = _oldPassController.text.trim();
                              var request = ChangePasswordRequest(oldPassword: oldPassword, newPassword: newPassword);

                              // Call api
                              var result = await AccountRepository()
                                  .changePassword(request, context);
                              if (result) {
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
