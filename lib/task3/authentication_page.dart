import 'package:flutter/material.dart';
import 'package:newproject/task3/home_screen.dart';
import 'package:newproject/services/auth_services.dart';
import 'package:provider/provider.dart';

//! G O O G L E - S I G N - I N - B U T T O N
class GoogleSignInButton extends StatefulWidget {
  final VoidCallback? onSuccess;
  
  const GoogleSignInButton({super.key, this.onSuccess});

  @override
  // ignore: library_private_types_in_public_api
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  //! S T A T E - V A R I A B L E S
  bool _isLoading = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    //! E L E V A T E D - B U T T O N
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          boxShadow: _isHovered 
              ? [BoxShadow(color: Colors.blue.withOpacity(0.4), blurRadius: 8, spreadRadius: 1)]
              : [],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            minimumSize: Size(240, 54),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: _isHovered ? Colors.blue.shade300 : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            elevation: _isHovered ? 3 : 1,
          ),
          onPressed: _isLoading ? null : _signInWithGoogle,
          //! B U T T O N - C O N T E N T
          child: _isLoading
              ? SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //! G O O G L E - L O G O
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'asset/google.png',
                        height: 24,
                      ),
                    ),
                    SizedBox(width: 16),
                    //! B U T T O N - T E X T
                    Text(
                      'Click here for Sign in',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  //! G O O G L E - S I G N - I N - F U N C T I O N
  Future<void> _signInWithGoogle() async {
    try {
      //! S E T - L O A D I N G - S T A T E
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      
      //! C A L L - A U T H - S E R V I C E
      final authService = Provider.of<AuthService>(context, listen: false);
      final userCredential = await authService.signInWithGoogle();
      
      //! H A N D L E - R E S P O N S E
      if (userCredential != null && mounted) {
        //! T R I G G E R - S U C C E S S - C A L L B A C K
        if (widget.onSuccess != null) {
          widget.onSuccess!();
        }
        
        //! N A V I G A T E - T O - H O M E 
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else if (mounted) {
        //! H A N D L E - C A N C E L L E D - S I G N - I N
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign-in canceled'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.all(8),
          ),
        );
      }
    } catch (e) {
      //! H A N D L E - E R R O R
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign-in failed: ${e.toString()}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.all(8),
          ),
        );
      }
    } finally {
      //! R E S E T - L O A D I N G - S T A T E
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}