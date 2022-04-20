import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product/bottom_nav_bar/bottom_nav_bar.dart';
import 'cubit/navbar_cubit.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavbarCubit(),
      child: BlocConsumer<NavbarCubit, NavbarState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<Widget> pageList = context.read<NavbarCubit>().pages;
          int selectedIndex = context.read<NavbarCubit>().selectedIndex;

          return Scaffold(
            body: context.read<NavbarCubit>().pages.elementAt(selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              items: BottomNavBarListModel().toWidget(),
              currentIndex: context.read<NavbarCubit>().selectedIndex,
              onTap: context.read<NavbarCubit>().selectPage,
            ),
          );
        },
      ),
    );
  }
}
