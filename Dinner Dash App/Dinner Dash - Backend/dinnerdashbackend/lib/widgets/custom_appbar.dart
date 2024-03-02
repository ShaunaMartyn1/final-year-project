import 'package:dinnerdashbackend/blocs/settings/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading) {
          return AppBar(
            title: Text(
              'Dinner Dash',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white),
            ),
            centerTitle: false,
          );
        }
        if (state is SettingsLoaded) {
          return AppBar(
            title: Text(
              (state.restaurant.name == null)
                  ? 'Dinner Dash'
                  : state.restaurant.name!,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white),
            ),
            centerTitle: false,
          );
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
