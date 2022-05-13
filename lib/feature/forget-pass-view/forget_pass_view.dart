import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/feature/forget-pass-view/cubit/forgetpass_cubit.dart';
import 'package:school_project_ibdb/feature/login_screen/view/login_card_view.dart';
import 'package:school_project_ibdb/product/utils/validator/validator.dart';

class ForgetPassView extends StatelessWidget {
  ForgetPassView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ForgetpassCubit(controller: _controller, formKey: _formKey, node: _node),
        child: BlocConsumer<ForgetpassCubit, ForgetpassState>(
          listener: (context, state) {
            if (state is Processing) {
              showDialog(
                  context: context,
                  builder: (c) => AlertDialog(
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => const LoginCardView(),
                                ));
                              },
                              child: Text("Ok", style: Theme.of(context).textTheme.button))
                        ],
                        title: const Text("Please reset your password from received e-mail"),
                      ));
            }
          },
          builder: (context, state) {
            return scaffold(context);
          },
        ));
  }

  Scaffold scaffold(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Forget Password?")),
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
                        focusNode: _node,
                        keyboardType: TextInputType.emailAddress,
                        controller: _controller,
                        validator: (v) => Validator().validateEmail(email: v),
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(), hintText: "example@gmail.com"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_controller.text != null && _controller.text != "") {
                            var isOkay = await context
                                .read<ForgetpassCubit>()
                                .sendResetRequest(_controller.text, context);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text("Please fill the area")));
                          }
                        },
                        child: Text("Send e-mail", style: Theme.of(context).textTheme.button),
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
