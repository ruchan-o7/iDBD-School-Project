import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/feature/help_view/help_view.dart';
import 'package:school_project_ibdb/feature/publisher_view/publisher_view.dart';
import 'package:school_project_ibdb/feature/statistic_view/statistic_view.dart';
import 'package:school_project_ibdb/product/circle_avatar/custom_circle_avatar.dart';
import '../about_view/about_view.dart';
import '../profile_view/profile_view.dart';
import '../../product/book_categories/categories.dart';

import '../../product/drawer_item_custom/custom_drawer_item.dart';
import '../../product/home_book_card/home_book_card.dart';
import 'cubit/home_view_cubit.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key, required this.goToProfilePageFunc}) : super(key: key);
  VoidCallback goToProfilePageFunc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeViewCubit>(
      create: (context) => HomeViewCubit(),
      child: BlocConsumer<HomeViewCubit, HomeViewState>(
        listener: (context, state) {},
        builder: (context, state) {
          return DefaultTabController(
            length: Categories.instance.getLength ?? 0,
            child: Scaffold(
              appBar: appBar(context),
              drawer: drawer(context),
              body: body(context),
            ),
          );
        },
      ),
    );
  }

  Drawer drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: SizedBox(
                width: context.dynamicWidth(0.3),
                child: CustomCircleAvatar(avatarUrl: FirebaseAuth.instance.currentUser?.photoURL),
              )),
              Text("${FirebaseAuth.instance.currentUser?.displayName?.toUpperCase()}")
            ],
          ),
          CustomDrawerItem(
              leadingIcon: Icons.person,
              text: "Profile",
              onTapFunc: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfileView(),
                ));
              }),
          const Divider(),
          CustomDrawerItem(
            leadingIcon: Icons.stacked_bar_chart_sharp,
            text: "Statistics",
            onTapFunc: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const StatisticView(),
              ));
            },
          ),
          const Divider(),
          context.read<HomeViewCubit>().isUserPublisher
              ? CustomDrawerItem(
                  leadingIcon: Icons.book,
                  text: "Publisher Page",
                  onTapFunc: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => const PublisherView()));
                  })
              : const SizedBox(),
          context.read<HomeViewCubit>().isUserPublisher ? const Divider() : const SizedBox(),
          CustomDrawerItem(
              leadingIcon: Icons.sd_card,
              text: "About",
              onTapFunc: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutView()));
              }),
          const Divider(),
          CustomDrawerItem(
              leadingIcon: Icons.help,
              text: "Help",
              onTapFunc: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpView()));
              }),
          const Divider(),
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

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      controller: context.read<HomeViewCubit>().scrollController,
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
            TabBar(
              tabs: Categories.instance.toTab() ?? [],
              isScrollable: true,
              indicatorColor: Theme.of(context).indicatorColor,
              indicatorWeight: 3,
              onTap: (categorieName) {
                context
                    .read<HomeViewCubit>()
                    .getBooksFromCategories(Categories.instance.getCategorieList?[categorieName] ?? "");
              },
            ),
            SizedBox(
              height: context.dynamicHeight(0.28),
              child: ListView.separated(
                separatorBuilder: (context, index) => const VerticalDivider(thickness: 2),
                scrollDirection: Axis.horizontal,
                itemCount: context.read<HomeViewCubit>().categorieBooks?.items?.length ?? 0,
                // itemCount: context.read<HomeViewCubit>().categorieBooks?.items?.length,
                itemBuilder: (BuildContext context, int index) {
                  final _tempModel = context.read<HomeViewCubit>().categorieBooks?.items?[index];
                  if (context.read<HomeViewCubit>().loadState == IsLoading.yes) {
                    return SizedBox(
                        width: context.dynamicWidth(0.4),
                        child: const Center(child: CircularProgressIndicator()));
                  }
                  return InkWell(
                    onTap: () => context.read<HomeViewCubit>().goToBook(context, _tempModel),
                    child: HomeBookCard(
                      model: _tempModel?.volumeInfo,
                      context: context,
                    ),
                  );
                },
              ),
            ),
            Text("Recommended", style: Theme.of(context).textTheme.headline5),
            ElevatedButton(
                onPressed: () {
                  context.read<HomeViewCubit>().getRecommendedBooks();
                },
                child: Text("Get recommended")),
            recommendedShelf(context),
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
            },
            child: CustomCircleAvatar(
              avatarUrl: FirebaseAuth.instance.currentUser?.photoURL,
              size: context.dynamicWidth(0.05),
            ),
          ),
        ),
        SizedBox(width: context.dynamicWidth(0.05))
      ],
    );
  }

  Widget recommendedShelf(BuildContext context) {
    return GridView(
      controller: context.read<HomeViewCubit>().scrollController,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9 / 11),
      shrinkWrap: true,
      children: context
              .read<HomeViewCubit>()
              .recommendedBooks
              ?.items
              ?.map((e) => InkWell(
                    onTap: () => context.read<HomeViewCubit>().goToBook(context, e),
                    child: HomeBookCard(
                      context: context,
                      model: e.volumeInfo,
                    ),
                  ))
              .toList() ??
          [],
    );
  }
}
