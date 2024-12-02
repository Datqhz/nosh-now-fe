import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/utils/validate.dart';
import 'package:management_app/data/models/restaurant_role.dart';
import 'package:management_app/data/repositories/account_repository.dart';
import 'package:management_app/data/requests/register_request.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});
  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ValueNotifier<XFile?> _avatar = ValueNotifier(null);
  final ValueNotifier<bool> _isObscure = ValueNotifier(true);
  final List<RestaurantRole> _restaurantRole = RestaurantRole.values;
  final ValueNotifier<String> _roleSelected =
      ValueNotifier(RestaurantRole.values[0].name);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _avatar.dispose();
    _isObscure.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Display name',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromRGBO(55, 55, 55, 0.5),
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
                                          color: Color.fromRGBO(35, 35, 35, 1),
                                          width: 1,
                                        ),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(182, 0, 0, 1),
                                          width: 1,
                                        ),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(182, 0, 0, 1),
                                          width: 1,
                                        ),
                                      ),
                                      errorStyle: TextStyle(
                                          color: Color.fromRGBO(182, 0, 0, 1)),
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
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromRGBO(55, 55, 55, 0.5),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  // Email input
                                  TextFormField(
                                    controller: _emailController,
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
                                          color: Color.fromRGBO(35, 35, 35, 1),
                                          width: 1,
                                        ),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(182, 0, 0, 1),
                                          width: 1,
                                        ),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(182, 0, 0, 1),
                                          width: 1,
                                        ),
                                      ),
                                      errorStyle: TextStyle(
                                          color: Color.fromRGBO(182, 0, 0, 1)),
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                        color: Color.fromRGBO(49, 49, 49, 1),
                                        fontSize: 14,
                                        decoration: TextDecoration.none),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter email.";
                                      } else if (!validateEmail(value)) {
                                        return "Email invalid";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Text(
                                    'Password',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromRGBO(55, 55, 55, 0.5),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  // password input
                                  ValueListenableBuilder(
                                      valueListenable: _isObscure,
                                      builder: (context, value, child) {
                                        return TextFormField(
                                          controller: _passwordController,
                                          obscureText: value,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                _isObscure.value =
                                                    !_isObscure.value;
                                              },
                                              icon: value
                                                  ? const Icon(
                                                      CupertinoIcons.eye_slash)
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
                                              color:
                                                  Color.fromRGBO(49, 49, 49, 1),
                                              fontSize: 14,
                                              decoration: TextDecoration.none),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter your password.";
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
                                    'Phone',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromRGBO(55, 55, 55, 0.5),
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
                                          color: Color.fromRGBO(35, 35, 35, 1),
                                          width: 1,
                                        ),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(182, 0, 0, 1),
                                          width: 1,
                                        ),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(182, 0, 0, 1),
                                          width: 1,
                                        ),
                                      ),
                                      errorStyle: TextStyle(
                                          color: Color.fromRGBO(182, 0, 0, 1)),
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
                                    height: 8,
                                  ),
                                  const Text(
                                    'Category',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromRGBO(55, 55, 55, 0.5),
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
                                      value: _roleSelected.value,
                                      items: _restaurantRole
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item.name,
                                                child: Text(
                                                  item.name,
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        _roleSelected.value = value!;
                                      }),

                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                ),
                // back button
                Positioned(
                  left: 0,
                  right: 0,
                  height: 60,
                  child: Container(
                    color: const Color.fromRGBO(240, 240, 240, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            CupertinoIcons.arrow_left,
                            color: Color.fromRGBO(49, 49, 49, 1),
                            size: 22,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text(
                          'Add employee',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(49, 49, 49, 1)),
                        ),
                        const Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final displayName =
                                  _displayNameController.text.trim();
                              final email = _emailController.text.trim();
                              final password = _passwordController.text.trim();
                              final phone = _phoneController.text.trim();

                              var request = RegisterRequest(
                                  displayname: displayName,
                                  userName: email,
                                  password: password,
                                  phoneNumber: phone,
                                  role: _roleSelected.value,
                                  avatar:
                                      "https://static.vecteezy.com/system/resources/previews/009/292/244/original/default-avatar-icon-of-social-media-user-vector.jpg",
                                  restaurantId: GlobalVariable.profile!.id);
                              var isCreated = await AccountRepository()
                                  .signUp(request, context);
                              if (isCreated) {
                                Navigator.pop(context, true);
                              }
                            }
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(49, 49, 49, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
