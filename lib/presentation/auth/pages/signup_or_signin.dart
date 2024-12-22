import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:spotify_flutter/common/helpers/is_dark_mode.dart';
import 'package:spotify_flutter/common/widgets/appbar/appbar.dart';
import 'package:spotify_flutter/common/widgets/button/basic_app_button.dart';
import 'package:spotify_flutter/core/config/assets/app_images.dart';
import 'package:spotify_flutter/core/config/assets/app_vectors.dart';
import 'package:spotify_flutter/presentation/auth/pages/signin.dart';
import 'package:spotify_flutter/presentation/auth/pages/signup.dart';

import '../../../core/config/theme/app_colors.dart';

class SignuporSigninPage extends StatelessWidget {
  const SignuporSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BasicAppbar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.authBG),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppVectors.logo),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Enjoy Listening To Music",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                       Text(
                        "Spotify is a proprietary Swedish audio streaming and media services provider",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: context.isDarkMode ? AppColors.grey : Colors.black
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              //flex: 1,
                              child: BasicAppButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=> SignupPage()));
                            },
                            title: 'Register',
                          )),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              //flex: 1,
                              child: BasicAppButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=> SigninPage()));
                            },
                            title: 'Sign In',
                          )),
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
