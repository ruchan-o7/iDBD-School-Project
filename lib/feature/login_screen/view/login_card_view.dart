import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/feature/login_screen/view/login_card_view_cubit.dart';

import '../../search_view/search_view.dart';

class LoginCardView extends StatelessWidget {
  LoginCardView({Key? key}) : super(key: key);
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final focusEmail = FocusNode();
  final focusPassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCardCubit(
        emailController: emailController,
        focusEmail: focusEmail,
        focusPassword: focusPassword,
        formKey: formkey,
        passwordController: passwordController,
      ),
      child: BlocConsumer<LoginCardCubit, LoginCardState>(
          builder: (context, state) {
            if (state is LoadingFirebaseState) {
              return progressBuilder();
            } else if (state is LoadedFirebaseState) {
              return scaffoldBuild(context);
            } else if (state is LoginSucces) {
              return const SearchView();
            } else {
              return const Scaffold();
            }
          },
          listener: (context, state) {}),
    );
  }

  Scaffold scaffoldBuild(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: context.horizontalPaddingMedium,
              child: CardStruct(context),
            ),
          ],
        ),
      ]),
    );
  }

  Card CardStruct(BuildContext context) {
    return Card(
      color: Colors.green[100],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.dynamicWidth(0.05))),
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
              Text("Log in", style: Theme.of(context).textTheme.headline3),
              Text("Welcome", style: Theme.of(context).textTheme.headline5),
              SizedBox(
                height: context.dynamicHeight(0.04),
              ),
              mailTextField(context),
              SizedBox(
                height: context.dynamicHeight(0.02),
              ),
              passTextField(context),
              ForgetPassBTN(context),
              LogInBTN(),
              const Divider(thickness: 2),
              SignUpBTN(context),
              SizedBox(
                height: context.dynamicHeight(0.02),
              ),
            ],
          ),
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

  Row LogInBTN() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const StadiumBorder()),
            ),
            onPressed: () {},
            child: const Text("Log in"),
          ),
        ),
      ],
    );
  }

  Row SignUpBTN(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.lightGreen[200]!),
              shape: MaterialStateProperty.all(const StadiumBorder()),
            ),
            onPressed: () {
              context.read<LoginCardCubit>().goToSignUpPage(context);
            },
            child: const Text("Sign Up"),
          ),
        ),
      ],
    );
  }

  Scaffold progressBuilder() {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
