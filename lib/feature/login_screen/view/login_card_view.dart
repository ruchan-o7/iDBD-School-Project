import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/core/custom/circle_color_widget.dart';
import 'package:school_project_ibdb/feature/login_screen/view/login_card_view_cubit.dart';
import 'package:school_project_ibdb/feature/sign_up/sign_up_view.dart';

import '../../search_view/search_view.dart';

class LoginCardView extends StatelessWidget {
  const LoginCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCardCubit>(
      create: (context) => LoginCardCubit(),
      child: BlocConsumer<LoginCardCubit, LoginCardState>(
          builder: (context, state) {
            if (state is LoadingFirebaseState) {
              return progressBuilder();
            } else if (state is LoadedFirebaseState) {
              return logInStruct(context);
            } else if (state is LoginSucces) {
              return const SearchView();
            } else {
              return const Scaffold();
            }
          },
          listener: (context, state) {}),
    );
  }

  Scaffold blurScaffold() {
    return Scaffold(
      body: ClipRRect(
        child: Stack(
          children: [
            Card(
              child: Container(
                height: 200,
                width: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("https://picsum.photos/200"))),
              ),
            ),
            Container(
              height: 220,
              width: 150,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Scaffold logInStruct(BuildContext context) {
    return Scaffold(
      body: ClipRRect(
        child: Stack(children: [
          Positioned(
            bottom: context.dynamicHeight(0.15),
            child: CircleShape(shapeColor: Colors.green),
          ),
          Positioned(
              child: CircleShape(shapeColor: Colors.blue),
              left: context.dynamicWidth(0.3)),
          dataStruct(context),
        ]),
      ),
    );
  }

  Container dataStruct(BuildContext context) {
    return Container(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: context.horizontalPaddingMedium,
              child: Card(
                color: Colors.green[100],
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(context.dynamicWidth(0.05))),
                child: Padding(
                  padding: context.horizontalPaddingNormal,
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: context.dynamicHeight(0.02),
                        ),
                        Text("Log in",
                            style: Theme.of(context).textTheme.headline3),
                        Text("Welcome",
                            style: Theme.of(context).textTheme.headline5),
                        SizedBox(
                          height: context.dynamicHeight(0.04),
                        ),
                        mailTextField(context),
                        SizedBox(
                          height: context.dynamicHeight(0.02),
                        ),
                        passTextField(context),
                        ForgetPassBTN(context),
                        LogInBTN(context),
                        const Divider(thickness: 2),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.lightGreen[200]!),
                                  shape: MaterialStateProperty.all(
                                      const StadiumBorder()),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUpView(),
                                      ));
                                },
                                child: const Text("Sign Up"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: context.dynamicHeight(0.02),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField mailTextField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail_outline),
          labelText: "e-mail",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.dynamicWidth(0.05)))),
    );
  }

  TextFormField passTextField(BuildContext context) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outline),
          labelText: "password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.dynamicWidth(0.05)))),
    );
  }

  Row ForgetPassBTN(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            "Forget password",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        )
      ],
    );
  }

  Row LogInBTN(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const StadiumBorder()),
            ),
            onPressed: () {},
            child: Text(
              "Log in",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Scaffold progressBuilder() {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
