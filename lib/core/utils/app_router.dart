import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/constants/aceapt_page.dart';
import 'package:qanoni/features/authentication/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:qanoni/features/authentication/blocs/sign_in_bloc/signin_bloc.dart';
import 'package:qanoni/features/authentication/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:qanoni/features/authentication/login/presentation/views/login_view.dart';
import 'package:qanoni/features/authentication/signup/presentation/views/signup_view.dart';
import 'package:qanoni/features/chatbot/presentation/views/chatbot_view.dart';
import 'package:qanoni/features/home/presentation/views/contracts/sales%20contracts/sales_contracts_acept.dart';
import 'package:qanoni/features/home/presentation/views/contracts/sales%20contracts/sales_contracts_card.dart';
import 'package:qanoni/features/home/presentation/views/contracts/lease%20contracts/lease_card.dart';
import 'package:qanoni/features/home/presentation/views/contracts/waiver%20contracts/waiver_contracts_view.dart';
import 'package:qanoni/features/home/presentation/views/home_view.dart';
import 'package:qanoni/features/layout/layout.dart';
import 'package:qanoni/features/notification/presentation/views/notification_view.dart';
import 'package:qanoni/features/profile/presentation/views/about_us_view.dart';
import 'package:qanoni/features/profile/presentation/views/change_language_view.dart';
import 'package:qanoni/features/profile/presentation/views/settings_view.dart';
import 'package:qanoni/features/profile/presentation/views/profile_view.dart';
import 'package:qanoni/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kLoginView = '/loginView';
  static const kSignupView = '/signupView';
  static const kLayout = '/layoutApp';
  static const kHomeView = '/homeView';
  static const kChatbotView = '/chatbotView';
  static const kNotificationView = '/notificationView';
  static const kProfileView = '/profileView';
  static const kSettingsView = '/settingsView';
  static const kAceaptView = '/aceaptView';
  static const kEmploymentAcept = '/employmentAcept';
  static const kLeaseCard = '/leaseCard';
  static const kPurchaseView = '/purchaseView';
  static const kPurchaseCards = '/purchaseCards';
  static const kEmploymentCard = '/employmentCard';
  static const kChangeLanguageView = '/changeLanguageView';
  static const kAboutUsView = '/aboutUsView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => BlocProvider<SigninBloc>(
          create: (context) => SigninBloc(
            userRepository: context.read<AuthenticationBloc>().userRepository,
          ),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: kSignupView,
        builder: (context, state) => BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(
            userRepository: context.read<AuthenticationBloc>().userRepository,
          ),
          child: const SignupView(),
        ),
      ),
      GoRoute(
        path: kLayout,
        builder: (context, state) => const LayoutView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: kChatbotView,
        builder: (context, state) => const ChatbotView(),
      ),
      GoRoute(
        path: kNotificationView,
        builder: (context, state) => const NotificationView(),
      ),
      GoRoute(
        path: kProfileView,
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: kSettingsView,
        builder: (context, state) => BlocProvider<SigninBloc>(
          create: (context) => SigninBloc(
            userRepository: context.read<AuthenticationBloc>().userRepository,
          ),
          child: const SettingsView(),
        ),
      ),
      GoRoute(
        path: kAceaptView,
        builder: (context, state) => const AceaptPage(),
      ),
      GoRoute(
        path: kEmploymentAcept,
        builder: (context, state) => const SalesContractsAcept(),
      ),
      GoRoute(
        path: kLeaseCard,
        //Todo Replace contains in this view to LeaseContractsView
        builder: (context, state) => const LeaseContractsCards(),
      ),
      GoRoute(
        path: kEmploymentCard,
        //Todo Replace contains in this view to SalesContractsView
        builder: (context, state) => const SalesContractsCard(),
      ),
      GoRoute(
        path: kPurchaseView,
        builder: (context, state) => const WaiverContractsView(),
      ),
      GoRoute(
        path: kChangeLanguageView,
        builder: (context, state) => const ChangeLanguageView(),
      ),
      GoRoute(
        path: kAboutUsView,
        builder: (context, state) => const AboutUsView(),
      ),
    ],
  );
}
