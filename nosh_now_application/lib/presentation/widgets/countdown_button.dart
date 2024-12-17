import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nosh_now_application/core/constants/constants.dart';
import 'package:nosh_now_application/data/repositories/order_repository.dart';

class CountdownButton extends StatefulWidget {
  CountdownButton({required this.orderId, required this.onExecute});
  int orderId;
  final Future<void> Function(BuildContext) onExecute;
  @override
  _CountdownButtonState createState() => _CountdownButtonState();
}

class _CountdownButtonState extends State<CountdownButton> {
  late ValueNotifier<int> countdownValue;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    countdownValue = ValueNotifier<int>(Constants.cancelOrderTimeout);
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
    _timer?.cancel();
    countdownValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: countdownValue,
      builder: (context, value, child) {
        return TextButton(
          onPressed: () async {
            var result =
                await OrderRepository().cancelOrder(widget.orderId, context);
            if (result) {
              await widget.onExecute(context);
              _removeSelf();
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Cancel - ${value}s'),
        );
      },
    );
  }
}
