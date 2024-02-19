import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:van_gogh/get_it.dart';
import 'package:van_gogh/services/auth_service.dart';
import 'package:van_gogh/helpers/exception_snack_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _name = '';
  final _emailValidation = ValidationBuilder().required().email();
  final _passwordValidation = ValidationBuilder().required().minLength(6);
  final _nameRegex = RegExp(r'^([a-zA-Z\s]+)$', caseSensitive: false);
  late final _nameValidation = ValidationBuilder()
      .required()
      .minLength(3)
      .regExp(_nameRegex, "Nome inválido");
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
                  validator: _nameValidation.build(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nome",
                  ),
                  onChanged: (value) => setState(() => _name = value),
                ),
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
                TextFormField(
                  obscureText: true,
                  validator: _passwordValidation
                      .add((value) => value == _password
                          ? null
                          : 'As senhas devem ser iguais')
                      .build(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Confirmar Senha",
                  ),
                  onChanged: (value) => setState(() => _password = value),
                ),
                TextButton(
                  onPressed: () => context.push('/login'),
                  child: const Text('Já tenho uma conta'),
                ),
                ElevatedButton(
                  onPressed: isValid
                      ? () async {
                          try {
                            await getIt<AuthService>().register(
                              email: _email,
                              password: _password,
                              name: _name,
                            );
                          } on AuthException catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(createAuthExceptionSnackbar(e));
                            }
                          }
                        }
                      : null,
                  child: const Text("Cadastrar"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
