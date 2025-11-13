import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_project/core/di/injector.dart' as di;
import '../../../home/presentation/home_page.dart';
import '../bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController(text: 'test@example.com');
  final _password = TextEditingController(text: 'password');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<LoginBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is LoginSuccess) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) return const Center(child: CircularProgressIndicator());
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
                  const SizedBox(height: 8),
                  TextField(controller: _password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final email = _email.text.trim();
                      final pass = _password.text.trim();
                      context.read<LoginBloc>().add(LoginSubmitted(email, pass));
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 8),
                  const Text('Use test@example.com / password'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
