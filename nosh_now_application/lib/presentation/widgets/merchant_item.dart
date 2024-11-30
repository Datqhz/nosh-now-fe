import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nosh_now_application/data/responses/get_restaurants_response.dart';

class RestaurantItem extends StatelessWidget {

  RestaurantItem({super.key, required this.restaurant});
  GetRestaurantsData restaurant;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width - 40,
      child: Row(
        children: [
          // merchant avatar
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(restaurant.avatar),
                  fit: BoxFit.cover,
              ),
              color: Colors.black,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 132,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // merchant name
                Text(
                  restaurant.restaurantName,
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
                Row(
                  children: [
                    // distance to merchant
                    Text(
                      '${double.parse((restaurant.distance).toStringAsFixed(2))} km',
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
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      CupertinoIcons.circle_fill,
                      size: 4,
                      color: Color.fromRGBO(49, 49, 49, 1),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    // category name
                    // Expanded(
                    //   child: Text(
                    //     merchant.merchant.category!.categoryName,
                    //     textAlign: TextAlign.left,
                    //     maxLines: 1,
                    //     style: const TextStyle(
                    //       fontSize: 14.0,
                    //       fontWeight: FontWeight.w300,
                    //       height: 1.2,
                    //       color: Color.fromRGBO(49, 49, 49, 1),
                    //       overflow: TextOverflow.ellipsis,
                    //     ),
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
