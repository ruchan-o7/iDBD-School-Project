import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/feature/publisher_view/delete_request/cubit/deletereq_cubit.dart';

import '../../../product/publisher_user_model/publisher_user.dart';

class DeleteReqView extends StatelessWidget {
  DeleteReqView({Key? key, required this.currentUser}) : super(key: key);
  final PublisherUser? currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Delete book request")),
      body: BlocProvider(
        create: (context) => DeletereqCubit(currentUser),
        child: BlocConsumer<DeletereqCubit, DeletereqState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: context.paddingNormal,
                child: context.read<DeletereqCubit>().books?.length != 0
                    ? ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: context.read<DeletereqCubit>().books?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Image.network(context
                                    .read<DeletereqCubit>()
                                    .books?[index]
                                    ?.volumeInfo
                                    .imageLinks
                                    ?.thumbnail ??
                                ""),
                            title: Text(context.read<DeletereqCubit>().books?[index]?.volumeInfo.title ?? ""),
                            trailing: IconButton(
                                onPressed: () {
                                  context.read<DeletereqCubit>().deleteReq(
                                      context.read<DeletereqCubit>().books?[index]?.id ?? "", index);
                                },
                                icon: const Icon(Icons.delete)),
                          );
                        },
                      )
                    : Center(
                        child: Text("There is no request to delete",
                            style: Theme.of(context).textTheme.headline5),
                      ),
              );
            }
          },
        ),
      ),
    );
  }
}
