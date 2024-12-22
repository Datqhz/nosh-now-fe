import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/data/providers/hub/hub_provider.dart';
import 'package:management_app/data/repositories/employee_repository.dart';
import 'package:management_app/data/repositories/restaurant_repository.dart';
import 'package:management_app/presentation/main_screen.dart';
import 'package:management_app/presentation/screens/admin/admin_view.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> getProfile(BuildContext context) async {
    final scope = GlobalVariable.scope;
    if (scope == 'ServiceStaff' || scope == 'Chef') {
      await EmployeeRepository().getProfile(context);
    } else if (scope == 'Restaurant') {
      await RestaurantRepository().getProfile(context);
    }
    Provider.of<HubProvider>(context, listen: false).connectToNotifyHub();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: getProfile(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => GlobalVariable.scope == "Admin"
                      ? const AdminView()
                      : MainScreen(),
                ),
              );
            });
          }
          return const Center(
            child: SpinKitCircle(
              color: Colors.white,
              size: 100,
            ),
          );
        },
      ),
    );
  }
}
