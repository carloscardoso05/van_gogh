import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart' as locale;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:van_gogh/env.dart';
import 'package:van_gogh/main_app.dart';
import 'package:van_gogh/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'pt_BR';
  await locale.initializeDateFormatting();
  ValidationBuilder.setLocale('pt-br');

  await Supabase.initialize(
    url: Env.apiUrl,
    anonKey: Env.apiKey,
  );
  setupProviders();
  runApp(const MainApp());
}
