import 'package:flutter/material.dart';
import 'package:newproject/task3/home_screen.dart';
import 'package:newproject/services/auth_services.dart';
import 'package:provider/provider.dart';


class GoogleSignInButton extends StatefulWidget {
  final VoidCallback? onSuccess;
  
  const GoogleSignInButton({super.key, this.onSuccess});

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        minimumSize: Size(220, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        elevation: 1,
      ),
      onPressed: _isLoading ? null : _signInWithGoogle,
      child: _isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/google.png',
                  height: 24,
                ),
                SizedBox(width: 12),
                Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _signInWithGoogle() async {
    try {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      
      final authService = Provider.of<AuthService>(context, listen: false);
      final userCredential = await authService.signInWithGoogle();
      
      if (userCredential != null && mounted) {
        if (widget.onSuccess != null) {
          widget.onSuccess!();
        }
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-in canceled')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign-in failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}