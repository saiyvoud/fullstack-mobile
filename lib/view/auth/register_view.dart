import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/messageHepler.dart';
import 'package:restaurant_app/provider/auth_provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
    bool _eye = true;

  onChangeEye() {
    setState(() {
      _eye = !_eye;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have Account?"),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Register",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Consumer<AuthProvider>(builder: (context, auth, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Create an",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Account",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: auth.fullname,
                      decoration: InputDecoration(
                        hintText: "Fullname",
                        prefixIcon: Icon(Icons.person),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: auth.phoneNumber,
                      decoration: InputDecoration(
                        hintText: "PhoneNumber",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.phone),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: auth.email,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      obscureText: _eye,
                      controller: auth.password,
                      decoration: InputDecoration(
                          hintText: "Password",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.security),
                          suffixIcon: IconButton(
                              onPressed: () {
                                onChangeEye();
                              },
                              icon: Icon(Icons.remove_red_eye)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      obscureText: _eye,
                      controller: auth.confrimPassword,
                      decoration: InputDecoration(
                          hintText: "Confirm password",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.security),
                          suffixIcon: IconButton(
                              onPressed: () {
                                onChangeEye();
                              },
                              icon: Icon(Icons.remove_red_eye)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      if(auth.fullname.text.isEmpty){
                        MessageHepler.showMessage(false, "fullname is required!");
                      }else if(auth.phoneNumber.text.isEmpty){
                         MessageHepler.showMessage(false, "phoneNumber is required!");
                      }else if(auth.phoneNumber.text.length < 10){
                           MessageHepler.showMessage(false, "phoneNumber must 10 number");
                      }else if( auth.email.text.isEmpty){
                         MessageHepler.showMessage(false, "email is required!");
                      }else if(!auth.email.text.contains("@gmail.com")){
                           MessageHepler.showMessage(false, "example@gmail.com!");
                      }else if(auth.password.text.isEmpty){
                        MessageHepler.showMessage(false, "password is required!");
                      }else if(auth.confrimPassword.text != auth.password.text){
                         MessageHepler.showMessage(false, "password not match");
                      }else{
                       auth.Register();
                      }  
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
