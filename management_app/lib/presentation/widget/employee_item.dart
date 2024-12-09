import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:management_app/core/utils/dialog.dart';
import 'package:management_app/data/repositories/employee_repository.dart';
import 'package:management_app/data/responses/get_employees_data.dart';
import 'package:management_app/presentation/screens/employee_profile_screen.dart';
import 'package:management_app/presentation/screens/restaurant/update_employee_screen.dart';

class EmployeeItem extends StatelessWidget {
  EmployeeItem({super.key, required this.employee, required this.onChanged});

  GetEmployeesData employee;
  Function onChanged;

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
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmployeeProfileScreen(
                            employee: employee,
                          )));
            },
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(employee.avatar),
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
                      Row(
                        children: [
                          Text(
                            employee.displayName,
                            textAlign: TextAlign.center,
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
                            width: 4,
                          ),
                          Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                                color: employee.isActive
                                    ? Colors.green
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            employee.isActive ? 'Active' : 'Deleted',
                            textAlign: TextAlign.center,
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
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        employee.email,
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
                )
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                var isChanged = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UpdateEmployeeScreen(employee: employee)));
                if (isChanged != null) {
                  onChanged();
                }
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
                showDeleteDialog(
                  context,
                  'employee',
                  employee.displayName,
                  () async {
                    bool rs = await EmployeeRepository()
                        .deleteEmployee(employee.id, context);
                    if (rs) {
                      onChanged();
                      Navigator.pop(context, true);
                    }
                  },
                );
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
