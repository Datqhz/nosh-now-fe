import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_app/data/responses/get_transfer_transactions_response.dart';

class OveviewTransferTransactionItem extends StatelessWidget {
  OveviewTransferTransactionItem({super.key, required this.transaction});

  GetTransferTransactionsData transaction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth,
        padding: const EdgeInsets.only(bottom: 8, top: 12),
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
            // icon
            Container(
                height: 50,
                width: 50,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Image.network(
                  transaction.avatar,
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name
                  Text(
                    transaction.restaurantName,
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
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "${transaction.totalTransactions} transactions",
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
                      Expanded(
                        child: Text(
                          NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                              .format(transaction.amount),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                            height: 1.2,
                            color: Color.fromRGBO(49, 49, 49, 1),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
      );
    });
  }
}