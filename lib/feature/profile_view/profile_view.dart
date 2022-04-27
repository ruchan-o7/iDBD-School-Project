import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project_ibdb/feature/profile_view/cubit/profileview_cubit.dart';
import 'package:school_project_ibdb/product/book_card/book_card.dart';
import 'package:school_project_ibdb/product/circle_avatar/custom_circle_avatar.dart';
import 'package:kartal/kartal.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileviewCubit(),
      child: BlocConsumer<ProfileviewCubit, ProfileviewState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(context),
            body: body(context),
          );
        },
      ),
    );
  }

  DefaultTabController body(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CustomCircleAvatar(avatarUrl: FirebaseAuth.instance.currentUser?.photoURL),
                  Text(FirebaseAuth.instance.currentUser?.displayName ?? "coultn't fetch user name")
                ],
              ),
              Column(
                children: [
                  Text(context.read<ProfileviewCubit>().currUser?.likedBooks?.length.toString() ?? "0"),
                  Text("Liked", style: Theme.of(context).textTheme.bodyLarge)
                ],
              ),
              Column(
                children: [
                  Text(context.read<ProfileviewCubit>().currUser?.ownedBooks?.length.toString() ?? "0"),
                  Text("Owned", style: Theme.of(context).textTheme.bodyLarge)
                ],
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: context.horizontalPaddingHigh,
                child: ElevatedButton(
                    onPressed: () {
                      showBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              width: context.dynamicWidth(1),
                              height: context.dynamicHeight(0.85),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: context.dynamicHeight(0.1),
                                  ),
                                  CustomCircleAvatar(avatarUrl: FirebaseAuth.instance.currentUser?.photoURL),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Change Profile Photo",
                                        style:
                                            Theme.of(context).textTheme.button?.copyWith(color: Colors.white),
                                      )),
                                  Divider(),
                                  ListTile(
                                    leading: Text("Name: "),
                                    title: Text("    nbanmasd"),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: Text("Edit profile")),
              )),
            ],
          ),
          Divider(),
          const TabBar(tabs: [
            Tab(child: Icon(Icons.thumb_up_alt, color: Colors.black)),
            Tab(child: Icon(Icons.book, color: Colors.black))
          ]),
          bookContent(context)
        ],
      ),
    );
  }

  Expanded bookContent(BuildContext context) {
    return Expanded(
      child: TabBarView(children: [
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return BookCard(
                isComeFromProfile: true,
                bookModel: context.read<ProfileviewCubit>().likedBooks?[index],
              );
            },
            itemCount: context.read<ProfileviewCubit>().likedBooks?.length),
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return BookCard(
                bookModel: context.read<ProfileviewCubit>().ownedBooks?[index],
                isComeFromProfile: true,
              );
            },
            itemCount: context.read<ProfileviewCubit>().ownedBooks?.length),
      ]),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text("📕 ${FirebaseAuth.instance.currentUser?.displayName}",
          style: Theme.of(context).textTheme.headline5),
    );
  }
}
