import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/streams/change_stream.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/data/providers/hub/hub_provider.dart';
import 'package:management_app/data/providers/user_state_provider.dart';
import 'package:management_app/presentation/screens/change_password_screen.dart';
import 'package:management_app/presentation/screens/modify_profile_screen.dart';
import 'package:management_app/presentation/wrapper.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  ChangeStream stream = ChangeStream();

  Widget _optionItem(
      String option, Color color, VoidCallback handle, bool isSignOut) {
    return GestureDetector(
      onTap: handle,
      child: Container(
        padding: const EdgeInsets.only(bottom: 12, top: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromRGBO(195, 195, 195, 1),
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              option,
              maxLines: 1,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: color,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (!isSignOut) ...[
              const Expanded(child: SizedBox()),
              const Icon(
                CupertinoIcons.chevron_right,
                color: Colors.black,
                size: 16,
              )
            ]
          ],
        ),
      ),
    );
  }

  List<Widget> _listOptionByRole(context) {
    return [
      _optionItem('Update infomation', Colors.black, () {
        if (GlobalVariable.scope != 'Restaurant' &&
            GlobalVariable.scope != 'Admin') {
          showSnackBar(
              context, "You don't have permission to access this feature");
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ModifyProfileScreen(
              stream: stream,
            ),
          ),
        );
      }, false),
      _optionItem(
        'Change password',
        Colors.black,
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChangePasswordScreen(),
            ),
          );
        },
        false,
      ),
      _optionItem(
        'Sign out',
        Colors.red,
        () async {
          await Provider.of<HubProvider>(context, listen: false)
              .closeConnection();
          Provider.of<UserStateProvider>(context, listen: false).logout();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Wrapper()));
        },
        true,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromRGBO(1, 61, 39, 1),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: StreamBuilder<void>(
                stream: stream.stream,
                builder: (context, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              GlobalVariable.profile!.displayName,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: SizedBox(
                          height: 100,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    borderRadius: BorderRadius.circular(50)),
                                child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        GlobalVariable.profile!.avatar)),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 3,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Icon(
                                    CupertinoIcons.pencil,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My account',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ..._listOptionByRole(context)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
