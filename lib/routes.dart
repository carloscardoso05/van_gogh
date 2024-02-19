import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:van_gogh/controllers/houses_controller.dart';
import 'package:van_gogh/pages/home/home.dart';
import 'package:van_gogh/pages/auth/login.dart';
import 'package:van_gogh/pages/auth/register.dart';
import 'package:van_gogh/get_it.dart';
import 'package:van_gogh/pages/house_details/house_details.dart';
import 'package:van_gogh/services/auth_service.dart';

final routes = GoRouter(
  refreshListenable: getIt<AuthService>(),
  redirect: (context, state) {
    final isAuthenticated = getIt<AuthService>().isAuthenticated;
    final isLoginRoute = state.fullPath == '/login';
    final isRegisterRoute = state.fullPath == '/register';

    if (isAuthenticated && (isLoginRoute || isRegisterRoute)) return '/';

    if (!isAuthenticated && !isLoginRoute && !isRegisterRoute) return '/login';

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return MaterialPage(child: HomePage(), fullscreenDialog: true);
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
    GoRoute(
      path: '/houses/:code',
      pageBuilder: (context, state) {
        final house = getIt<HousesController>()
            .getHouses()
            .firstWhere((h) => h.houseCode == state.pathParameters['code']);
        return MaterialPage(
            child: HouseDetails(
              house: house,
            ),
            fullscreenDialog: true);
      },
    ),
  ],
);
