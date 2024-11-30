import 'dart:ui';

import 'package:flutter/material.dart';

class StatusHelper {
  static Map<String, dynamic> getStatusInfo(int status) {
    switch (status) {
      case 0: // Init
        return {'text': 'Init', 'color': Color(0xFFADD8E6)}; // Xanh Lam Nhạt
      case 1: // CheckedOut
        return {
          'text': 'Checked Out',
          'color': Color(0xFF32CD32)
        }; // Xanh Lá Cây
      case 2: // Preparing
        return {'text': 'Preparing', 'color': Color(0xFFFFD700)}; // Vàng
      case 3: // ReadyToPickup
        return {'text': 'Ready To Pickup', 'color': Color(0xFFFFA500)}; // Cam
      case 4: // Delivering
        return {
          'text': 'Delivering',
          'color': Color(0xFF4169E1)
        }; // Xanh Lam Đậm
      case 5: // Arrived
        return {'text': 'Arrived', 'color': Color(0xFF9370DB)}; // Tím Nhạt
      case 6: // Success
        return {
          'text': 'Success',
          'color': Color(0xFF228B22)
        }; // Xanh Lá Cây Đậm
      case 7: // Failed
        return {'text': 'Failed', 'color': Color(0xFFFF0000)}; // Đỏ
      case 8: // Canceled
        return {'text': 'Canceled', 'color': Color(0xFF696969)}; // Xám Tối
      case 9: // Rejected
        return {'text': 'Rejected', 'color': Color(0xFF8B4513)}; // Nâu
      default:
        return {'text': 'Unknown Status', 'color': Colors.black}; // Mặc định
    }
  }
}
