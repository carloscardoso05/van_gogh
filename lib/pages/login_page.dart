import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:van_gogh/get_it.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(
          width: 300,
          height: 500,
          child: Column(
            children: [
              TextFormField(
                validator: ValidationBuilder().email().build(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
              ),
              TextFormField(
                obscureText: true,
                validator: ValidationBuilder().minLength(8).build(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Senha",
                ),
              ),
              TextButton(
                onPressed: () => context.push('/register'),
                child: const Text('Criar conta'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Entrar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
