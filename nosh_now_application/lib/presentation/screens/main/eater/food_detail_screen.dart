import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nosh_now_application/core/streams/order_detail_notifier.dart';
import 'package:nosh_now_application/core/utils/snack_bar.dart';
import 'package:nosh_now_application/data/repositories/food_repository.dart';
import 'package:nosh_now_application/data/repositories/order_detail_repository.dart';
import 'package:nosh_now_application/data/requests/create_orderdetail_request.dart';
import 'package:nosh_now_application/data/requests/update_orderdetail_request.dart';
import 'package:nosh_now_application/data/responses/get_food_byid_response.dart';
import 'package:nosh_now_application/data/responses/get_order_init_response.dart';

// ignore: must_be_immutable
class FoodDetailScreen extends StatefulWidget {
  FoodDetailScreen(
      {super.key,
      required this.foodId,
      required this.notifier,
      required this.orderId});

  int foodId;
  OrderDetailNotifier notifier;
  int orderId;

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  ValueNotifier<int> amount = ValueNotifier(0);
  ValueNotifier<GetFoodByIdData?> food = ValueNotifier(null);

  String _contentForButton(int value) {
    if (widget.notifier.detail != null && value == 0) {
      return "Remove from order";
    } else if (widget.notifier.detail != null && value > 0) {
      return "Update order";
    } else {
      return "Add to order";
    }
  }

  Future _fetchFood(BuildContext context) async{
    food.value = await FoodRepository().getFoodById(widget.foodId, context);
  }

  @override
  void initState() {
    super.initState();
    int temp = 0;
    if (widget.notifier.detail != null) {
      temp = widget.notifier.detail!.amount;
    }
    amount = ValueNotifier(temp);
    _fetchFood(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: Stack(
          children: [
            // food image
            Column(
              children: [
                ValueListenableBuilder(valueListenable: food, builder: (context, foodValue, child){
                  if(foodValue == null){
                    return Image(
                      image: AssetImage('assets/images/black.jpg'),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.4,
                      fit: BoxFit.cover,
                    );
                  }
                  return Image(
                      image: NetworkImage(foodValue.foodImage),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.4,
                      fit: BoxFit.cover,
                    );
                })
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.7,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(240, 240, 240, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: ValueListenableBuilder(
                  valueListenable: food,
                  builder: (context, foodValue, child) {
                    if(foodValue == null){
                      return SizedBox();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 40,
                            width: 100,
                            transform: Matrix4.translationValues(-20, -20, 0),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.4), // Màu sắc của bóng đổ
                                    spreadRadius: 2, // Độ mờ viền của bóng đổ
                                    blurRadius: 7, // Độ mờ của bóng đổ
                                    offset: const Offset(0, 2),
                                  )
                                ],
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (amount.value > 0) {
                                      amount.value = amount.value - 1;
                                    }
                                  },
                                  child: const Icon(
                                    CupertinoIcons.minus,
                                    color: Color.fromRGBO(240, 240, 240, 1),
                                  ),
                                ),
                                ValueListenableBuilder(
                                    valueListenable: amount,
                                    builder: (context, value, child) {
                                      return Text(
                                        value.toString(),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          height: 1.2,
                                          color: Color.fromRGBO(240, 240, 240, 1),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    }),
                                GestureDetector(
                                  onTap: () {
                                    amount.value = amount.value + 1;
                                  },
                                  child: const Icon(
                                    CupertinoIcons.plus,
                                    color: Color.fromRGBO(240, 240, 240, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  foodValue.foodName,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w800,
                                    height: 1.2,
                                    color: Color.fromRGBO(49, 49, 49, 1),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Text(
                                NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                                    .format(foodValue.foodPrice),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w800,
                                  height: 1.2,
                                  color: Color.fromRGBO(49, 49, 49, 1),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Expanded(
                          child: Text(
                            foodValue.foodDescription == null ? "" : foodValue.foodDescription!,
                            textAlign: TextAlign.left,
                            maxLines: 10,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                              color: Color.fromRGBO(49, 49, 49, 1),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total',
                                  textAlign: TextAlign.left,
                                  maxLines: 10,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2,
                                    color: Color.fromRGBO(49, 49, 49, 1),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                ValueListenableBuilder(
                                    valueListenable: amount,
                                    builder: (context, value, child) {
                                      return Text(
                                        NumberFormat.currency(
                                                locale: 'vi_VN', symbol: '₫')
                                            .format(foodValue.foodPrice * value),
                                        textAlign: TextAlign.left,
                                        maxLines: 10,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w800,
                                          height: 1.2,
                                          color: Color.fromRGBO(49, 49, 49, 1),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    }),
                              ],
                            ),
                            ValueListenableBuilder(
                                valueListenable: amount,
                                builder: (context, value, child) {
                                  return ElevatedButton.icon(
                                    onPressed: () async {
                                      bool rs = false;
                                      var newAmount = amount.value;
                                      var orderDetail = widget.notifier.detail;
                                      if (orderDetail != null) {
                                        if (newAmount> 0 && newAmount != orderDetail.amount) {

                                          var request = UpdateOrderDetailRequest(
                                            orderDetailId: orderDetail.id,
                                            amount : newAmount
                                          );
                                          
                                          rs = await OrderDetailRepository().updateOrderDetail(request, context);
                                          if (rs) {
                                            orderDetail.amount = newAmount;
                                            widget.notifier.change(orderDetail);
                                          }
                                        } else {
                                          rs = await OrderDetailRepository().deleteOrderDetail(orderDetail.id, context);
                                          if (rs) {
                                            widget.notifier.change(null);
                                          }
                                        }
                                      } else {
                                        if (newAmount > 0) {
                                          var request = CreateOrderDetailRequest(
                                            foodId: widget.foodId, 
                                            orderId: widget.orderId,
                                            amount: newAmount
                                          );
                                          var result  = await OrderDetailRepository().createOrderDetail(request, context);
                                          if (result != null) {
                                            rs = true;
                                            var newOrderDetail = OrderDetailData(
                                              foodId: widget.foodId,
                                              id: result,
                                              amount: newAmount
                                            );
                                            widget.notifier.change(newOrderDetail);
                                          }
                                        }
                                      }
                    
                                      if (rs) {
                                        showSnackBar(context, "Update order successfully!");
                                        Navigator.pop(context);
                                      }
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.cart_fill,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    label: Text(
                                      _contentForButton(value),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.zero,
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(10)))),
                                  );
                                })
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  }
                ),
              ),
            ),
            // App bar
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
