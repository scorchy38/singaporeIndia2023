import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dicecash/screens/profile/components/refer_earn.dart';
import 'package:dicecash/services/payement_method_notifier.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/constants.dart';
import '../../../models/User.dart';
import '../../../services/authentication/authentication_service.dart';
import '../../../services/data_streams/user_stream.dart';
import '../../../services/database/user_database_helper.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  final UserStream userStream = UserStream();
  @override
  void initState() {
    super.initState();

    userStream.init();
  }

  @override
  void dispose() {
    userStream.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildCountryField(),
          SizedBox(
            height: 20,
          ),

          country == 'India' ? buildMethodsField() : Container(),
          country == 'Pakistan' ? buildMethodsField() : Container(),
          country == 'Brazil' ? buildMethodsField() : Container(),
          country == 'Philippines' ? buildMethodsField() : Container(),
          country == 'Global' ? buildMethodsField() : Container(),

          country != null
              ? SizedBox(
                  height: 20,
                )
              : Container(),
          buildAccountNoField(),
          SizedBox(
            height: 20,
          ),
          buildAccountNameField(),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColors.primary),
            child: InkWell(
              onTap: () {
                if (method == 'PayPal') {
                  String mailId = accountNo.text.toString();
                  emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(mailId);
                }
                if (method == 'Paytm') {
                  String numb = accountNo.text.toString();
                  numbValid = (numb.length == 10);
                }
                if (country != null &&
                    method != null &&
                    accountNo.text.isNotEmpty &&
                    name.text.isNotEmpty &&
                    emailValid &&
                    numbValid) {
                  UserDatabaseHelper()
                      .addPaymentMethod(
                          country, method, accountNo.text, name.text)
                      .then((value) {
                    paymentMethodChangeNotifier.setPaymentMethod();
                  });

                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: 'Payment Method Successfully Set!');
                } else {
                  !emailValid
                      ? Fluttertoast.showToast(
                          msg: 'Please enter a valid email!')
                      : !numbValid
                          ? Fluttertoast.showToast(
                              msg: 'Please enter a valid phone number!')
                          : Fluttertoast.showToast(
                              msg: 'Please fill all details correctly!');
                }

                setState(() {});
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
                child: Center(
                  child: Text('Save',
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          )

          // Container(
          //   color: Colors.white,
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   child: ListView.builder(
          //       scrollDirection: Axis.vertical,
          //       itemCount: snapshot.data?.length,
          //       itemBuilder: (context, index) {
          //         return userCard(index, snapshot.data![index]['display_picture'], snapshot.data![index]['name'], snapshot.data![index]['gold']);
          //       }
          //   ),
          // ),
        ],
      ),
    );
  }

  String? country;
  bool emailValid = true;
  bool numbValid = true;
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: Colors.grey),
    gapPadding: 10,
  );
  OutlineInputBorder outlineInputBorderFocused = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: AppColors.primary),
    gapPadding: 10,
  );
  UnderlineInputBorder underlineInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: AppColors.primary),
  );
  Widget buildCountryField() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorderFocused,
        border: outlineInputBorder,
        hintText: "Select your country",
        labelText: "Country",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) {
        setState(() {
          // switch(value) {
          //   case 'India' :
          //     method = 'Paytm';
          //     break;
          //   case 'Pakistan' :
          //     method = 'JazzCash';
          //     break;
          //   case 'Brazil' :
          //     method = 'PayPal';
          //     break;
          //   case 'Philippines' :
          //     method = 'PayPal';
          //     break;
          //   case 'Other Countries' :
          //     method = 'PayPal';
          //     break;
          // }

          country = value.toString();
        });
      },
      items: ['India', 'Pakistan', 'Philippines', 'Brazil', 'Global']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  String? method;
  Widget buildMethodsField() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorderFocused,
        border: outlineInputBorder,
        hintText: "Select a payment method",
        labelText: "Payment Method",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) {
        setState(() {
          method = value.toString();
        });
      },
      items: country == 'India'
          ? [
              'Paytm',
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()
          : country == 'Pakistan'
              ? ['JazzCash'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()
              : country == 'Philippines'
                  ? [
                      'GCash',
                      'PayPal',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                  : country == 'Brazil'
                      ? [
                          'PIX',
                          'PayPal',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()
                      : ['PayPal'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
    );
  }

  final TextEditingController accountNo = TextEditingController();
  final TextEditingController name = TextEditingController();

  Widget buildAccountNoField() {
    return TextFormField(
      controller: accountNo,
      enabled: country == null || method == null ? false : true,
      keyboardType: method == 'PayPal'
          ? TextInputType.emailAddress
          : method == 'Paytm'
              ? TextInputType.phone
              : TextInputType.number,
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorderFocused,
        border: outlineInputBorder,
        hintText: method == 'PayPal'
            ? "Enter your email"
            : method == "Paytm"
                ? "Enter your phone number"
                : "Enter your account number",
        labelText: method == 'PayPal'
            ? "Your PayPal Email"
            : method == "Paytm"
                ? "Your Paytm Phone Number"
                : "Account/Phone No as per payment method",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (accountNo.text.isEmpty) {
          return 'This field is mandatory!';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildAccountNameField() {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: TextFormField(
        enabled: country == null || method == null ? false : true,
        controller: name,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorderFocused,
          border: outlineInputBorder,
          hintText: "Enter your name",
          labelText: "Name associated with account",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        validator: (value) {
          if (accountNo.text.isEmpty) {
            return 'This field is mandatory!';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Widget optionCardLong(Color color, String text, String line1, String btnText,
      String anim, String reward, void Function() onTap) {
    return SizedBox(
      child: Card(
        elevation: 4,
        color: AppColors.primary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Container(
              child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(text,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(line1,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: AppColors.orange,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                      ),

                      // Container(
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.all(Radius.circular(35)),
                      //       color: AppColors.orange.withOpacity(0.4)
                      //   ),
                      //
                      //   child:Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12),
                      //     child: Text('$reward',
                      //         style: Theme.of(context).textTheme.headline6?.copyWith(
                      //             color: Colors.white,
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.bold)),
                      //   ),
                      //
                      // ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                    ],
                  ),

                  Image.asset(
                    anim,
                    height: 100,
                  ),
                  // anim != ''
                  //     ? SizedBox(
                  //         height: 70, child: CircleAvatar(backgroundColor: Colors.white, backgroundImage:AssetImage(anim), radius: 50,))
                  //     : Container(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppColors.orange),
                child: InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 12),
                    child: Center(
                      child: Text(btnText,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
