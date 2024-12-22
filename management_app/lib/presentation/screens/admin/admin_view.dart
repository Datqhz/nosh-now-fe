import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:management_app/presentation/screens/admin/admin_dashboard_screen.dart';
import 'package:management_app/presentation/screens/admin/category_management_screen.dart';
import 'package:management_app/presentation/screens/admin/transfer_transactions_screen.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  Widget _bottomNavigation(int index) {
    if (index == 0) {
      return const AdminDashboardScreen();
    } else if (index == 1) {
      return const CategoryManagementScreen();
    } else {
      return const TransferTransactionsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, value, child) {
            return _bottomNavigation(value);
          },
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _currentIndex,
        builder: (context, index, child) {
          return BottomNavigationBar(
            backgroundColor: Colors.black,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_stack_3d_down_right),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.money_dollar),
                label: 'Transaction',
              ),
            ],
            currentIndex: index,
            selectedItemColor: Colors.amber[800],
            unselectedItemColor: Colors.white,
            onTap: (newIdx) {
              _currentIndex.value = newIdx;
            },
          );
        },
      ),
    );
  }
}
