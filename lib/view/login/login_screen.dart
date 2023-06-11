import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/global_provider.dart';
import 'package:zchatapp/util/themes.dart';
import 'package:zchatapp/view/const.dart';

bool genderselect = false;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Consumer<GblProviders>(
        builder: (BuildContext context, value, Widget? child) {
      // value.initialfunctions();
      return Scaffold(
        floatingActionButton: ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                  AppColors().kprimary.withOpacity(0.6))),
          onPressed: () {
            log(genderselect.toString());
            if (genderselect == true) {
              value.signupUser(context);
            }
          },
          icon: const Icon(Icons.arrow_forward, color: Colors.white),
          label: const Padding(
            padding: EdgeInsets.only(bottom: 3.0),
            child: Text(
              'Continue',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Container(
          // margin: const EdgeInsets.only(left: 2, top: 30, right: 2),
          // padding: const EdgeInsets.all(8),
          // height: height / 1.1,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors().knav,
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/s.jpg',
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50.0, left: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Stranger Chat',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(22, 255, 255, 255)),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sizes.spacerh10,
                    Text(
                      'Chat With Strangers for Free and Unlimited.',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    Sizes.spacerh10,
                    Text(
                      'You can send unlimited texts to strangers online. The human race loves to meet new people and connect with them',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 213, 213, 213)),
                    ),
                    Sizes.spacerh10,
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    'Select Your Gender',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors().kwhite),
                  ),
                  Sizes.spacerh10,
                  const SizedBox(height: 140, child: GenderSelector()),
                ],
              ),
              Sizes.spacerh30,
            ],
          ),
        ),
      );
    });
  }
}

class CustomRadio extends StatelessWidget {
  const CustomRadio({super.key, required this.gender});
  final Gender gender;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: gender.isSelected
            ? AppColors().kwhite.withOpacity(0.6)
            : AppColors().kprimary.withOpacity(0.4),
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
                  for (var gender in genders) {
                    gender.isSelected = false;
                  }
                  genders[index].isSelected = true;
                  value.gender = genders[index].name;
                  genderselect = true;
                });
              },
              child: CustomRadio(
                gender: genders[index],
              ),
            );
          });
    });
  }
}
