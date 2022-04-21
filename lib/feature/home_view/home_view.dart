import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../product/drawer_item_custom/custom_drawer_item.dart';
import 'cubit/home_view_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeViewCubit>(
      create: (context) => HomeViewCubit(),
      child: BlocConsumer<HomeViewCubit, HomeViewState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(context),
            drawer: drawer(context),
            body: body(context),
          );
        },
      ),
    );
  }

  // Drawer drawer(BuildContext context, User? model) {
  Drawer drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: SizedBox(
                width: context.dynamicWidth(0.3),
                child: CircleAvatar(
                  backgroundImage: FirebaseAuth.instance.currentUser?.photoURL != null
                      ? NetworkImage("${FirebaseAuth.instance.currentUser?.photoURL}")
                      : null,
                  child: FirebaseAuth.instance.currentUser?.photoURL == null
                      ? Image.asset("assets/icon/dummy_per.png")
                      : null,
                ),
              )),
              Text("${FirebaseAuth.instance.currentUser?.displayName?.toUpperCase()}")
            ],
          ),
          CustomDrawerItem(leadingIcon: Icons.account_box, text: "Change user name", onTapFunc: () {}),
          CustomDrawerItem(leadingIcon: (Icons.lock), text: "Change password", onTapFunc: () {}),
          CustomDrawerItem(leadingIcon: Icons.mail, text: "Change e-mail", onTapFunc: () {}),
          CustomDrawerItem(leadingIcon: Icons.sd_card, text: "Delete account", onTapFunc: () {}),
          CustomDrawerItem(leadingIcon: Icons.help, text: "Help", onTapFunc: () {}),
          CustomDrawerItem(
            leadingIcon: Icons.logout,
            text: "Log out",
            onTapFunc: () async {
              await context.read<HomeViewCubit>().logOut(context);
            },
          )
        ],
      ),
    );
  }

  SingleChildScrollView body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: context.paddingNormal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back, ${FirebaseAuth.instance.currentUser?.displayName}",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
            ),
            Text("What do yo want to read to today? ",
                style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            DefaultTabController(
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
                )),
            SizedBox(
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
            ),
            Text("New Arrivals", style: Theme.of(context).textTheme.headline5),
            bookShelf(context),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: [
        Builder(
          builder: (context) => InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
              // context.read<NavbarCubit>().selectedIndex = 3;
              // context.read<HomeViewCubit>().goToPage(context, UserSettingsView());
            },
            child: Container(
              child: CircleAvatar(
                backgroundImage: FirebaseAuth.instance.currentUser?.photoURL != null
                    ? NetworkImage("${FirebaseAuth.instance.currentUser?.photoURL}")
                    : null,
                child: FirebaseAuth.instance.currentUser?.photoURL == null
                    ? Image.asset("assets/icon/dummy_per.png")
                    : null,
              ),
            ),
          ),
        ),
        SizedBox(width: context.dynamicWidth(0.05))
      ],
    );
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