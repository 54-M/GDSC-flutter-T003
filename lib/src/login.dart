import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/src/register.dart';
import 'package:tutorial/src/list.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<login_screen> {
  bool flag_pass = true;
  final _formKey_email = GlobalKey<FormState>();
  final formKey_pass = GlobalKey<FormState>();
  bool _isEmailValid = false;
  bool passValidate = true;


  void toggle_show_pass() {
    setState(() {
      flag_pass = !flag_pass;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ClipPath(
                clipper: my_clipper(),
                child: Container(
                  color: Colors.purple,
                  height: size.height / 4,
                  child: Center(
                      child: Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.height / 20,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              SizedBox(height: size.height / 10),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey_email,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: _isEmailValid ? Colors.green : Colors.red),
                        ),
                        labelText: "Email",
                        hintText: "example@thing.com",
                        prefixIcon: const Icon(Icons.email),
                        // Add email validation decoration
                        ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email address';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      // Update email validation state
                      setState(() {
                        _isEmailValid = value.isNotEmpty &&
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value);
                      });
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 2),
                child: Form(
                  key: formKey_pass,
                  child: TextFormField(
                    obscureText: flag_pass,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      errorText: passValidate ? null : 'Password must be at least 6 characters long',
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: flag_pass
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: toggle_show_pass,
                      ),
                    ),
                    obscuringCharacter: "*",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      } else if (value.length < 6) {
                        passValidate = false;
                        return 'Password must be at least 6 characters long';
                      }
                      passValidate = true;
                      return null;
                    },

                  ),
                ),
              ),
              SizedBox(height: 85),
              SizedBox(height: size.height * .09),
              ElevatedButton(
                onPressed: () {
                  if (_formKey_email.currentState!.validate() && formKey_pass.currentState!.validate()) {
                    if (kDebugMode) {
                      print('Valid form');
                    }
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return animat_list();
                      },
                    ));

                  } else {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text('Please enter your email and password'),
                    //     duration: Duration(seconds: 2),
                    //   ),
                    // );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  primary: Colors.purpleAccent,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width / 2.52,
                      vertical: size.height / 50),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("Login"),
              ),
              SizedBox(height: size.height * .02),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const register_screen();
                    },
                  ));
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width / 2.75,
                      vertical: size.height / 50),
                  side: const BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.purple,
                    width: 1.3,
                  ),
                  backgroundColor: Colors.white,
                  primary: Colors.purpleAccent,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.purple),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class my_clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo((size.width) / 5, size.height - 40,
        (size.width + 10) / 2.1, size.height - 10);
    path.quadraticBezierTo(3.3 / 4.3 * size.width, size.height + 15,
        size.width + 4, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
