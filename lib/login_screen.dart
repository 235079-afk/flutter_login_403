import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/social_login_button.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/sign_in_button.dart';
import 'widgets/or_divider.dart';
import 'widgets/auth_switch_text.dart';
import 'widgets/forgot_password_link.dart';
import 'widgets/welcome_text.dart';
import 'widgets/theme_toggle_button.dart';

class LoginScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const LoginScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ThemeToggleButton(
            isDarkMode: widget.isDarkMode,
            onToggle: widget.onToggleTheme,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),

              SvgPicture.asset(
                'assets/images/403_zero_with_keyhole_icon_bw_v2.svg',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn)
              ),

              const SizedBox(height: 8),

              const WelcomeText(text: 'Welcome to 403'),

              const SizedBox(height: 40),

              SocialLoginButton(
                icon: Icons.g_mobiledata,
                label: 'Login with Google',
                iconColor: Colors.black,
                onPressed: () => _handleSocialLogin('Google'),
              ),
              const SizedBox(height: 12),
              SocialLoginButton(
                icon: Icons.apple,
                label: 'Login with Apple',
                iconColor: Colors.black,
                onPressed: () => _handleSocialLogin('Apple'),
              ),
              const SizedBox(height: 12),
              SocialLoginButton(
                icon: Icons.facebook,
                label: 'Login with Facebook',
                iconColor: Colors.black,
                onPressed: () => _handleSocialLogin('Facebook'),
              ),

              const SizedBox(height: 24),
              const OrDivider(),
              const SizedBox(height: 24),

              CustomTextField(
                controller: _userController,
                label: 'Username',
              ),

              const SizedBox(height: 16),

              CustomTextField(
                controller: _passwordController,
                label: 'Password',
                obscureText: _obscurePassword,
                onToggleVisibility: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),

              const SizedBox(height: 12),

              ForgotPasswordLink(onPressed: _handleForgotPassword),

              const SizedBox(height: 24),

              SignInButton(
                label: 'Sign In →',
                onPressed: _handleSignIn,
                isLoading: _isLoading,
              ),

              const SizedBox(height: 24),

              AuthSwitchText(
                isLogin: true,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSocialLogin(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$provider login clicked')),
    );
  }

  void _handleForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Forgot password clicked')),
    );
  }

  void _handleSignIn() {
    final email = _userController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate a login API call.
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isLoading = false);

      final name = _nameFromEmail(email);

      Navigator.pushReplacementNamed(context, '/home', arguments: name);
    });
  }

  String _nameFromEmail(String email) {
    final prefix = email.split('@').first;
    if (prefix.isEmpty) return 'there';
    return prefix[0].toUpperCase() + prefix.substring(1);
  }
}
