import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:management_app/presentation/screens/profile_screen.dart';
import 'package:management_app/presentation/screens/restaurant/food_management_screen.dart';
import 'package:management_app/presentation/screens/restaurant/manage_order_screen.dart';
import 'package:management_app/presentation/screens/restaurant/restaurant_dashboard_screen.dart';
import 'package:management_app/presentation/widget/bottom_bar.dart';
import 'package:management_app/presentation/widget/bottom_bar_item.dart';
import 'package:management_app/presentation/widget/drawer.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<GlobalKey<BottomBarItemState>> bottomBarItemKeys = [];
  late List<dynamic> bottomBarItems = [];
  final ValueNotifier<int> _bottomIdx = ValueNotifier(0);

  void _activateBottomBarItem(int newIdx) {
    if (newIdx != _bottomIdx.value) {
      int temp = _bottomIdx.value;
      bottomBarItemKeys[temp].currentState!.unActive();
      _bottomIdx.value = newIdx;
    }
  }

  Widget _replaceScreenByBottomBarIndex(int idx) {
    if (idx == 0) {
      return const RestaurantDashboardScreen();
    } else if (idx == 1) {
      return const SizedBox(); // list notification
    } else if (idx == 2) {
      return  const FoodManagementScreen(); // management order
    }
    else if (idx == 3) {
      return  const ManageOrderScreen(); // management order
    }
    return ProfileScreen();
  }

  @override
  void initState() {
    super.initState();
    bottomBarItemKeys = List.generate(
          5,
          (index) => GlobalKey<BottomBarItemState>(),
        );
        bottomBarItems = [
          CupertinoIcons.home,
          CupertinoIcons.bell,
          'assets/images/wok_100_white.png',
          CupertinoIcons.layers_alt,
          CupertinoIcons.person
        ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: Stack(
          children: [
            ValueListenableBuilder( 
              valueListenable: _bottomIdx,
              builder: (context, value, child) {
                return _replaceScreenByBottomBarIndex(value);
              },
            ),
            // Bottom bar
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: BottomBar(
                  items: List.generate(5, (index) {
                    return BottomBarItem(
                      key: bottomBarItemKeys[index],
                      idx: index,
                      icon: bottomBarItems[index] is IconData
                          ? bottomBarItems[index]
                          : null,
                      imgPath: bottomBarItems[index] is! IconData
                          ? bottomBarItems[index]
                          : null,
                      isActivate: index == 0 ? true : false,
                      handleActive: _activateBottomBarItem,
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
