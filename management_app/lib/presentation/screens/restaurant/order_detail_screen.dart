import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/utils/distance.dart';
import 'package:management_app/core/utils/map.dart';
import 'package:management_app/core/utils/status_helper.dart';
import 'package:management_app/data/repositories/order_detail_repository.dart';
import 'package:management_app/data/repositories/order_repository.dart';
import 'package:management_app/data/requests/update_status_orderdetail_request.dart';
import 'package:management_app/data/responses/get_order_by_id_response.dart';
import 'package:management_app/presentation/widget/order_detail_item.dart';

class OrderDetailScreen extends StatefulWidget {
  OrderDetailScreen({super.key, required this.orderId, required this.callback});

  int orderId;
  Function callback;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  ValueNotifier<GetOrderByIdData?> order = ValueNotifier(null);
  ValueNotifier<List<int>> checkedList = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    fetchOrderData(context);
  }

  Future<void> fetchOrderData(BuildContext context) async {
    order.value = await OrderRepository().getOrderById(widget.orderId, context);
  }

  void reload() {
    widget.callback();
    fetchOrderData(context);
  }

  void onChanged(int orderDetailId, bool isChecked) {
    var temp = checkedList.value;
    if (isChecked) {
      temp.add(orderDetailId);
    } else {
      temp.remove(orderDetailId);
    }

    checkedList.value = temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: order,
          builder: (context, orderValue, child) {
            if (orderValue == null) {
              return const Center(
                child: SpinKitCircle(
                  color: Colors.black,
                  size: 50,
                ),
              );
            }
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 66,
                        ),
                        // eater
                        const Text(
                          'Customer',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(49, 49, 49, 1),
                              overflow: TextOverflow.ellipsis),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Name: ',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(49, 49, 49, 1),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Expanded(
                              child: Text(
                                "${orderValue.customerName}",
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(49, 49, 49, 1),
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Order date: ',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(49, 49, 49, 1),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Expanded(
                              child: Text(
                                DateFormat.yMMMd("en_US")
                                    .format(orderValue.orderDate)
                                    .toString(),
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(49, 49, 49, 1),
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Delivery address: ',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(49, 49, 49, 1),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Expanded(
                              child: FutureBuilder(
                                  future: getAddressFromLatLng(
                                      splitCoordinatorString(
                                          orderValue.deliveryInfo.coordinate)),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      return Text(
                                        snapshot.data!,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Color.fromRGBO(49, 49, 49, 1),
                                            overflow: TextOverflow.ellipsis),
                                      );
                                    }
                                    return const SizedBox();
                                  }),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Phone: ',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(49, 49, 49, 1),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Expanded(
                              child: Text(
                                orderValue.deliveryInfo.phone,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(49, 49, 49, 1),
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Color.fromRGBO(159, 159, 159, 1),
                        ),
                        const Text(
                          'Restaurant',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(49, 49, 49, 1),
                              overflow: TextOverflow.ellipsis),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Name: ',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(49, 49, 49, 1),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Expanded(
                              child: Text(
                                orderValue.restaurantName,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(49, 49, 49, 1),
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text(
                              'Address: ',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(49, 49, 49, 1),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Expanded(
                              child: FutureBuilder(
                                  future: getAddressFromLatLng(
                                      splitCoordinatorString(
                                          orderValue.restaurantCoordinate)),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      return Text(
                                        snapshot.data!,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Color.fromRGBO(49, 49, 49, 1),
                                            overflow: TextOverflow.ellipsis),
                                      );
                                    }
                                    return const SizedBox();
                                  }),
                            ),
                          ],
                        ),
                        if (orderValue.shipperName != null &&
                            orderValue.shipperImage != null) ...[
                          const Divider(
                            color: Color.fromRGBO(159, 159, 159, 1),
                          ),
                          const Text(
                            'Shipper',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(49, 49, 49, 1),
                                overflow: TextOverflow.ellipsis),
                          ),
                          Row(
                            children: [
                              const Text(
                                'Name: ',
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(49, 49, 49, 1),
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Expanded(
                                child: Text(
                                  orderValue.shipperName!,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(49, 49, 49, 1),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ],
                          ),
                        ],
                        const Divider(
                          color: Color.fromRGBO(159, 159, 159, 1),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              orderValue.orderDetails.length, (index) {
                            return OrderDetailItem(
                                orderDetail: orderValue.orderDetails[index],
                                onChange: onChanged);
                          }),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Substantial',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(120, 120, 120, 1),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'vi_VN', symbol: '₫')
                                  .format(orderValue.substantial),
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(120, 120, 120, 1),
                                  overflow: TextOverflow.ellipsis),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Delivery',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(120, 120, 120, 1),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'vi_VN', symbol: '₫')
                                  .format(orderValue.shippingFee),
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(120, 120, 120, 1),
                                  overflow: TextOverflow.ellipsis),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(49, 49, 49, 1),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'vi_VN', symbol: '₫')
                                  .format(orderValue.total),
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(49, 49, 49, 1),
                                  overflow: TextOverflow.ellipsis),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (GlobalVariable.scope == 'ServiceStaff' &&
                            orderValue.orderStatus == 3)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            height: 44,
                            child: TextButton(
                              onPressed: () async {
                                // TODO
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor:
                                    const Color.fromRGBO(240, 240, 240, 1),
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(StatusHelper.getButtonTItle(
                                  orderValue.orderStatus)['text']),
                            ),
                          ),
                        if (GlobalVariable.scope == 'ServiceStaff' &&
                            orderValue.orderStatus == 1) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            height: 44,
                            child: TextButton(
                              onPressed: () async {
                                var result = await OrderRepository()
                                    .acceptOrder(orderValue.orderId, context);
                                if (result) {
                                  reload();
                                }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor:
                                    const Color.fromRGBO(240, 240, 240, 1),
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Accept'),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            height: 44,
                            child: TextButton(
                              onPressed: () async {
                                var result = await OrderRepository()
                                    .rejectOrder(orderValue.orderId, context);
                                if (result) {
                                  reload();
                                }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.red,
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(
                                        color: Colors.red, width: 1)),
                              ),
                              child: const Text('Reject'),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                        ],

                        if (GlobalVariable.scope == 'Chef' &&
                            orderValue.orderStatus == 2)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            height: 44,
                            child: TextButton(
                              onPressed: () async {
                                var updateInput =
                                    <UpdateStatusOrderdetailInput>[];
                                for (var e in checkedList.value) {
                                  var input = UpdateStatusOrderdetailInput(
                                      orderDetailId: e, status: 1);
                                  updateInput.add(input);
                                }
                                var request = UpdateStatusOrderdetailRequest(
                                    orderId: orderValue.orderId,
                                    input: updateInput);
                                var result = await OrderDetailRepository()
                                    .updateOrderDetail(request, context);
                                if (result) {
                                  reload();
                                }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor:
                                    const Color.fromRGBO(240, 240, 240, 1),
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Update"),
                            ),
                          ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ),
                //app bar
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
                          'Order detail',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(49, 49, 49, 1),
                              overflow: TextOverflow.ellipsis),
                        ),
                        const Expanded(child: SizedBox()),
                        ValueListenableBuilder(
                            valueListenable: order,
                            builder: (context, value, child) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.circle_fill,
                                    size: 10,
                                    color: StatusHelper.getStatusInfo(
                                        orderValue.orderStatus)['color'],
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    StatusHelper.getStatusInfo(
                                        orderValue.orderStatus)['text'],
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
                                ],
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
