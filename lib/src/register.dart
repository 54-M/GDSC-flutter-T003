import 'package:flutter/material.dart';
import 'package:tutorial/src/login.dart';

class register_screen extends StatefulWidget {
  const register_screen({Key? key}) : super(key: key);

  @override
  State<register_screen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<register_screen> {
  bool flag_pass = true;
  bool flag_confirm_pass = true;
  final _formKey_email = GlobalKey<FormState>();
  final _formKey_pass = GlobalKey<FormState>();
  final _formKey_pass_confirm = GlobalKey<FormState>();
  bool _isEmailValid = false;
  bool _passValidate = true;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  void toggle_show_pass() {
    setState(() {
      flag_pass = !flag_pass;
    });
  }

  void toggle_show_confirm_pass() {
    setState(() {
      flag_confirm_pass = !flag_confirm_pass;
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
                child: Stack(
                  children: [
                    Container(
                      color: Colors.purple,
                      height: size.height / 4,
                      child: Center(
                          child: Text(
                        "REGISTER",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.height / 20,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    Positioned(
                      top: size.height / 10.3,
                      left: size.width / 40,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height / 20),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                      prefixIcon: Icon(
                        Icons.account_circle,
                      )),
                ),
              ),
              // ! ------------------------> Email field <------------------------//

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 2),
                child: Form(
                  key: _formKey_email,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: _isEmailValid ? Colors.green : Colors.red),
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
              SizedBox(height: size.height * .02),
              // ! ------------------------> phone field <------------------------//

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 2),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Phone",
                      prefixIcon: Icon(
                        Icons.phone,
                      )),
                ),
              ),
              SizedBox(height: size.height * .02),
              // ! ------------------------> Password field <------------------------//

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 2),
                child: Form(
                  key: _formKey_pass,
                  child: TextFormField(
                    obscureText: flag_pass,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      errorText: _passValidate
                          ? null
                          : 'Password must be at least 6 characters long',
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
                    controller: _pass,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      } else if (value.length < 6) {
                        _passValidate = false;
                        return 'Password must be at least 6 characters long';
                      }
                      _passValidate = true;
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: size.height * .02),
              // ! ------------------------> Confirm Password field <------------------------//

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 2),
                child: Form(
                  key: _formKey_pass_confirm,
                  child: TextFormField(
                    obscureText: flag_confirm_pass,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Confirm Password",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: flag_confirm_pass
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: toggle_show_confirm_pass,
                      ),
                    ),
                    obscuringCharacter: "*",
                    controller: _confirmPass,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      } else if (value != _pass.text) {
                        return 'Passwords do not match';
                      }

                      return null;
                    },
                  ),
                ),
              ),

              SizedBox(height: size.height * .03),

              // ! ------------------------> Register button<------------------------//

              ElevatedButton(
                onPressed: () {
                  _formKey_email.currentState!.save();
                  _formKey_pass.currentState!.save();
                  _formKey_pass_confirm.currentState!.save();

                  if (_formKey_email.currentState!.validate() ||
                      _formKey_pass.currentState!.validate() &&
                          _formKey_pass_confirm.currentState!.validate()) {
                    // If form is valid, do something here (e.g. log in)
                    print('Valid form');
                  } else {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text('add your info'),
                    //     duration: Duration(seconds: 2),
                    //   ),
                    // );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  primary: Colors.purpleAccent,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width / 2.75,
                      vertical: size.height / 60),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("Register"),
              ),
              SizedBox(height: size.height * .02),
              // ! ------------------------> Login button<------------------------//
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, MaterialPageRoute(
                    builder: (context) {
                      return const login_screen();
                    },
                  ));
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width / 2.5, vertical: size.height / 60),
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
                  "Login",
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
