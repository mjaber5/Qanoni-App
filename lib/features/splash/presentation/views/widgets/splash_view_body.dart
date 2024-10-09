import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/features/splash/presentation/views/widgets/custom_splash_view.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constants/text_strings.dart';
import '../../../../authentication/auth_blocs/authentication_bloc/authentication_bloc.dart';
import 'sliding_text.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 4),
      end: Offset.zero,
    ).animate(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          Future.delayed(
            const Duration(seconds: 2),
            () {
              GoRouter.of(context).pushReplacement(AppRouter.kLayout);
            },
          );
        } else if (state.status == AuthenticationStatus.unauthenticated) {
          Future.delayed(
            const Duration(seconds: 2),
            () {
              GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
            },
          );
        }
      },
      child: Column(
        children: [
          const CustomView(),
          const Text(
            QTexts.appLogoTitle,
            style: TextStyle(
              fontSize: 75,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          SlidingText(slidingAnimation: slidingAnimation),
        ],
      ),
    );
  }
}
