import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class UserSettingsView extends StatelessWidget {
  UserSettingsView({Key? key}) : super(key: key);
  User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: Theme.of(context).textTheme.headline5),
        elevation: 0,
      ),
      body: Column(
        children: [
          ListTile(
            contentPadding: context.paddingLow,
            leading: CircleAvatar(
              backgroundImage: _user?.photoURL != null
                  ? NetworkImage("${_user?.photoURL}")
                  : null,
              radius: context.dynamicHeight(0.05),
              child: _user?.photoURL == null
                  ? Image.asset("assets/icon/dummy_per.png")
                  : null,
            ),
            title: Text(_user?.displayName ?? "Null user name"),
            subtitle: Text(_user?.email ?? "null mail"),
          ),
          const ListTile(
            leading: Icon(Icons.account_box),
            title: Text("Account"),
            subtitle: Text("Security,change,email or number"),
          ),
          const ListTile(
            leading: Icon(Icons.chat_sharp),
            title: Text("Chats"),
            subtitle: Text("Theme wallpapers chat history"),
          ),
          const ListTile(
            leading: Icon(Icons.notification_important),
            title: Text("Notifications"),
            subtitle: Text("Message groups& call tones"),
          ),
          const ListTile(
            leading: Icon(Icons.sd_storage_outlined),
            title: Text("Storage and data"),
            subtitle: Text("Network usage auto-download"),
          ),
          const ListTile(
            leading: Icon(Icons.help),
            title: Text("Help"),
            subtitle: Text("Help correct us privacy policy"),
          ),
        ],
      ),
    );
  }
}
