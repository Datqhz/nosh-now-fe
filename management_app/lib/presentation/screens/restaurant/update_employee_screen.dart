import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:management_app/core/utils/validate.dart';
import 'package:management_app/data/models/restaurant_role.dart';
import 'package:management_app/data/repositories/employee_repository.dart';
import 'package:management_app/data/requests/update_employee_request.dart';
import 'package:management_app/data/responses/get_employees_data.dart';

class UpdateEmployeeScreen extends StatefulWidget {
  UpdateEmployeeScreen({super.key, required this.employee});
  
  GetEmployeesData employee;

  @override
  State<UpdateEmployeeScreen> createState() => _UpdateEmployeeScreenState();
}

class _UpdateEmployeeScreenState extends State<UpdateEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final List<RestaurantRole> _restaurantRole = RestaurantRole.values;
  final ValueNotifier<String> _roleSelected =
      ValueNotifier(RestaurantRole.values[0].name);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _displayNameController.text = widget.employee.displayName;
    _phoneController.text = widget.employee.phoneNumber;
    _roleSelected.value = widget.employee.role.name;
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _phoneController.dispose();
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
                                    'Role',
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
                          'Update employee',
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
                              final phone = _phoneController.text.trim();

                              var request = UpdateEmployeeRequest(
                                  employeeId: widget.employee.id,
                                  displayname: displayName,
                                  phoneNumber: phone,
                                  avatar: widget.employee.avatar);
                              var isCreated = await EmployeeRepository()
                                  .updateProfile(request, context);
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
