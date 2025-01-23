import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/messageHepler.dart';
import 'package:restaurant_app/provider/auth_provider.dart';
import 'package:restaurant_app/view/profile/widget/profile_item.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: Consumer<AuthProvider>(builder: (context, user, child) {
        if (user.loading == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Image.asset(
                      'assets/icons/man.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text("${user.user['username']}"),
                Text("${user.user['phoneNumber']}"),
                Text("${user.user['email']}"),
                SizedBox(height: 20),
                ProfileItem(
                  title: "Edit Profile",
                  icon: Icons.edit,
                  onTap: () {
                    MessageHepler.showMessage(false, "Under Develop");
                  },
                ),
                ProfileItem(
                  title: "Edit Password",
                  icon: Icons.security,
                  onTap: () {
                    MessageHepler.showMessage(false, "Under Develop");
                  },
                ),
                ProfileItem(
                  title: "Change Langauge",
                  icon: Icons.language,
                  onTap: () {
                    MessageHepler.showMessage(false, "Under Develop");
                  },
                ),
                ProfileItem(
                  title: "Exit",
                  icon: Icons.exit_to_app,
                  onTap: () {
                    user.Exit();
                  },
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
