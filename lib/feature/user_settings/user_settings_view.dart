import 'package:flutter/material.dart';

class UserSettingsView extends StatelessWidget {
  const UserSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(
        children: const [
          SizedBox(
            height: 10,
          ),
          Card(
            margin: EdgeInsets.all(1),
            elevation: 20,
            // color: Colors.white60,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    "https://static.daktilo.com/sites/415/uploads/2021/02/03/2-geyik.jpg"),
                backgroundColor: Colors.transparent,
              ),
              title: Text("İbrahim Geyik"),
              subtitle: Text("Flutter Dart"),
              trailing: Icon(Icons.qr_code),
            ),
          ),
          Card(
            margin: EdgeInsets.all(1),
            elevation: 20,
            // color: Colors.white60,
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.account_box),
                radius: 15,
              ),
              title: Text("Account"),
              subtitle: Text("Privacy,security,change,email or number"),
            ),
          ),
          Card(
            margin: EdgeInsets.all(1),
            elevation: 20,
            // color: Colors.white60,
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.chat_sharp),
                radius: 15,
              ),
              title: Text("Chats"),
              subtitle: Text("Theme wallpapers chat history"),
            ),
          ),
          Card(
            margin: EdgeInsets.all(1),
            elevation: 20,
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.notification_important),
                radius: 15,
              ),
              title: Text("Notifications"),
              subtitle: Text("Message groups& call tones"),
            ),
          ),
          Card(
            margin: EdgeInsets.all(1),
            elevation: 20,
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.sd_storage_outlined),
                radius: 15,
              ),
              title: Text("Storage and data"),
              subtitle: Text("Network usage auto-download"),
            ),
          ),
          Card(
            margin: EdgeInsets.all(1),
            elevation: 20,
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.help),
                radius: 15,
              ),
              title: Text("Help"),
              subtitle: Text("Help correct us privacy policy"),
            ),
          ),
          Card(
            margin: EdgeInsets.all(1),
            elevation: 20,
            child: ListTile(
              title: Text("               Invite a friend"),
            ),
          ),
        ],
      )),
    );
  }
}
