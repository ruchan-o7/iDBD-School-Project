import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project_ibdb/feature/book_detail/book_detail_view.dart';
import '../../core/custom/custom_divider.dart';
import '../../product/home_book_card/home_book_card.dart';
import '../login_screen/view/login_card_view.dart';
import 'edit_profile_cubit/editprofile_cubit.dart';
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
            body: body(context, state),
          );
        },
      ),
    );
  }

  Widget body(BuildContext context, ProfileviewState state) {
    return SizedBox(
      height: context.dynamicHeight(1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          tabbarItems(context),
          const Divider(),
          editProfileBTN(context),
          const Divider(),
          // const TabBar(tabs: [
          //   Tab(child: Icon(Icons.thumb_up_alt, color: Colors.black)),
          //   // Tab(child: Icon(Icons.book, color: Colors.black))
          // ]),
          bookContent(context, state)
        ],
      ),
    );
  }

  Row editProfileBTN(BuildContext context) {
    return Row(
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
                          listener: (context, state) {
                            if (state is Processing) {
                              showDialog(
                                  context: context,
                                  builder: (c) => AlertDialog(
                                        actions: [
                                          TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text("Ok"))
                                        ],
                                        title: const Text("Please reset your password from received e-mail"),
                                      ));
                            }
                          },
                          builder: (context, state) {
                            return buildSheet(context, state);
                          },
                        ),
                      );
                    });
              },
              child: Text(
                "Edit profile",
                style: Theme.of(context).textTheme.button,
              )),
        )),
      ],
    );
  }

  Row tabbarItems(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            CustomCircleAvatar(avatarUrl: FirebaseAuth.instance.currentUser?.photoURL),
            Text(FirebaseAuth.instance.currentUser?.displayName ?? "couldn't fetch user name")
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
    );
  }

  Widget buildSheet(BuildContext context, EditProfileState state) {
    if (state is ImageUploading) {
      return const Center(child: CircularProgressIndicator());
    }
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
                  context.read<EditProfileCubit>().selectImageFromGallery(context);
                },
                child: const Text("Change Profile Photo")),
            const Divider(),
            ListTile(
              leading: const Text("User name: "),
              title: TextFormField(
                initialValue: FirebaseAuth.instance.currentUser?.displayName,
              ),
            ),
            TextButton(
                onPressed: () {
                  context.read<EditProfileCubit>().resetPassword(context);
                },
                child: const Text("Reset password")),
            CustomDivider(context: context),
            SizedBox(
              width: context.dynamicWidth(0.6),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return alertForDeleteAccount(context);
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    Text("Delete my account", style: Theme.of(context).textTheme.button),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget alertForDeleteAccount(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteAccountCubit(),
      child: BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
        listener: (context, state) {},
        builder: (context, state) {
          return AlertDialog(
            title: const Text("Delete my account"),
            content: const Text("Are you sure to delete account?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: const Text("See you later"),
                              actions: [
                                const Center(child: CircularProgressIndicator()),
                                SizedBox(
                                  height: context.dynamicHeight(0.01),
                                )
                              ],
                            ));
                    await context.read<DeleteAccountCubit>().deleteAccount();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginCardView(),
                        ));
                  },
                  child: Text("Apply", style: Theme.of(context).textTheme.button))
            ],
          );
        },
      ),
    );
  }

  Expanded bookContent(BuildContext context, ProfileviewState state) {
    return Expanded(
      child: state is Loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : context.read<ProfileviewCubit>().likedBooks?.length == 0
              ? const Center(child: Text("There is no owned books"))
              : GridView.builder(
                  itemCount: context.read<ProfileviewCubit>().likedBooks?.length,
                  controller: context.read<ProfileviewCubit>().scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (c, i) {
                    var _model = context.read<ProfileviewCubit>().likedBooks?.reversed.toList()[i];
                    return InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BookDetail(bookModel: _model),
                      )),
                      child: CustomCard(
                        context: context,
                        model: _model?.volumeInfo,
                      ),
                    );
                  }),
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
