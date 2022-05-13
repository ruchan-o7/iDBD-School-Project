import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/feature/forget-pass-view/confirm-mail/cubit/confirmemail_cubit.dart';
import 'package:school_project_ibdb/feature/login_screen/view/login_card_view.dart';

class ConfirmEmail extends StatelessWidget {
  ConfirmEmail({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _codeNode = FocusNode();
  final _passNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ConfirmemailCubit(
            controller: _codeController,
            passwordController: _passwordController,
            formKey: _formKey,
            codeNode: _codeNode,
            passNode: _passNode),
        child: BlocConsumer<ConfirmemailCubit, ConfirmemailState>(
          listener: (context, state) {},
          builder: (context, state) {
            return scaffold(context);
          },
        ));
  }

  Scaffold scaffold(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Confirm password")),
        body: Center(
          child: Card(
            child: SizedBox(
              height: context.dynamicHeight(0.3),
              width: context.dynamicWidth(0.7),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: context.paddingLow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        focusNode: _codeNode,
                        controller: _codeController,
                        decoration: const InputDecoration(border: UnderlineInputBorder(), hintText: "code"),
                      ),
                      SizedBox(height: context.dynamicHeight(0.01)),
                      TextFormField(
                        focusNode: _passNode,
                        controller: _passwordController,
                        decoration:
                            const InputDecoration(border: UnderlineInputBorder(), hintText: "new password"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_codeController.text != "" && _passwordController.text != "") {
                            final _isOkay = await context.read<ConfirmemailCubit>().changePass(context,
                                code: _codeController.text, newPassword: _passwordController.text);
                            if (_isOkay) {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => const LoginCardView(),
                              ));
                            }
                          }
                        },
                        child: Text("Confirm", style: Theme.of(context).textTheme.button),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
