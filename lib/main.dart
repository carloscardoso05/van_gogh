import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:van_gogh/env.dart';
import 'package:van_gogh/main_app.dart';
import 'package:van_gogh/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Env.apiUrl,
    anonKey: Env.apiKey,
  );
  setupProviders();
  runApp(const MainApp());
}
