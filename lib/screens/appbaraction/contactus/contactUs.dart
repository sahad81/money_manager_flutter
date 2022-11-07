import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:moneymanagement/screens/screenhome/screen_home.dart';
import 'package:overlay_support/overlay_support.dart';
import 'dart:convert';
import 'package:validators/validators.dart';

//import 'package:iconify_flutter/icons/zondicons.dart';
// ignore: camel_case_types
class contactUs extends StatefulWidget {
  contactUs({super.key});
  @override
  State<contactUs> createState() => _contactUsState();
}

// ignore: camel_case_types
class _contactUsState extends State<contactUs> {
  final namecontroler = TextEditingController();
  final emailcontroler = TextEditingController();
  final messagecontroler = TextEditingController();
  final subcontroler = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isemailcorrect = false;
  bool subcontrolercrt = false;
  bool messagecontrolercrt = false;
  bool suffixchange = false;
  bool isnameiscrt = false;
//bool focusedmsg=false;
// bool focusedemail=false;

  bool focusedmsg = false;
  bool focusname = false;
  bool focusmail = false;
  bool focusedsub = false;
  bool condetion = false;
//bool for internet;
  bool internet = false;

// //------------------------
  @override
  void dispose() {
    emailcontroler.dispose();
    namecontroler.dispose();
    subcontroler.dispose();
    messagecontroler.dispose();
    super.dispose();
  }

  Future sendmail(BuildContext context) async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const sarviesid = "service_z0yu4o8";
    const tembletid = "template_ulumwq4";
    const userId = "O-a6sczZ-gerFnuAp";
    var responce = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json'
        },
        body: json.encode(
          {
            "service_id": sarviesid,
            "template_id": tembletid,
            "user_id": userId,
            "template_params": {
              "name": namecontroler.text,
              "message": messagecontroler.text,
              "user_email": emailcontroler.text,
            }
          },
        ));

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(seconds: 5),
      content: Text('Email Sanding Succesfully Competed'),
      backgroundColor: Colors.green,
    ));
    return responce.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            'Contact',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Builder(builder: (context) {
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Focus(
                      onFocusChange: (suffixchange) {
                        setState(() {
                          focusname = true;
                        });
                      },
                      child: TextFormField(
                        onChanged: (val) {
                          setState(() {
                            isnameiscrt = isByteLength(val, 2, 15);
                          });
                        },
                        controller: namecontroler,
                        decoration: InputDecoration(
                            suffixIcon: focusname
                                ?
                                //  consumerl.statusfocus(true) ?

                                isnameiscrt == false
                                    ? const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.done,
                                        color: Colors.green,
                                      )
                                : SizedBox(),
                            labelText: 'Name',
                            hintText: 'Name',
                            icon: Icon(Icons.account_circle),
                            //  border: OutlineInputBorder()
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: isnameiscrt == false
                                        ? Colors.red
                                        : Colors.green))),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Focus(
                      onFocusChange: (suffixchange) {
                        setState(
                          () {
                            focusmail = true;
                          },
                        );
                      },
                      child: TextFormField(
                        showCursor: true,
                        controller: emailcontroler,
                        onChanged: (val) {
                          setState(() {
                            isemailcorrect = isEmail(val);
                          });
                        },
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Enter email Adress';
                          }
                        }),
                        decoration: InputDecoration(
                            suffixIcon:
//providerveriableforData.focusmail?
                                focusmail
                                    ? isemailcorrect == false
                                        ? const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.done,
                                            color: Colors.green,
                                          )
                                    : SizedBox(),
                            labelText: 'Email',
                            hintText: 'Email',
                            icon: Icon(Icons.email),
                            //  border: OutlineInputBorder()
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: isemailcorrect == false
                                        ? Colors.red
                                        : Colors.green))),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Focus(
                      onFocusChange: (suffixchange) {
                        setState(() {
                          focusedsub = true;
                        });
//providerveriableforData.focusedsub;
                      },
                      child: TextFormField(
                        showCursor: true,
                        controller: subcontroler,
                        onChanged: (vali) {
                          setState(() {
                            subcontrolercrt = isByteLength(vali, 2, 40);
                          });
                        },
                        decoration: InputDecoration(
                            suffixIcon:
                                // providerveriableforData.focusedsub?
                                focusedsub
                                    ? subcontrolercrt == false
                                        ? const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.done,
                                            color: Colors.green,
                                          )
                                    : const SizedBox(),
                            labelText: 'Subject',
                            hintText: 'Subject',
                            icon: Icon(Icons.subject),
                            //  border: OutlineInputBorder()

                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: subcontrolercrt == false
                                        ? Colors.red
                                        : Colors.green))),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Focus(
                      onFocusChange: (suffixchange) {
                        setState(
                          () {
                            focusedmsg = true;
                          },
                        );
                      },
                      child: TextFormField(
                        controller: messagecontroler,
                        onChanged: (vali) {
                          setState(() {
                            messagecontrolercrt = isByteLength(vali, 4, 100);
                          });
                        },
                        decoration: InputDecoration(
                            suffixIcon: focusedmsg
                                ?
                                //    providerveriableforData.focusedmsg?
                                messagecontrolercrt == false
                                    ? const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      )
                                    : Icon(
                                        Icons.done,
                                        color: Colors.green,
                                      )
                                : SizedBox(),
                            labelText: 'Message',
                            hintText: 'Message',
                            icon: Icon(Icons.message),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: messagecontrolercrt == false
                                        ? Colors.red
                                        : Colors.green))),
                        style: const TextStyle(fontSize: 25),
                        maxLines: 5,
                        minLines: 3,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            focusname = true;
                            focusmail = true;
                            focusedmsg = true;
                            focusedsub = true;
                          });
                          internet =
                              await InternetConnectionChecker().hasConnection;

                          internet == false
                              ? showSimpleNotification(
                                  const Text('check your internet conection'),
                                  background: Colors.red)
                              : null;
                          internet ? validation() : null;
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 50),
                          maximumSize: const Size(150, 50),
                          backgroundColor: Colors.black
                        ),
                        child: const Text(
                          'SEND',
                          style: TextStyle(color: Colors.white),
                        )),
                        const SizedBox(height: 20)
                  ],
                ),
              ),
            ),
          ));
        }));
  }

  validation() {
    if (isnameiscrt &&
        isemailcorrect &&
        messagecontrolercrt &&
        subcontrolercrt) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 3),
        content: Text(' Sandig Email.....'),
        backgroundColor: Colors.green,
      ));
      sendmail(context);

      Navigator.push(context, MaterialPageRoute(builder: (c) {
        return homescreen();
      }));
    } else {
      return;
    }
  }
}
