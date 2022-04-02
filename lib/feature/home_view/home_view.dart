import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
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

  String displayname = "Ruchan";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingNormal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome back, $displayname",
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
              const DefaultTabController(
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
              bookShelf(context),
              Text("New Arrivals",
                  style: Theme.of(context).textTheme.headline5),
              bookShelf(context),
            ],
          ),
        ),
      ),
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

  AppBar appBar(BuildContext context) {
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
            //Go to profile page
          },
          child: const CircleAvatar(
            backgroundImage: NetworkImage("https://picsum.photos/50"),
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