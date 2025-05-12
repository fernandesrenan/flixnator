import 'package:flixnator/components/buttons/primary_button.dart';
import 'package:flixnator/components/buttons/secondary_button.dart';
import 'package:flixnator/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  static const route = '/landing';

  const LandingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/the_last_jedi.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 29, horizontal: 19),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: .9),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Watch movies anytime anywhere',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Text(
                  'Explore a vast collection of blockbuster movies, timeless classics, and the latest releases.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                PrimaryButton(
                  text: 'Login',
                  onPressed: () => context.go(HomePage.route),
                ),
                SecondaryButton(
                  text: 'Sign Up',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
