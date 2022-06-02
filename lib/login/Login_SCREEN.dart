import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task/componadas/TextFormFeldComponads.dart';

import '../LodingPage/LodingScreen.dart';
import '../componadas/Componadas.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool isnormal = true;
  var EmailController = TextEditingController();

  var passController = TextEditingController();
  bool isobs = true;
  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.black,
            child: const Text(
              "Login",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
      ),
      body: ConditionalBuilder(
        builder:(context)=> Container(
          height: Size.height,
          width: Size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Asset/hq720_live.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
              child: MyContainer(
            Height: Size.height * .8,
            Width: Size.width * .8,
            Child: LoginForm(Size),
            context: context,
          )),
        ),
        fallback:(context)=>Container(
    height: Size.height,
    width: Size.width,
    decoration: const BoxDecoration(
    image: DecorationImage(
    image: AssetImage("Asset/hq720_live.jpg"),
    fit: BoxFit.fill,
    ),
    ),
    child:const Center(child: Text("Sorry you are not have access to use app in this time",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w900),)) ,

      ),
        condition: DateTime.now().isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,20,0,0)),
    )
    );
  }

  Widget MyContainer(
      {required Height, required Width, Widget? Child, context}) {
    return AnimatedOpacity(
      opacity: _isLoading ? 0 : 1,
      duration: const Duration(milliseconds: 600),
      onEnd: () {
        Nevigator(
            boolen: false,
            page: LoadingPage(isNormal: isnormal),
            context: context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.9),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white60,
              width: 3,
            )),
        height: Height,
        width: Width,
        child: Child,
      ),
    );
  }

  Widget LoginForm(Size Size) {
    return Row(
      children: [
        Container(
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.only(left: 10),
            height: Size.height * .8,
            width: Size.width * .4,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
              image: DecorationImage(
                image: AssetImage("Asset/you.png"),
                colorFilter: ColorFilter.mode(Colors.grey, BlendMode.modulate),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          width: 2,
          height: Size.height * .8,
          color: Colors.grey[700],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          width: Size.width * .35,
          height: Size.height * .8,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage("Asset/logo.jpeg"),
                  radius: 90,
                ),
                const Spacer(),
                MyTextField(
                  Controlr: EmailController,
                  hint: "youssefahmed@gmail.com",
                  label: "EmailAddress",
                  auto: true,
                  Prefix: const Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Your Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    Controlr: passController,
                    hint: "***********",
                    label: "Password",
                    Prefix: const Icon(
                      Icons.password,
                      color: Colors.black,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    suffix: IconButton(
                      icon:
                          Icon(isobs ? Icons.visibility_off : Icons.visibility),
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          isobs = !isobs;
                        });
                      },
                    ),
                    isobsr: isobs),
                const SizedBox(
                  height: 25,
                ),
                MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (EmailController.text == "test@gmail.com" &&
                          passController.text == "123456") {
                        setState(() {
                          _isLoading = true;
                        });
                      } else {
                        if (_formKey.currentState!.validate()) {
                          if (EmailController.text == "youssef@gmail.com" &&
                              passController.text == "123") {
                            setState(() {
                              isnormal = false;
                              _isLoading = true;
                            });
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Email or Password is Wrong"),
                              duration: Duration(seconds: 2),
                            ));
                          }
                        }
                      }
                    }
                  },
                  shape: const StadiumBorder(),
                  height: 50,
                  elevation: 3,
                  color: Colors.black,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                const Spacer(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
