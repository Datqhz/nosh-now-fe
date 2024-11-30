import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nosh_now_application/core/streams/order_detail_notifier.dart';
import 'package:nosh_now_application/core/utils/image.dart';
import 'package:nosh_now_application/data/responses/get_food_by_restaurant_response.dart';

// ignore: must_be_immutable
class FoodItem extends StatefulWidget {
  FoodItem({super.key, required this.food, required this.detailNotifier});
  GetFoodsData food;
  OrderDetailNotifier detailNotifier;

  @override
  State<FoodItem> createState() => FoodItemState();
}

class FoodItemState extends State<FoodItem> {
  int getQuantity() {
    return widget.detailNotifier.detail != null
        ? widget.detailNotifier.detail!.amount
        : 0;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      ;
      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        height: 190,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // food image
            Image(
              height: 100,
              width: double.infinity,
              image: NetworkImage(widget.food.foodImage),
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 8,
            ),
            // food name
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: constraints.maxWidth - 10,
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      widget.food.foodName,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                        color: Color.fromRGBO(49, 49, 49, 1),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  ListenableBuilder(
                      listenable: widget.detailNotifier,
                      builder: (context, child) {
                        if (widget.detailNotifier.detail != null) {
                          return Text(
                            ' - Selected: ${widget.detailNotifier.detail!.amount}',
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                              height: 1.2,
                              color: Color.fromRGBO(49, 49, 49, 1),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            // price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                    .format(widget.food.price),
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
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      );
    });
  }
}
