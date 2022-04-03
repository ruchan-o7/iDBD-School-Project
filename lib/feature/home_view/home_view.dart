import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/feature/user_settings/user_settings_view.dart';
import 'package:school_project_ibdb/product/bottom_nav_bar/bottom_nav_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _switch = true;
  Color backColor = Colors.white;
  void _changeSwitch(bool? val) {
    setState(() {
      _switch = val ?? true;
    });
  }

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: appBarBuild(context, currentUser),
      body: fullBodyBuild(context),
    );
  }

  SingleChildScrollView fullBodyBuild(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: context.paddingNormal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back, ${currentUser?.displayName}",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
            Text("What do yo want to read to today? ",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            categoriesTab(),
            bookShelf(context),
            Text("New Arrivals", style: Theme.of(context).textTheme.headline5),
            bookShelf(context),
          ],
        ),
      ),
    );
  }

  DefaultTabController categoriesTab() {
    return const DefaultTabController(
        length: 5,
        child: TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.black54,
          indicatorColor: Colors.red,
          labelColor: Colors.black,
          tabs: [
            Text("Novel"),
            Text("Self-Love"),
            Text("Science"),
            Text("Romance"),
            Text("Crime"),
          ],
        ));
  }

  SizedBox bookShelf(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.4),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return SizedBox(
            height: context.dynamicHeight(0.3),
            child: Padding(
              padding: context.paddingLow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: context.dynamicHeight(0.015)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://picsum.photos/150/200",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: context.dynamicHeight(0.015)),
                  Text("Kitap Adı"),
                  Text(
                    "Yazar",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
          );
        },
        itemCount: 5,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  AppBar appBarBuild(BuildContext context, User? currentUser) {
    return AppBar(
      elevation: 0,
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      actions: [
        Switch(
          value: _switch,
          onChanged: _changeSwitch,
          activeColor: Colors.grey[400],
          inactiveThumbColor: Colors.black87,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserSettingsView(),
                ));
            //Go to profile page
          },
          child: CircleAvatar(
            backgroundImage: currentUser?.photoURL != null
                ? NetworkImage("${currentUser?.photoURL}")
                : null,
            child: currentUser?.photoURL == null
                ? Image.asset("assets/icon/dummy_per.png")
                : null,
          ),
        ),
        SizedBox(width: context.dynamicWidth(0.05))
      ],
    );
  }
}












/**************************************************************** */
  // TextField(
              //     decoration: InputDecoration(
              //   border: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(15),
              //   ),
              //   prefixIcon: const Icon(Icons.search),
              //   hintText: "Search",
              //   suffixIcon: const Icon(Icons.mic),
              // )), TODO: This search will remove to search page
              // ListView.builder(
              //   itemBuilder: (context, index) {
              //     return PageView.builder(
              //       itemBuilder: (context, index) {},
              //     );
              //   },
              // )