import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:van_gogh/get_it.dart';
import 'package:van_gogh/services/auth_service.dart';
import 'package:van_gogh/helpers/exception_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final _emailValidation = ValidationBuilder().required().email();
  final _passwordValidation = ValidationBuilder().required().minLength(6);
  bool get isValid => _formKey.currentState?.validate() ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.all(10),
          width: 300,
          height: 500,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  validator: _emailValidation.build(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                  onChanged: (value) => setState(() => _email = value),
                ),
                TextFormField(
                  obscureText: true,
                  validator: _passwordValidation.build(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Senha",
                  ),
                  onChanged: (value) => setState(() => _password = value),
                ),
                TextButton(
                  onPressed: () => context.push('/register'),
                  child: const Text('Criar conta'),
                ),
                ElevatedButton(
                  onPressed: isValid
                      ? () async {
                          try {
                            await getIt<AuthService>()
                                .login(email: _email, password: _password);
                          } on AuthException catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(createAuthExceptionSnackbar(e));
                            }
                          }
                        }
                      : null,
                  child: const Text("Entrar"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

