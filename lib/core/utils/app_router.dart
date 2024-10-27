import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/profile/presentation/views/change_password_view.dart';
import 'constants/aceapt_page.dart';
import '../../features/authentication/auth_blocs/authentication_bloc/authentication_bloc.dart';
import '../../features/authentication/login/presentation/view_model/sign_in_bloc/signin_bloc.dart';
import '../../features/authentication/signup/presentation/view_model/sign_up_bloc/sign_up_bloc.dart';
import '../../features/authentication/login/presentation/views/login_view.dart';
import '../../features/authentication/signup/presentation/views/signup_view.dart';
import '../../features/chatbot/presentation/views/chatbot_view.dart';
import '../../features/home/presentation/views/contracts/sales%20contracts/sales_contracts_acept.dart';
import '../../features/home/presentation/views/contracts/sales%20contracts/sales_contracts_card.dart';
import '../../features/home/presentation/views/contracts/lease%20contracts/lease_card.dart';
import '../../features/home/presentation/views/contracts/waiver%20contracts/waiver_contracts_card.dart';
import '../../features/home/presentation/views/contracts/waiver%20contracts/waiver_contracts_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/layout/layout.dart';
import '../../features/notification/presentation/views/notification_view.dart';
import '../../features/profile/presentation/views/about_us_view.dart';
import '../../features/profile/presentation/views/change_language_view.dart';
import '../../features/profile/presentation/views/history_view.dart';
import '../../features/profile/presentation/views/privacy_policy_view.dart';
import '../../features/profile/presentation/views/settings_view.dart';
import '../../features/profile/presentation/views/profile_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

import '../../features/home/presentation/views/contracts/employment contract/employment_contract_card.dart';

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
  static const kSalesContractsCard = '/salesContractsCard';
  static const kChangeLanguageView = '/changeLanguageView';
  static const kAboutUsView = '/aboutUsView';
  static const kWaiverContractsCard = '/waiverContractsCard';
  static const kPrivacyPolicyView = '/privacyPolicyView';
  static const kHistoryView = '/historyView';
  static const kChangePasswordView = '/changePasswordView';

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
        path: kSalesContractsCard,
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
      GoRoute(
        path: kWaiverContractsCard,
        builder: (context, state) => const WaiverContractsCard(),
      ),
      GoRoute(
        path: kEmploymentCard,
        builder: (context, state) => const EmploymentContractCard(),
      ),
      GoRoute(
        path: kPrivacyPolicyView,
        builder: (context, state) => const PrivacyPolicyView(),
      ),
      GoRoute(
        path: kHistoryView,
        builder: (context, state) => const HistoryView(),
      ),
      GoRoute(
        path: kChangePasswordView,
        builder: (context, state) => const ChangePasswordView(),
      )
    ],
  );
}
