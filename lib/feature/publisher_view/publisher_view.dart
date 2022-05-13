import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'cubit/publisher_cubit.dart';
import 'delete_request/delete_req_view.dart';

import '../../product/circle_avatar/custom_circle_avatar.dart';
import 'add_book_view/add_book.dart';
import 'publisher_reports/publisher_reports_view.dart';

class PublisherView extends StatelessWidget {
  const PublisherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PublisherCubit(context),
      child: BlocConsumer<PublisherCubit, PublisherState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Publisher Page"),
                centerTitle: true,
              ),
              body: state is DataFetched
                  ? bodyWithData(context, state)
                  : const Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }

  Widget bodyWithData(BuildContext context, DataFetched state) {
    return Padding(
      padding: context.paddingNormal,
      child: Column(
        children: [
          profileDetail(context, state),
          Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddBookView(),
                      ));
                },
                child: const Card(
                  child: ListTile(
                    leading: Icon(Icons.add),
                    title: Text("Book add request"),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  final _user = context.read<PublisherCubit>().currentUser;
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => DeleteReqView(currentUser: _user)));
                },
                child: const Card(
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text("Delete book request"),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  final _user = context.read<PublisherCubit>().currentUser;
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => PublisherReports(currentUser: _user)));
                },
                child: const Card(
                  child: ListTile(
                    leading: Icon(Icons.search),
                    title: Text("Show publisher reports"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Card profileDetail(BuildContext context, DataFetched state) {
    return Card(
        child: Row(children: [
      const Spacer(),
      Padding(
        padding: context.paddingNormal,
        child: CustomCircleAvatar(avatarUrl: FirebaseAuth.instance.currentUser?.photoURL),
      ),
      const Spacer(),
      Column(
        children: [
          Text(state.currentUser?.userName?.toUpperCase() ?? "coultn't fetch user name"),
          Text(state.currentUser?.userTitle ?? "null title")
        ],
      ),
      const Spacer(),
    ]));
  }
}
