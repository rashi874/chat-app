import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/global_provider.dart';
import 'package:zchatapp/view/const.dart';

bool genderselect = false;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GblProviders>(
        builder: (BuildContext context, value, Widget? child) {
      // value.initialfunctions();
      return Scaffold(
        floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            log(genderselect.toString());
            if (genderselect == true) {
              value.signupUser(context);
            }
          },
          icon: const Icon(Icons.arrow_forward, color: Colors.white),
          label: const Text(
            'Continue',
            style: TextStyle(color: Colors.white),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Stranger Chat',
            // style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/i.gif',
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(187, 255, 255, 255)),
                child: const Column(
                  children: [
                    Text(
                      'Chat With Strangers for Free\nand Unlimited.',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 48, 48, 48)),
                    ),
                    Sizes.spacerh10,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        'Send unlimited texts to online strangers. Stranger Chat app. We as humans love to connect or meet new people',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 129, 127, 127)),
                      ),
                    ),
                  ],
                ),
              ),
              Sizes.spacerh30,
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(30),
                //   color: Color.fromARGB(255, 255, 255, 255),
                // ),
                child: const Text(
                  'Select Your Gender',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 31, 31, 31)),
                ),
              ),
              Sizes.spacerh20,
              const SizedBox(height: 150, child: GenderSelector()),
              Sizes.spacerh30,
              const Spacer()
            ],
          ),
        ),
      );
    });
  }
}

class CustomRadio extends StatelessWidget {
  CustomRadio(this.gender, {super.key});
  Gender gender;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: gender.isSelected
            ? const Color.fromARGB(255, 255, 255, 255)
            : const Color.fromARGB(255, 52, 52, 52),
        child: Container(
          width: 75,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                gender.icon,
                color: gender.isSelected ? Colors.black : Colors.grey,
                size: 35,
              ),
              const SizedBox(height: 10),
              Text(
                gender.name,
                style: TextStyle(
                    color: gender.isSelected ? Colors.black : Colors.grey),
              ),
            ],
          ),
        ));
  }
}

class Gender {
  String name;
  IconData icon;
  bool isSelected;

  Gender(this.name, this.icon, this.isSelected);
}

class GenderSelector extends StatefulWidget {
  const GenderSelector({super.key});

  @override
  GenderSelectorState createState() => GenderSelectorState();
}

class GenderSelectorState extends State<GenderSelector> {
  List<Gender> genders = [];

  @override
  void initState() {
    super.initState();
    genders.add(Gender("Male", Icons.male, false));
    genders.add(Gender("Female", Icons.female, false));
    genders.add(Gender("Other", Icons.transgender, false));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GblProviders>(
        builder: (BuildContext context, value, Widget? child) {
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: genders.length,
          itemBuilder: (context, index) {
            return InkWell(
              // splashColor: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                setState(() {
                  genders.forEach((gender) => gender.isSelected = false);
                  genders[index].isSelected = true;
                  value.gender = genders[index].name;
                  genderselect = true;
                });
              },
              child: CustomRadio(genders[index]),
            );
          });
    });
  }
}
