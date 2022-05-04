import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/core/constants/border_radius.dart';
import 'package:school_project_ibdb/core/constants/logo_path.dart';
import 'package:school_project_ibdb/feature/statistic_view/cubit/statistic_cubit.dart';

class StatisticView extends StatelessWidget {
  const StatisticView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatisticCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Statistics'),
        ),
        body: BlocConsumer<StatisticCubit, StatisticState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is StatsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StatsLoaded) {
              return Column(
                children: [
                  const Text("Most liked books this month"),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(thickness: 1),
                      itemBuilder: (context, index) => Card(
                        child: SizedBox(
                          height: context.dynamicHeight(0.20),
                          child: Padding(
                            padding: context.paddingLow,
                            child: Row(
                              children: [
                                state.picUrlList[index] == ""
                                    ? SizedBox(
                                        width: context.dynamicWidth(0.22),
                                        child: Image.asset(LogoPaths.dummyBook))
                                    : ClipRRect(
                                        borderRadius: BorderRadiusConst.normal,
                                        child: Image.network(state.picUrlList[index] ?? "", scale: 1.5)),
                                const VerticalDivider(thickness: 2),
                                SizedBox(
                                  width: context.dynamicWidth(0.55),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(state.stats.keys.elementAt(index)),
                                      Text(state.stats.values.elementAt(index).toString())
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // child: ListTile(
                        //   leading: Image.network(
                        //     "https://picsum.photos/200",
                        //     scale: 1.5,
                        //   ),
                        //   title: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(state.stats.keys.elementAt(index)),
                        //       Text(state.stats.values.elementAt(index).toString())
                        //     ],
                        //   ),
                        // ),
                      ),
                      itemCount: state.stats.length,
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
