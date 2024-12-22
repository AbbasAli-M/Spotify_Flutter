import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_flutter/common/widgets/appbar/appbar.dart';
import 'package:spotify_flutter/common/widgets/button/basic_app_button.dart';
import 'package:spotify_flutter/core/config/assets/app_vectors.dart';
import 'package:spotify_flutter/data/models/auth/signin_user_req.dart';
import 'package:spotify_flutter/domain/usecases/auth/signin.dart';
import 'package:spotify_flutter/presentation/auth/pages/signup.dart';

import '../../../service_locator.dart';
import '../../home/pages/home.dart';


class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signinTextField(context),
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _signinText(),
            const SizedBox(
              height: 50,
            ),
            _emailField(context),
            const SizedBox(
              height: 20,
            ),
            _passwordField(context),
            const SizedBox(
              height: 30,
            ),
            BasicAppButton(
                onPressed: () async {
                  var result = await sl<SigninUseCase>().call(
                      params: SigninUserReq(
                          email: _email.text.toString(),
                          password: _password.text.toString()));
                  result.fold((l) {
                    var snackbar = SnackBar(content: Text(l));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }, (r) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const HomePage()),
                            (route) => false);
                  });
                }, title: 'Sign In'),
          ],
        ),
      ),
    );
  }

  Widget _signinText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: 'Enter UserName Or Email',
      ).applyDefaults(Theme
          .of(context)
          .inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(
        hintText: 'Password',
      ).applyDefaults(Theme
          .of(context)
          .inputDecorationTheme),
    );
  }

  Widget _signinTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Not a member?",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupPage()));
            },
            child: const Text(
              'Register Now',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
