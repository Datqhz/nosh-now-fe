import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:management_app/data/repositories/transfer_transactions_repository.dart';
import 'package:management_app/data/responses/get_transfer_transactions_response.dart';
import 'package:management_app/presentation/screens/admin/transfer_transaction_details_screen.dart';
import 'package:management_app/presentation/widget/overview_transfer_transactions_item.dart';
import 'package:management_app/presentation/wrapper.dart';

class TransferTransactionsScreen extends StatefulWidget {
  const TransferTransactionsScreen({super.key});

  @override
  State<TransferTransactionsScreen> createState() =>
      _TransferTransactionsScreenState();
}

class _TransferTransactionsScreenState
    extends State<TransferTransactionsScreen> {
  final ValueNotifier<List<GetTransferTransactionsData>?> _transactions =
      ValueNotifier([]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(context);
  }

  Future<void> fetchData(BuildContext context) async {
    _transactions.value =
        await TransferTransactionRepository().getTransferTransactions(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: ValueListenableBuilder(
                  valueListenable: _transactions,
                  builder: (context, transactionsData, child) {
                    if (transactionsData == null) {
                      return Container(
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.red.shade200,
                              borderRadius: BorderRadius.circular(2)),
                          child: const Text(
                            "Internal server error",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ));
                    } else if (transactionsData.isEmpty) {
                      return Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Image.asset("assets/images/nodatafound.png"),
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        const Text(
                          "Transactions",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        ...List.generate(
                          transactionsData.length,
                          (index) => GestureDetector(
                            onTap: () async {
                              // do something
                              var refresh = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TransferTransactionDetailsScreen(
                                              restaurantId:
                                                  transactionsData[index]
                                                      .restaurantId)));
                              if (refresh != null && refresh) {
                                fetchData(context);
                              }
                            },
                            child: OveviewTransferTransactionItem(
                              transaction: transactionsData[index],
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Wrapper()));
              },
              child: const Icon(
                Icons.exit_to_app,
                size: 26,
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
