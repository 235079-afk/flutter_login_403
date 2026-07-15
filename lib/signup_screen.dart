import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'widgets/social_login_button.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/sign_in_button.dart';
import 'widgets/or_divider.dart';
import 'widgets/auth_switch_text.dart';
import 'widgets/welcome_text.dart';
import 'widgets/theme_toggle_button.dart';

class SignUpScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const SignUpScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
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

              const WelcomeText(text: 'Create your account'),

              const SizedBox(height: 40),

              SocialLoginButton(
                icon: Icons.g_mobiledata,
                label: 'Sign up with Google',
                iconColor: Colors.black,
                onPressed: () => _handleSocialSignUp('Google'),
              ),
              const SizedBox(height: 12),
              SocialLoginButton(
                icon: Icons.apple,
                label: 'Sign up with Apple',
                iconColor: Colors.black,
                onPressed: () => _handleSocialSignUp('Apple'),
              ),
              const SizedBox(height: 12),
              SocialLoginButton(
                icon: Icons.facebook,
                label: 'Sign up with Facebook',
                iconColor: Colors.black,
                onPressed: () => _handleSocialSignUp('Facebook'),
              ),

              const SizedBox(height: 24),
              const OrDivider(),
              const SizedBox(height: 24),

              CustomTextField(
                controller: _nameController,
                label: 'Full Name',
                keyboardType: TextInputType.name,
              ),

              const SizedBox(height: 16),

              CustomTextField(
                controller: _emailController,
                label: 'Email Address',
                keyboardType: TextInputType.emailAddress,
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

              const SizedBox(height: 24),

              SignInButton(
                label: 'Create Account →',
                onPressed: _handleSignUp,
                isLoading: _isLoading,
              ),

              const SizedBox(height: 24),

              AuthSwitchText(
                isLogin: false,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSocialSignUp(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$provider sign up clicked')),
    );
  }

  void _handleSignUp() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isLoading = false);

      Navigator.pushReplacementNamed(context, '/home', arguments: name);
    });
  }
}
