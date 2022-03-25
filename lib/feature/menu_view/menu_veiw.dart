import 'package:flutter/material.dart';
import '../../core/constants/logo_path.dart';
import '../../core/enum/padding_values.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: PaddingValues.min.rawValues(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.2,
              child: Image.asset(LogoPaths.transparent),
            ),
            const Divider(),
            const Card(
                child: ListTile(
                    leading: Icon(Icons.search), title: Text("Arama"))),
            const Card(
                child: ListTile(
                    leading: Icon(Icons.bookmark), title: Text("Keşfet"))),
            const Card(
                child: ListTile(
                    leading: Icon(Icons.category), title: Text("Kategoriler"))),
            const Card(
                child: ListTile(
                    leading: Icon(Icons.settings), title: Text("Ayarlar"))),
            const Card(
                child:
                    ListTile(leading: Icon(Icons.help), title: Text("Yardım"))),
            const Card(
                child: ListTile(
                    leading: Icon(Icons.leave_bags_at_home),
                    title: Text("Çıkış Yap"))),
          ],
        ),
      ),
    );
  }
}
