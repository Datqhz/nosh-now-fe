class ConfirmTransferMoneyRequest {
  List<int> transactionsIds;
  String proofOfTransfer;
  ConfirmTransferMoneyRequest(
      {required this.transactionsIds, required this.proofOfTransfer});

  Map<String, dynamic> toJson() {
    return {
      'transactionIds': transactionsIds.toList(),
      'proofOfTransfer': proofOfTransfer
    };
  }
}
