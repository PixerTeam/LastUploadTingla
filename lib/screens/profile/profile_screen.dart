import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tingla/bloc/tingla_cubit.dart';
import 'package:tingla/bloc/tingla_state.dart';
import 'package:tingla/screens/details/connection_error_screen.dart';
import 'package:tingla/variables/variables.dart';
import 'package:tingla/widgets/loading_widget.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<TinglaCubit>(
        create: (context) {
          return TinglaCubit(
            Variables.profileData == null
                ? const TinglaLoading()
                : const TinglaCompleted(),
          );
        },
        child: Builder(
          builder: (context) {
            if (Variables.profileData == null) {
              context.read<TinglaCubit>().getProfile();
            }
            return BlocConsumer<TinglaCubit, TinglaState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is TinglaError) {
                  return ConnectionErrorScreen(
                    press: () async {
                      context.read<TinglaCubit>().getProfile();
                    },
                  );
                } else if (state is TinglaCompleted) {
                  return const Body();
                }

                return const LoadingWidget();
              },
            );
          },
        ),
      ),
    );
  }
}
