import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:management_app/data/models/restaurant_role.dart';
import 'package:management_app/data/repositories/employee_repository.dart';
import 'package:management_app/data/requests/get_employees.dart';
import 'package:management_app/data/responses/get_employees_data.dart';
import 'package:management_app/presentation/screens/employee_profile_screen.dart';
import 'package:management_app/presentation/screens/restaurant/add_employee_screen.dart';
import 'package:management_app/presentation/widget/employee_item.dart';

class ManageEmployeeScreen extends StatefulWidget {
  const ManageEmployeeScreen({super.key});

  @override
  State<ManageEmployeeScreen> createState() => _ManageEmployeeScreenState();
}

class _ManageEmployeeScreenState extends State<ManageEmployeeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ValueNotifier<List<GetEmployeesData>?> employees = ValueNotifier(null);

  ValueNotifier<int> option = ValueNotifier(1);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchData();
  }

  Future<void> fetchData() async {
    var request = GetEmployeesRequest(
        keyword: '',
        pageNumber: 1,
        maxPerPage: 50,
        role: RestaurantRole.values[_tabController.index]);
    List<GetEmployeesData>? list =
        await EmployeeRepository().getEmployees(request, context);
    if (list == null) {
      employees.value = null;
    }
    employees.value = list;
  }

  void reload() {
    fetchData();
  }

  Widget buildHeader() {
    return const Row(
      children: [
        const Text(
          'Your employee',
          maxLines: 1,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(49, 49, 49, 1),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Expanded(child: SizedBox()),
        // ValueListenableBuilder(
        //     valueListenable: option,
        //     builder: (context, value, child) {
        //       return GestureDetector(
        //         onTap: () {
        //           showModalBottomSheet(
        //               context: context,
        //               builder: (context) {
        //                 return Container(
        //                   height: 220,
        //                   color: Colors.black,
        //                   padding: const EdgeInsets.symmetric(horizontal: 20),
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       const Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         children: [
        //                           Icon(
        //                             CupertinoIcons.minus,
        //                             color: Colors.white,
        //                             size: 40,
        //                           )
        //                         ],
        //                       ),
        //                       const SizedBox(
        //                         height: 6,
        //                       ),
        //                       const Text(
        //                         "Sort",
        //                         style: TextStyle(
        //                           fontSize: 22,
        //                           color: Colors.white,
        //                           fontWeight: FontWeight.w600,
        //                         ),
        //                       ),
        //                       const SizedBox(
        //                         height: 15,
        //                       ),
        //                       GestureDetector(
        //                         onTap: () async {
        //                           option.value = 1;
        //                           await fetchData();
        //                           Navigator.pop(context);
        //                         },
        //                         child: Row(
        //                           children: [
        //                             const Text(
        //                               "Newest",
        //                               style: TextStyle(
        //                                 fontSize: 16,
        //                                 color: Colors.white,
        //                                 fontWeight: FontWeight.w400,
        //                               ),
        //                             ),
        //                             const SizedBox(
        //                               width: 12,
        //                             ),
        //                             if (value == 1)
        //                               const Icon(
        //                                 CupertinoIcons
        //                                     .checkmark_alt_circle_fill,
        //                                 color: Colors.white,
        //                               )
        //                           ],
        //                         ),
        //                       ),
        //                       const SizedBox(
        //                         height: 15,
        //                       ),
        //                       GestureDetector(
        //                         onTap: () async {
        //                           option.value = 0;
        //                           await fetchData();
        //                           Navigator.pop(context);
        //                         },
        //                         child: Row(
        //                           children: [
        //                             const Text(
        //                               "Oldest",
        //                               style: TextStyle(
        //                                 fontSize: 16,
        //                                 color: Colors.white,
        //                                 fontWeight: FontWeight.w400,
        //                               ),
        //                             ),
        //                             const SizedBox(
        //                               width: 12,
        //                             ),
        //                             if (value == 2)
        //                               const Icon(
        //                                 CupertinoIcons
        //                                     .checkmark_alt_circle_fill,
        //                                 color: Colors.white,
        //                               )
        //                           ],
        //                         ),
        //                       ),
        //                       const SizedBox(
        //                         height: 18,
        //                       ),
        //                     ],
        //                   ),
        //                 );
        //               });
        //         },
        //         child: Row(
        //           children: [
        //             Text(
        //               value == 1 ? 'Newest' : 'Oldest',
        //               maxLines: 1,
        //               style: const TextStyle(
        //                 fontSize: 16.0,
        //                 fontWeight: FontWeight.w400,
        //                 color: Color.fromRGBO(49, 49, 49, 1),
        //                 overflow: TextOverflow.ellipsis,
        //               ),
        //             ),
        //             Icon(
        //               value == 1
        //                   ? CupertinoIcons.sort_down
        //                   : CupertinoIcons.sort_up,
        //               color: const Color.fromRGBO(49, 49, 49, 1),
        //             )
        //           ],
        //         ),
        //       );
        //     })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              color: const Color.fromRGBO(240, 240, 240, 1),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    buildHeader(),
                    const SizedBox(
                      height: 12,
                    ),
                    // list order
                    ValueListenableBuilder(
                        valueListenable: employees,
                        builder: (context, value, child) {
                          if (value == null) {
                            return const Center(
                              child: SpinKitCircle(
                                color: Colors.black,
                                size: 50,
                              ),
                            );
                          }
                          if (value.isEmpty) {
                            return Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width - 40,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Image.asset(
                                    "assets/images/nodatafound.png"),
                              ),
                            );
                          } else {
                            return Column(
                              children: List.generate(value.length, (index) {
                                return GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EmployeeProfileScreen(
                                                employee: value[index]),
                                      ),
                                    )
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: EmployeeItem(
                                      employee: value[index],
                                      onChanged: reload,
                                    ),
                                  ),
                                );
                              }),
                            );
                          }
                        }),
                    const SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: const Color.fromRGBO(240, 240, 240, 1),
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            CupertinoIcons.arrow_left,
                            size: 20,
                            color: Color.fromRGBO(49, 49, 49, 1),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            var isCreated = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddEmployeeScreen()));
                            if (isCreated) {
                              await fetchData();
                            }
                          },
                          child: const Icon(
                            CupertinoIcons.add,
                            size: 20,
                            color: Color.fromRGBO(49, 49, 49, 1),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(240, 240, 240, 1),
                      ),
                      child: TabBar(
                        onTap: (index) async {
                          employees.value = [];
                          await fetchData();
                        },
                        unselectedLabelColor:
                            const Color.fromRGBO(170, 184, 194, 1),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 5,
                        controller: _tabController,
                        tabs: const [
                          Text(
                            "Service staff",
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(14, 2, 2, 1),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            'Chef',
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(49, 49, 49, 1),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
