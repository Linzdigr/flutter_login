import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'constants.dart';
import 'custom_route.dart';
import 'dashboard_screen.dart';
import 'users.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';

  final Size size;

  LoginScreen({this.size});

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (mockUsers[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: ResponsiveSafeArea (
        builder: (context, size) {
          return FlutterLogin(
            title: Constants.appName,
            logo: 'assets/images/ecorp.png',
            logoTag: Constants.logoTag,
            titleTag: Constants.titleTag,
            constraints: size,
            // messages: LoginMessages(
            //   usernameHint: 'Username',
            //   passwordHint: 'Pass',
            //   confirmPasswordHint: 'Confirm',
            //   loginButton: 'LOG IN',
            //   signupButton: 'REGISTER',
            //   forgotPasswordButton: 'Forgot huh?',
            //   recoverPasswordButton: 'HELP ME',
            //   goBackButton: 'GO BACK',
            //   confirmPasswordError: 'Not match!',
            //   recoverPasswordIntro: 'Don\'t feel bad. Happens all the time.',
            //   recoverPasswordDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
            //   recoverPasswordSuccess: 'Password rescued successfully',
            // ),
            // theme: LoginTheme(
            //   primaryColor: Colors.teal,
            //   accentColor: Colors.yellow,
            //   errorColor: Colors.deepOrange,
            //   pageColorLight: Colors.indigo.shade300,
            //   pageColorDark: Colors.indigo.shade500,
            //   titleStyle: TextStyle(
            //     color: Colors.greenAccent,
            //     fontFamily: 'Quicksand',
            //     letterSpacing: 4,
            //   ),
            //   // beforeHeroFontSize: 50,
            //   // afterHeroFontSize: 20,
            //   bodyStyle: TextStyle(
            //     fontStyle: FontStyle.italic,
            //     decoration: TextDecoration.underline,
            //   ),
            //   textFieldStyle: TextStyle(
            //     color: Colors.orange,
            //     shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
            //   ),
            //   buttonStyle: TextStyle(
            //     fontWeight: FontWeight.w800,
            //     color: Colors.yellow,
            //   ),
            theme: LoginTheme(
              cardTheme: CardTheme(
                margin: EdgeInsets.only(top: 15),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
              ),
            ),
            //   inputTheme: InputDecorationTheme(
            //     filled: true,
            //     fillColor: Colors.purple.withOpacity(.1),
            //     contentPadding: EdgeInsets.zero,
            //     errorStyle: TextStyle(
            //       backgroundColor: Colors.orange,
            //       color: Colors.white,
            //     ),
            //     labelStyle: TextStyle(fontSize: 12),
            //     enabledBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
            //       borderRadius: inputBorder,
            //     ),
            //     focusedBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
            //       borderRadius: inputBorder,
            //     ),
            //     errorBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: Colors.red.shade700, width: 7),
            //       borderRadius: inputBorder,
            //     ),
            //     focusedErrorBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            //       borderRadius: inputBorder,
            //     ),
            //     disabledBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: Colors.grey, width: 5),
            //       borderRadius: inputBorder,
            //     ),
            //   ),
            //   buttonTheme: LoginButtonTheme(
            //     splashColor: Colors.purple,
            //     backgroundColor: Colors.pinkAccent,
            //     highlightColor: Colors.lightGreen,
            //     elevation: 9.0,
            //     highlightElevation: 6.0,
            //     shape: BeveledRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            //     // shape: CircleBorder(side: BorderSide(color: Colors.green)),
            //     // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
            //   ),
            // ),
            background: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: CurveGradient(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.98, 1),
                        end: Alignment(0.80, 0.5),
                        colors: [
                          Color(0xffe73c8c),
                          Color(0xffe73f3f)
                        ]
                      )
                    ),
                  )
                ),
                CustomPaint(
                  painter: BorderPainter(),
                  child: Container(),
                )
              ]
            ),
            emailValidator: (value) {
              if (!value.contains('@') || !value.endsWith('.com')) {
                return "Email must contain '@' and end with '.com'";
              }
              return null;
            },
            passwordValidator: (value) {
              if (value.isEmpty) {
                return 'Password is empty';
              }
              return null;
            },
            onLogin: (loginData) {
              print('Login info');
              print('Name: ${loginData.name}');
              print('Password: ${loginData.password}');
              return _loginUser(loginData);
            },
            onSignup: (loginData) {
              print('Signup info');
              print('Name: ${loginData.name}');
              print('Password: ${loginData.password}');
              return _loginUser(loginData);
            },
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(FadePageRoute(
                builder: (context) => DashboardScreen(),
              ));
            },
            onRecoverPassword: (name) {
              print('Recover password info');
              print('Name: $name');
              return _recoverPassword(name);
              // Show new password dialog
            },
          );
        }
      )
    );
  }
}

class CurveGradient extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height * 0.95);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.85,
        size.width * 0.75, size.height * 0.90);
    path.quadraticBezierTo(size.width * 0.90, size.height * 0.93,
        size.width * 1.0, size.height * 0.75);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth=5.0
      ..color = Color(0xfff0f0f0);

    var path = Path();
    path.moveTo(0, size.height * 0.95);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.85,
        size.width * 0.75, size.height * 0.90);
    path.quadraticBezierTo(size.width * 0.90, size.height * 0.93,
        size.width * 1.0, size.height * 0.75);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}



typedef ResponsiveBuilder = Widget Function(
  BuildContext context,
  Size size,
);

class ResponsiveSafeArea extends StatelessWidget {
  const ResponsiveSafeArea({
    @required ResponsiveBuilder builder,
    Key key,
  })  : responsiveBuilder = builder,
        super(key: key);

  final ResponsiveBuilder responsiveBuilder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return responsiveBuilder(
            context,
            constraints.biggest,
          );
        },
      ),
    );
  }
}