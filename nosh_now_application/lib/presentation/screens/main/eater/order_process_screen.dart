import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:nosh_now_application/core/utils/dash_line_painter.dart';
import 'package:nosh_now_application/core/utils/distance.dart';
import 'package:nosh_now_application/core/utils/map.dart';
import 'package:nosh_now_application/core/utils/status_helper.dart';
import 'package:nosh_now_application/data/models/order_detail.dart';
import 'package:nosh_now_application/data/repositories/order_repository.dart';
import 'package:nosh_now_application/data/responses/get_order_by_id_response.dart';
import 'package:nosh_now_application/presentation/widgets/countdown_button.dart';
import 'package:nosh_now_application/presentation/widgets/order_detail_item.dart';

class OrderProcessScreen extends StatefulWidget {
  OrderProcessScreen({super.key, required this.orderId, this.callback});

  int orderId;
  Function? callback;

  @override
  State<OrderProcessScreen> createState() => _OrderProcessScreenState();
}

class _OrderProcessScreenState extends State<OrderProcessScreen> {
  late ValueNotifier<GetOrderByIdData?> order = ValueNotifier(null);
  ValueNotifier<List<OrderDetail>> orderDetails = ValueNotifier([]);
  MapController mapController = MapController();
  ValueNotifier<List<Polyline>> polylines = ValueNotifier([]);
  ValueNotifier<LatLng?> shipperCoord = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    fetchOrderData(context);
  }

  Future<void> updatePolylineFromStartToTarget(
      LatLng start, LatLng end, int idx) async {
    List<Polyline> currentPolylines = List.from(polylines.value);
    List<LatLng> route = await getRouteCoordinates(start, end);
    currentPolylines[idx] = Polyline(
      points: route,
      strokeWidth: 4.0,
      color: Colors.blue,
    );
    polylines.value = currentPolylines;
  }

  Future<void> fetchOrderData(BuildContext context) async {
    order.value = await OrderRepository().getOrderById(widget.orderId, context);
  }

  Future<void> reload(BuildContext context) async {
    if (widget.callback != null) {
      widget.callback!();
    }
    await fetchOrderData(context);
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
                return Center(
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
                          // current order infomation
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              const Divider(
                                color: Color.fromRGBO(159, 159, 159, 1),
                              ),
                              // delivery infomation
                              const Text(
                                'Delivery info',
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(49, 49, 49, 1),
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Customer: ${orderValue.customerName} - ${orderValue.deliveryInfo.phone}',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2,
                                            color:
                                                Color.fromRGBO(49, 49, 49, 1),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        // phone
                                        Text(
                                          'Ordered date: ${orderValue.orderDate}',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2,
                                            color:
                                                Color.fromRGBO(49, 49, 49, 1),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        FutureBuilder(
                                            future: getAddressFromLatLng(
                                                splitCoordinatorString(
                                                    orderValue.deliveryInfo
                                                        .coordinate)),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                      ConnectionState.done &&
                                                  snapshot.hasData) {
                                                return Text(
                                                  snapshot.data!,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.2,
                                                    color: Color.fromRGBO(
                                                        49, 49, 49, 1),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                );
                                              }
                                              return const SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // value builder
                              const Divider(
                                color: Color.fromRGBO(159, 159, 159, 1),
                              ),
                              // shipper infomation
                              const Text(
                                'Driver',
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(49, 49, 49, 1),
                                    overflow: TextOverflow.ellipsis),
                              ),
                              if (orderValue.shipperName == null ||
                                  orderValue.shipperImage == null) ...[
                                const Text(
                                  "Your order hasn't been picked up yet",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(49, 49, 49, 1),
                                      overflow: TextOverflow.ellipsis),
                                )
                              ],
                              if (orderValue.shipperName != null &&
                                  orderValue.shipperImage != null)
                                Row(
                                  children: [
                                    // shipper avatar
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                orderValue.shipperImage!),
                                            fit: BoxFit.cover),
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // shipper name
                                          Text(
                                            orderValue.shipperName!,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                              height: 1.2,
                                              color:
                                                  Color.fromRGBO(49, 49, 49, 1),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Expanded(
                                      child: SizedBox(
                                        width: 12,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          const Divider(
                            color: Color.fromRGBO(159, 159, 159, 1),
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
                          // List detail item
                          Column(
                            children: List.generate(
                                orderValue.orderDetails.length, (index) {
                              return OrderDetailItem(
                                  orderDetail: orderValue.orderDetails[index]);
                            }),
                          ),
                          const SizedBox(
                            height: 270,
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  CupertinoIcons.arrow_left,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                orderValue.restaurantName,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(49, 49, 49, 1),
                                    overflow: TextOverflow.ellipsis),
                              )
                            ],
                          ),
                          Row(
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
                          )
                        ],
                      ),
                    ),
                  ),
                  // substantial bill
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 260,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  color: Color.fromRGBO(159, 159, 159, 1))),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
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
                          CustomPaint(
                            size: const Size(double.infinity, 1),
                            painter: DashedLinePainter(
                                dashWidth: 5.0,
                                dashSpace: 3.0,
                                color: Colors.black,
                                strokeWidth: 1),
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
                              ),
                            ],
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              width: double.infinity,
                              height: 44,
                              child: CountdownButton(
                                  orderId: orderValue.orderId,
                                  onExecute: reload)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
