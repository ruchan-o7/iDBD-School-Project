import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'cubit/publisherreports_cubit.dart';

class PublisherReports extends StatelessWidget {
  const PublisherReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Publisher Reports")),
      body: BlocProvider(
        create: (context) => PublisherReportsCubit(),
        child: BlocConsumer<PublisherReportsCubit, PublisherReportsState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: context.paddingNormal,
              child: Column(
                mainAxisAlignment: context.read<PublisherReportsCubit>().books != null
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: context.read<PublisherReportsCubit>().books != null
                    ? context
                        .read<PublisherReportsCubit>()
                        .books!
                        .map((e) => Card(
                              child: ListTile(
                                leading: SizedBox(
                                  height: context.dynamicHeight(0.3),
                                  width: context.dynamicWidth(0.2),
                                  child: Image.network(
                                    e.volumeInfo.imageLinks?.thumbnail ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(e.volumeInfo.title ?? "null title"),
                                trailing: e.isApproved
                                    ? Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      )
                                    : Icon(Icons.more_time),
                              ),
                            ))
                        .toList()
                    : const [Center(child: Text("There is no request yet"))],
              ),
            );
          },
        ),
      ),
    );
  }
}
