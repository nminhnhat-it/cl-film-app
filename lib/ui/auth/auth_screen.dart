import 'package:ct484_project/ui/auth/auth_manager.dart';
import 'package:ct484_project/ui/auth/login_form.dart';
import 'package:ct484_project/ui/auth/register_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    context.read<AuthManager>().initIsRegister = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthManager>(
      builder: (context, authManager, child) => CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(),
        child: ListView(
          children: [
                  !authManager.isRegister
              ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                          '${dotenv.env['API_HOST']}/public/uploads/logo-with-brand.png'),
                      const LoginForm(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('New here?'),
                          CupertinoButton(
                            onPressed: () {
                              setState(() {
                                authManager.isRegister = true;
                              });
                            },
                            child: const Text("Register"),
                          ),
                        ],
                      )
                    ],
                  )
              : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                          '${dotenv.env['API_HOST']}/public/uploads/logo-with-brand.png'),
                      const RegisterForm(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have account?'),
                          CupertinoButton(
                            onPressed: () {
                              setState(() {
                                authManager.isRegister = false;
                              });
                            },
                            child: const Text("Log In"),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
        ),
      ),
    );
  }
}
