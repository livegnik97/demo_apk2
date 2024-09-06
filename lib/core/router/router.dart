import 'package:demo_apk/presentation/pages/login_page.dart';
import 'package:demo_apk/presentation/pages/pages.dart';
import 'package:demo_apk/presentation/pages/register_page.dart';
import 'package:go_router/go_router.dart';

import 'router_path.dart';
import 'router_transition.dart';

final appRouter = GoRouter(
  initialLocation: RouterPath.LOGIN_PAGE,
  routes: [
    GoRoute(
      path: RouterPath.HOME_PAGE,
      pageBuilder: (context, state) => RouterTransition.slideTransitionPage(
          key: state.pageKey, child: const HomePage()),
    ),
    GoRoute(
      path: RouterPath.LOGIN_PAGE,
      pageBuilder: (context, state) => RouterTransition.fadeTransitionPage(
          key: state.pageKey, child: const LoginPage()),
    ),
    GoRoute(
      path: RouterPath.REGISTER_PAGE,
      pageBuilder: (context, state) => RouterTransition.fadeTransitionPage(
          key: state.pageKey, child: const RegisterPage()),
    ),
  ],
);
