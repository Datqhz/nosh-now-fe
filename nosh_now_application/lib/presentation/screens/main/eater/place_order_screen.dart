// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:nosh_now_application/core/constants/constants.dart';
import 'package:nosh_now_application/core/utils/dash_line_painter.dart';
import 'package:nosh_now_application/core/utils/distance.dart';
import 'package:nosh_now_application/core/utils/map.dart';
import 'package:nosh_now_application/core/utils/snack_bar.dart';
import 'package:nosh_now_application/data/models/delivery_info.dart';
import 'package:nosh_now_application/data/models/payment_method.dart';
import 'package:nosh_now_application/data/repositories/location_repository.dart';
import 'package:nosh_now_application/data/repositories/order_repository.dart';
import 'package:nosh_now_application/data/requests/checkout_order_request.dart';
import 'package:nosh_now_application/data/responses/get_order_init_byid_response.dart';
import 'package:nosh_now_application/data/responses/get_saved_locations_response.dart';
import 'package:nosh_now_application/presentation/screens/main/eater/choose_payment_method_screen.dart';
import 'package:nosh_now_application/presentation/screens/main/eater/order_process_screen.dart';
import 'package:nosh_now_application/presentation/screens/main/eater/pick_location_screen.dart';
import 'package:nosh_now_application/presentation/widgets/order_detail_item.dart';
import 'package:pay/pay.dart';

// ignore: must_be_immutable
class PlaceOrderScreen extends StatefulWidget {
  PlaceOrderScreen({super.key, required this.orderId});

  int orderId;

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  ValueNotifier<PaymentMethod?> currentSelected = ValueNotifier(null);
  ValueNotifier<double> delivery = ValueNotifier(0);
  ValueNotifier<double> total = ValueNotifier(0);
  ValueNotifier<bool> isLoading = ValueNotifier(true);
  ValueNotifier<GetSavedLocationData?> currentLocationPicked =
      ValueNotifier(null);
  ValueNotifier<GetOrderInitByIdData?> order = ValueNotifier(null);
  final Future<PaymentConfiguration> _googlePayConfigFuture =
      PaymentConfiguration.fromAsset('json/ggpay_config.json');

  late ValueNotifier<int> countdownValue;
  Timer? _timer;

  Future setupData(BuildContext context) async {
    isLoading.value = true;
    var orderInfo =
        await OrderRepository().getOrderInitById(widget.orderId, context);
    if (orderInfo == null) {
      isLoading.value = false;
      return;
    }

    order.value = orderInfo;
    isLoading.value = false;
    currentLocationPicked.addListener(calcDeliveryOnChange);
    delivery.addListener(calcTotal);
    var savedLocations = await LocationRepository().getSavedLocations(context);
    if (savedLocations != null) {
      currentLocationPicked.value = savedLocations[0];
    }
    currentSelected.value = Constants.paymentMethods[0];
  }

  void calcDeliveryOnChange() {
    if (currentLocationPicked.value != null) {
      double distance = calcDistanceInKm(
          coordinator1: order.value!.restaurantCoordinate,
          coordinator2: currentLocationPicked.value!.coordinate);
      print(distance);
      if (distance < 1) {
        delivery.value = 15000;
      } else {
        delivery.value = distance * 15000;
      }
    } else {
      delivery.value = 0;
    }
  }

  void calcTotal() {
    total.value = order.value!.substantial + delivery.value;
  }

  @override
  void initState() {
    super.initState();
    setupData(context);
    countdownValue = ValueNotifier<int>(Constants.placeOrderTimeout);
    startCountdown();
  }

  void startCountdown() {
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdownValue.value > 0) {
        countdownValue.value = countdownValue.value - 1;
      } else {
        timer.cancel();
        _removeSelf();
      }
    });
  }

  void _removeSelf() {
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    currentLocationPicked.removeListener(calcDeliveryOnChange);
    delivery.removeListener(calcTotal);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, loading, child) {
                if (!loading && order.value != null) {
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 66,
                            ),
                            // current delivery infomation
                            GestureDetector(
                              onTap: () async {
                                var newPicked = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PickLocationScreen(
                                      currentPick: currentLocationPicked.value!,
                                    ),
                                  ),
                                );
                                if (newPicked != null) {
                                  currentLocationPicked.value = newPicked;
                                }
                              },
                              child: ValueListenableBuilder(
                                  valueListenable: currentLocationPicked,
                                  builder: (context, value, child) {
                                    if (value != null) {
                                      return Container(
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.location_on_sharp,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    child: Text(
                                                      '${value.name} - ${value.phone}',
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromRGBO(
                                                              49, 49, 49, 1),
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                  ),
                                                  FutureBuilder(
                                                      future: getAddressFromLatLng(
                                                          splitCoordinatorString(
                                                              value
                                                                  .coordinate)),
                                                      builder: (context,
                                                          addressSnapshot) {
                                                        if (addressSnapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .done &&
                                                            addressSnapshot
                                                                .hasData) {
                                                          return Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  addressSnapshot
                                                                      .data!,
                                                                  maxLines: 1,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              49,
                                                                              49,
                                                                              49,
                                                                              1),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        }
                                                        return const Text('');
                                                      }),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            const Icon(
                                              Icons.chevron_right,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    return const Center(
                                      child: SpinKitCircle(
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    );
                                  }),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            // List detail item
                            ValueListenableBuilder(
                                valueListenable: order,
                                builder: (context, orderValue, child) {
                                  if (orderValue == null) {
                                    return const Center(
                                      child: SpinKitCircle(
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    );
                                  }
                                  return Column(
                                      children: List.generate(
                                    orderValue.orderDetails.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: OrderDetailItem(
                                          orderDetail:
                                              orderValue.orderDetails[index]),
                                    ),
                                  ));
                                }),

                            const SizedBox(
                              height: 320,
                            )
                          ],
                        ),
                      ),
                      //app bar
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Stack(
                          children: [
                            Container(
                              height: 60,
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: ValueListenableBuilder(
                                  valueListenable: order,
                                  builder: (context, orderValue, child) {
                                    if (orderValue == null) {
                                      return SizedBox();
                                    }
                                    return Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(
                                            CupertinoIcons.xmark,
                                            color: Colors.black,
                                            size: 22,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                orderValue.restaurantName,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromRGBO(
                                                        49, 49, 49, 1),
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              FutureBuilder(
                                                  future: checkPermissions(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState.done) {
                                                      return Text(
                                                        'Distance: ${calcDistanceInKm(coordinator1: orderValue.restaurantCoordinate, coordinator2: '${snapshot.data!.latitude}-${snapshot.data!.longitude}')} km',
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Color.fromRGBO(
                                                                    49,
                                                                    49,
                                                                    49,
                                                                    1),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      );
                                                    }
                                                    return const SizedBox();
                                                  })
                                            ],
                                          ),
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: countdownValue,
                                          builder: (context, value, child) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${value}s',
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromRGBO(
                                                          220, 4, 4, 1),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                                Text(
                                                  'remaining',
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromRGBO(
                                                          220, 4, 4, 1),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      // substantial bill
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              )),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  ValueListenableBuilder(
                                    valueListenable: order,
                                    builder: (context, orderValue, child) {
                                      if (orderValue == null) {
                                        return SizedBox();
                                      }
                                      return Text(
                                        NumberFormat.currency(
                                                locale: 'vi_VN', symbol: '₫')
                                            .format(orderValue.substantial),
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                120, 120, 120, 1),
                                            overflow: TextOverflow.ellipsis),
                                      );
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  ValueListenableBuilder<double>(
                                    valueListenable: delivery,
                                    builder: (context, value, child) {
                                      print(value);
                                      return Text(
                                        NumberFormat.simpleCurrency(
                                                locale: 'vi_VN',
                                                decimalDigits: 0)
                                            .format(value),
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(120, 120, 120, 1),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomPaint(
                                size: const Size(double.infinity, 1),
                                painter: DashedLinePainter(
                                    dashWidth: 5.0,
                                    dashSpace: 3.0,
                                    color: Colors.black,
                                    strokeWidth: 1),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  ValueListenableBuilder<double>(
                                    valueListenable: total,
                                    builder: (context, value, child) {
                                      return Text(
                                        NumberFormat.currency(
                                                locale: 'vi_VN', symbol: '₫')
                                            .format(value),
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(49, 49, 49, 1),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Container(
                                child: const Text(
                                  'Payment',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(49, 49, 49, 1),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  PaymentMethod method = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChoosePaymentMethodScreen(
                                              currentPick:
                                                  currentSelected.value!),
                                    ),
                                  );
                                  currentSelected.value = method;
                                },
                                child: ValueListenableBuilder(
                                    valueListenable: currentSelected,
                                    builder: (context, value, child) {
                                      if (value == null) {
                                        return const SizedBox();
                                      }
                                      return Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        decoration: const BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              color: Color.fromRGBO(
                                                  120, 120, 120, 1),
                                              width: 0.6),
                                        )),
                                        child: Row(
                                          children: [
                                            Image.network(
                                              value.methodImage,
                                              height: 18,
                                              width: 18,
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              'Pay via ${value.methodName}',
                                              maxLines: 1,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      49, 49, 49, 1),
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            const Expanded(child: SizedBox()),
                                            const Icon(
                                              CupertinoIcons.chevron_forward,
                                              color: Colors.black,
                                              size: 18,
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ValueListenableBuilder(
                                  valueListenable: currentSelected,
                                  builder: (context, value, child) => (value !=
                                              null &&
                                          value.methodId !=
                                              Constants.payViaGPay)
                                      ? Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          width: double.infinity,
                                          height: 44,
                                          child: TextButton(
                                            onPressed: () async {
                                              var request =
                                                  CheckoutOrderRequest(
                                                orderId: widget.orderId,
                                                paymentMethod: currentSelected
                                                    .value!.methodId,
                                                shippingFee: delivery.value,
                                                deliveryInfo: DeliveryInfo(
                                                    phone: currentLocationPicked
                                                        .value!.phone,
                                                    coordinate:
                                                        currentLocationPicked
                                                            .value!.coordinate),
                                              );
                                              if (value.methodId ==
                                                  Constants.payViaMono) {
                                                var paymentRs =
                                                    await MethodChannel(
                                                            'payment')
                                                        .invokeMethod('momo', {
                                                  'orderId':
                                                      order.value!.orderId,
                                                  'amount':
                                                      total.value.toString()
                                                });
                                              }

                                              if (delivery.value != 0) {
                                                var request =
                                                    CheckoutOrderRequest(
                                                  orderId: widget.orderId,
                                                  paymentMethod: currentSelected
                                                      .value!.methodId,
                                                  shippingFee: delivery.value,
                                                  deliveryInfo: DeliveryInfo(
                                                      phone:
                                                          currentLocationPicked
                                                              .value!.phone,
                                                      coordinate:
                                                          currentLocationPicked
                                                              .value!
                                                              .coordinate),
                                                );

                                                var isCheckedout =
                                                    await OrderRepository()
                                                        .checkoutOrder(
                                                            request, context);
                                                if (isCheckedout) {
                                                  Navigator.popUntil(context,
                                                      (route) => route.isFirst);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrderProcessScreen(
                                                        orderId: widget.orderId,
                                                      ),
                                                    ),
                                                  );
                                                  showSnackBar(context,
                                                      "Checkout successful!");
                                                }
                                              } else {
                                                if (delivery.value == 0) {
                                                  showSnackBar(context,
                                                      "Please wait a second to caculate");
                                                }
                                              }
                                            },
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.black,
                                                foregroundColor: Colors.white,
                                                textStyle: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            child: const Text('Checkout'),
                                          ),
                                        )
                                      : const SizedBox()),
                              ValueListenableBuilder(
                                valueListenable: currentSelected,
                                builder: (context, value, child) {
                                  if (value != null &&
                                      value.methodId == Constants.payViaGPay) {
                                    return FutureBuilder(
                                        future: _googlePayConfigFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              snapshot.hasData) {
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              width: double.infinity,
                                              height: 44,
                                              child: GooglePayButton(
                                                paymentConfiguration:
                                                    snapshot.data!,
                                                paymentItems: [
                                                  PaymentItem(
                                                    label: 'Total',
                                                    amount:
                                                        total.value.toString(),
                                                    status: PaymentItemStatus
                                                        .final_price,
                                                  )
                                                ],
                                                type: GooglePayButtonType
                                                    .checkout,
                                                onPaymentResult:
                                                    (paymentRs) async {
                                                  if (delivery.value != 0) {
                                                    var request =
                                                        CheckoutOrderRequest(
                                                      orderId: widget.orderId,
                                                      paymentMethod:
                                                          currentSelected
                                                              .value!.methodId,
                                                      shippingFee:
                                                          delivery.value,
                                                      deliveryInfo: DeliveryInfo(
                                                          phone:
                                                              currentLocationPicked
                                                                  .value!.phone,
                                                          coordinate:
                                                              currentLocationPicked
                                                                  .value!
                                                                  .coordinate),
                                                    );
                                                    var isCheckedout =
                                                        await OrderRepository()
                                                            .checkoutOrder(
                                                                request,
                                                                context);
                                                    if (isCheckedout) {
                                                      Navigator.popUntil(
                                                          context,
                                                          (route) =>
                                                              route.isFirst);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              OrderProcessScreen(
                                                            orderId:
                                                                widget.orderId,
                                                          ),
                                                        ),
                                                      );
                                                      showSnackBar(context,
                                                          "Checkout successful!");
                                                    }
                                                  } else {
                                                    if (delivery.value == 0) {
                                                      showSnackBar(context,
                                                          "Please wait a second to caculate");
                                                    }
                                                  }
                                                },
                                                cornerRadius: 8,
                                                width: double.maxFinite,
                                                loadingIndicator: const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                            );
                                          }
                                          return const Text("");
                                        });
                                  }
                                  return SizedBox();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }

                if (!loading && order.value == null) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.2),
                    child: Center(
                        child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      width: MediaQuery.of(context).size.width - 30,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Text(
                            "Ingredient isn't sufficient to serve this order",
                            style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(49, 49, 49, 1),
                                overflow: TextOverflow.ellipsis),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(49, 49, 49, 1),
                                ),
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent),
                            ),
                          )
                        ],
                      ),
                    )),
                  );
                }

                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(0.2),
                  child: Center(
                    child: SpinKitWave(
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
