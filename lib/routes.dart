import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:van_gogh/pages/home_page.dart';
import 'package:van_gogh/pages/login_page.dart';
import 'package:van_gogh/pages/register_page.dart';
import 'package:van_gogh/get_it.dart';
import 'package:van_gogh/services/auth_service.dart';

final routes = GoRouter(
  refreshListenable: getIt<AuthService>(),
  redirect: (context, state) {
    final isAuthenticated = getIt<AuthService>().isAuthenticated;
    final isLoginRoute = state.fullPath == '/login';

    if (!isAuthenticated && !isLoginRoute) return '/login';

    if (isAuthenticated && isLoginRoute) return '/';

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        final isAdmin = getIt<AuthService>().isAdmin;
        return MaterialPage(child: HomePage(isAdmin: isAdmin), fullscreenDialog: true);
      },
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) =>
          const MaterialPage(child: LoginPage(), fullscreenDialog: true),
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) =>
          const MaterialPage(child: RegisterPage(), fullscreenDialog: true),
    ),
  ],
);
