import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_app/data/models/order_detail_data.dart';

class OrderDetailItem extends StatelessWidget {
  OrderDetailItem({super.key, required this.orderDetail, required this.onChange});

  OrderDetailData orderDetail;
  ValueNotifier<bool> isChecked = ValueNotifier(false);
  Function onChange;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<WidgetState> states) {
      const Set<WidgetState> interactiveStates = <WidgetState>{
        WidgetState.pressed,
        WidgetState.hovered,
        WidgetState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 12),
      width: MediaQuery.of(context).size.width - 40,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(159, 159, 159, 1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // food image
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(orderDetail.foodImage),
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
                Text(
                  orderDetail.foodName,
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
                  height: 6,
                ),
                Text(
                  '${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(orderDetail.foodPrice)}  x${orderDetail.amount}',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                    height: 1.2,
                    color: Color.fromRGBO(49, 49, 49, 1),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          if (true)
            ValueListenableBuilder(
                valueListenable: isChecked,
                builder: (context, value, child) {
                  return Checkbox(
                    checkColor: Colors.black,
                    fillColor: WidgetStateProperty.resolveWith(getColor),
                    value: value,
                    onChanged: (bool? value) {
                      onChange(orderDetail.orderDetailId, !value!);
                      isChecked.value = !value;
                    },
                  );
                }),
          if (!false)
            const Text(
              'Done',
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                height: 1.2,
                color: Colors.green,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
    );
  }
}
