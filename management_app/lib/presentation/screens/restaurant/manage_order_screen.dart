import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:management_app/core/utils/status_helper.dart';
import 'package:management_app/data/repositories/order_repository.dart';
import 'package:management_app/data/requests/get_orders_request.dart';
import 'package:management_app/data/responses/get_orders_response.dart';
import 'package:management_app/presentation/screens/restaurant/order_detail_screen.dart';
import 'package:management_app/presentation/widget/order_item.dart';

class ManageOrderScreen extends StatefulWidget {
  const ManageOrderScreen({super.key});

  @override
  State<ManageOrderScreen> createState() => _ManageOrderScreenState();
}

class _ManageOrderScreenState extends State<ManageOrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ValueNotifier<List<GetOrdersData>?> orders = ValueNotifier(null);

  ValueNotifier<int> option = ValueNotifier(1);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
    fetchData();
  }

  Future<void> fetchData() async {
    var request = GetOrdersRequest(
        orderStatus: _tabController.index + 1, sortDirection: option.value);
    List<GetOrdersData>? list =
        await OrderRepository().getOrders(request, context);
    if (list == null) {
      orders.value = null;
    }
    orders.value = list;
  }

  void reload() {
    fetchData();
  }

  Widget buildHeader() {
    return Row(
      children: [
        const Text(
          'Your orders',
          maxLines: 1,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(49, 49, 49, 1),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Expanded(child: SizedBox()),
        ValueListenableBuilder(
            valueListenable: option,
            builder: (context, value, child) {
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 220,
                          color: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.minus,
                                    color: Colors.white,
                                    size: 40,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              const Text(
                                "Sort",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  option.value = 1;
                                  await fetchData();
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    const Text(
                                      "Newest",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    if (value == 1)
                                      const Icon(
                                        CupertinoIcons
                                            .checkmark_alt_circle_fill,
                                        color: Colors.white,
                                      )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  option.value = 0;
                                  await fetchData();
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    const Text(
                                      "Oldest",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    if (value == 2)
                                      const Icon(
                                        CupertinoIcons
                                            .checkmark_alt_circle_fill,
                                        color: Colors.white,
                                      )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Row(
                  children: [
                    Text(
                      value == 1 ? 'Newest' : 'Oldest',
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(49, 49, 49, 1),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      value == 1
                          ? CupertinoIcons.sort_down
                          : CupertinoIcons.sort_up,
                      color: const Color.fromRGBO(49, 49, 49, 1),
                    )
                  ],
                ),
              );
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    valueListenable: orders,
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Image.asset("assets/images/nodatafound.png"),
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
                                    builder: (context) => OrderDetailScreen(
                                      orderId: value[index].orderId,
                                      callback: fetchData,
                                    ),
                                  ),
                                )
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: OrderItem(order: value[index]),
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
                    // drawer
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: const Icon(
                        CupertinoIcons.bars,
                        size: 20,
                        color: Color.fromRGBO(49, 49, 49, 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(240, 240, 240, 1),
                  ),
                  child: TabBar(
                    onTap: (index) async {
                      orders.value = [];
                      print('tab tapped');
                      await fetchData();
                    },
                    unselectedLabelColor:
                        const Color.fromRGBO(170, 184, 194, 1),
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    indicatorWeight: 5,
                    controller: _tabController,
                    tabs: [
                      Text(
                        StatusHelper.getStatusInfo(1)['text'],
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(14, 2, 2, 1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        StatusHelper.getStatusInfo(2)['text'],
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(49, 49, 49, 1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        StatusHelper.getStatusInfo(3)['text'],
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(49, 49, 49, 1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        StatusHelper.getStatusInfo(4)['text'],
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(49, 49, 49, 1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        StatusHelper.getStatusInfo(5)['text'],
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(49, 49, 49, 1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        StatusHelper.getStatusInfo(6)['text'],
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(49, 49, 49, 1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        StatusHelper.getStatusInfo(7)['text'],
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(49, 49, 49, 1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        StatusHelper.getStatusInfo(8)['text'],
                        maxLines: 1,
                        style: const TextStyle(
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
    );
  }
}
