import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:management_app/core/services/image_storage_service.dart';
import 'package:management_app/core/utils/image.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/repositories/transfer_transactions_repository.dart';
import 'package:management_app/data/requests/confirm_transfer_money_request.dart';
import 'package:management_app/data/responses/get_transfer_transaction_details.dart';
import 'package:management_app/presentation/widget/transfer_transaction_item.dart';

class TransferTransactionDetailsScreen extends StatefulWidget {
  TransferTransactionDetailsScreen({super.key, required this.restaurantId});

  String restaurantId;

  @override
  State<TransferTransactionDetailsScreen> createState() =>
      _TransferTransactionDetailsScreenState();
}

class _TransferTransactionDetailsScreenState
    extends State<TransferTransactionDetailsScreen> {
  final ValueNotifier<GetTransferTransactionDetailsData?> _transaction =
      ValueNotifier(null);
  final ValueNotifier<XFile?> _proof = ValueNotifier(null);

  Future<void> fetchData(BuildContext context) async {
    _transaction.value = await TransferTransactionRepository()
        .getTransferTransactionDetails(widget.restaurantId, context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _transaction,
          builder: (context, transactionData, child) {
            if (transactionData == null) {
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
                          'Information',
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
                              'Restaurant name: ',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(49, 49, 49, 1),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Expanded(
                              child: Text(
                                transactionData.restaurantName,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 14.0,
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
                              'Total amount: ',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(49, 49, 49, 1),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Expanded(
                              child: Text(
                                NumberFormat.currency(
                                        locale: 'vi_VN', symbol: '₫')
                                    .format(transactionData.amount),
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(49, 49, 49, 1),
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Transactions',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(49, 49, 49, 1),
                              overflow: TextOverflow.ellipsis),
                        ),
                        ...List.generate(
                            transactionData.transactions.length,
                            (index) => TransferTransactionItem(
                                transaction:
                                    transactionData.transactions[index])),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2.4,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                child: ValueListenableBuilder(
                                    valueListenable: _proof,
                                    builder: (context, value, child) {
                                      return Image(
                                        image: value != null
                                            ? FileImage(File(value.path))
                                                as ImageProvider<Object>
                                            : const AssetImage(
                                                'assets/images/black.jpg'),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.4,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      );
                                    }),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  XFile? img = await pickAnImageFromGallery();
                                  if (img != null) {
                                    _proof.value = img;
                                  }
                                },
                                child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        2.4,
                                    width: MediaQuery.of(context).size.width,
                                    child: const Icon(
                                      CupertinoIcons.photo,
                                      color: Colors.white,
                                      size: 80,
                                    )),
                              )
                            ],
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
                              String? newImg;
                              if (_proof.value != null) {
                                newImg = await ImageStorageService
                                    .uploadIngredientImage(_proof.value);
                              } else {
                                showSnackBar(
                                    context, 'Please choose image to prove');
                                return;
                              }

                              if (newImg == null) {
                                showSnackBar(context, "An error has occured");
                                return;
                              }

                              var transactionIds = transactionData.transactions
                                  .map((e) => e.transactionId)
                                  .toList();
                              var request = ConfirmTransferMoneyRequest(
                                  transactionsIds: transactionIds,
                                  proofOfTransfer: newImg);
                              var result = await TransferTransactionRepository()
                                  .confirmTransfer(request, context);
                              if (result) {
                                Navigator.pop(context, true);
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
                            child: const Text('Confirm transfer'),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
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
                          onTap: () => Navigator.pop(context, false),
                          child: const Icon(
                            CupertinoIcons.arrow_left,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text(
                          'Transaction overview',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(49, 49, 49, 1),
                              overflow: TextOverflow.ellipsis),
                        ),
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
