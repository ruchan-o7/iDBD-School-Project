import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project_ibdb/core/custom/custom_divider.dart';
import 'package:school_project_ibdb/feature/profile_view/edit_profile_cubit/editprofile_cubit.dart';
import 'cubit/profileview_cubit.dart';
import '../../product/book_card/book_card.dart';
import '../../product/circle_avatar/custom_circle_avatar.dart';
import 'package:kartal/kartal.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  final userNameController = TextEditingController();

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
          const Divider(),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: context.horizontalPaddingHigh,
                child: ElevatedButton(
                    onPressed: () {
                      showBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                          context: context,
                          builder: (context) {
                            return BlocProvider(
                              create: (context) => EditProfileCubit(userNameController: userNameController),
                              child: BlocConsumer<EditProfileCubit, EditProfileState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  return buildSheet(context);
                                },
                              ),
                            );
                          });
                    },
                    child: const Text("Edit profile")),
              )),
            ],
          ),
          const Divider(),
          const TabBar(tabs: [
            Tab(child: Icon(Icons.thumb_up_alt, color: Colors.black)),
            Tab(child: Icon(Icons.book, color: Colors.black))
          ]),
          bookContent(context)
        ],
      ),
    );
  }

  Widget buildSheet(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidth(1),
      height: context.dynamicHeight(0.85),
      child: Form(
        child: Column(
          children: [
            SizedBox(height: context.dynamicHeight(0.01)),
            CustomDivider(context: context),
            SizedBox(height: context.dynamicHeight(0.1)),
            CustomCircleAvatar(
                avatarUrl: FirebaseAuth.instance.currentUser?.photoURL, size: context.dynamicHeight(0.07)),
            TextButton(
                onPressed: () {
                  context.read<EditProfileCubit>().selectImageFromGallery();
                },
                child: Text(
                  "Change Profile Photo",
                  style: Theme.of(context).textTheme.button?.copyWith(color: Colors.white),
                )),
            const Divider(),
            ListTile(
              leading: const Text("User name: "),
              title: TextFormField(
                initialValue: FirebaseAuth.instance.currentUser?.displayName,
              ),
            ),
            ListTile(
              leading: const Text("Password: "),
              title: TextFormField(),
            ),
            CustomDivider(context: context),
            SizedBox(
              width: context.dynamicWidth(0.6),
              child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.delete),
                      Text("Delete my account"),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Expanded bookContent(BuildContext context) {
    return Expanded(
      child: TabBarView(children: [
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return BookCard(
                bookModel: context.read<ProfileviewCubit>().likedBooks?[index],
              );
            },
            itemCount: context.read<ProfileviewCubit>().likedBooks?.length),
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return BookCard(
                bookModel: context.read<ProfileviewCubit>().ownedBooks?[index],
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
