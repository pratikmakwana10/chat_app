import 'package:chat_app/authentication/auth_services.dart';
import 'package:chat_app/pages/settings.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logOut() {
    //get auth instance and sign out
    AuthService().signOut();
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //Logo

              DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.message,
                      size: 30, color: Theme.of(context).colorScheme.primary)),
              // home list Tile(),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  title: const Text('H O M E'),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ), //setting list Tile(),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  title: const Text('S E T T I N G S'),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Settings()));
                  },
                ),
              ),
            ],
          ),

          //logout list Tile(),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0, left: 15.0),
            child: ListTile(
              title: const Text('L O G O U T'),
              leading: const Icon(Icons.logout),
              onTap: () {
                AuthService().signOut();
                //  logOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
