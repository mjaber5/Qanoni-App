import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/features/authentication/blocs/sign_in_bloc/signin_bloc.dart';

class SettingsContainerLogout extends StatefulWidget {
  const SettingsContainerLogout({super.key});

  @override
  State<SettingsContainerLogout> createState() =>
      _SettingsContainerLogoutState();
}

class _SettingsContainerLogoutState extends State<SettingsContainerLogout> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SigninBloc, SigninState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          log('Logout Success');
          GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
        } else if (state is SignOutFailure) {
          log('Logout fail');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            color: QColors.darkerGrey.withOpacity(0.4),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  onTap: () {
                    setState(() {
                      context.read<SigninBloc>().add(const SignOutRequired());
                    });
                  },
                  leading: const Icon(
                    Icons.logout_outlined,
                    color: QColors.error,
                  ),
                  title: Text(
                    QTexts.settingsLogout,
                    style: Styles.textStyle20.copyWith(
                      color: QColors.error,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
