import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/constants/aceapt_page.dart';
import 'package:qanoni/features/authentication/presentation/views/login_view.dart';
import 'package:qanoni/features/chatbot/presentation/views/chatbot_view.dart';
import 'package:qanoni/features/home/presentation/views/card/lease_card.dart';
import 'package:qanoni/features/home/presentation/views/home_view.dart';
import 'package:qanoni/features/layout/layout.dart';
import 'package:qanoni/features/notification/presentation/views/notification_view.dart';
import 'package:qanoni/features/profile/presentation/settings_view.dart';
import 'package:qanoni/features/profile/presentation/views/profile_view.dart';
import 'package:qanoni/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kLoginView = '/loginView';
  static const kLayout = '/layoutApp';
  static const kHomeView = '/homeView';
  static const kChatbotView = '/chatbotView';
  static const kNotificationView = '/notificationView';
  static const kProfileView = '/profileView';
  static const kSettingsView = '/settingsView';
  static const kAceaptView = '/aceaptView';
  static const kLeaseCard = '/leaseCard';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => const LoginView(),
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
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(
        path: kAceaptView,
        builder: (context, state) => const AceaptPage(),
      ),
      GoRoute(
        path: kLeaseCard,
        builder: (context, state) => const LeaseCard(),
      ),
    ],
  );
}
