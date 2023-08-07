import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/global_provider.dart';
import 'package:zchatapp/util/themes.dart';
import 'package:zchatapp/view/const.dart';
import 'package:zchatapp/view/login/login_screen.dart';

class CustomRadio extends StatelessWidget {
  const CustomRadio({Key? key, required this.gender}) : super(key: key);

  final Gender gender;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: gender.isSelected
            ? Color.fromARGB(157, 255, 255, 255)
            : AppColors().kprimary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: gender.isSelected
                  ? AppColors().kprimary
                  : AppColors().kprimary,
            ),
            child: Center(
              child: Icon(
                gender.icon,
                size: 20,
                color:
                    gender.isSelected ? AppColors().kwhite : AppColors().kwhite,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            gender.name,
            style: TextStyle(
              color:
                  gender.isSelected ? AppColors().kblack : AppColors().kwhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class Gender {
  String name;
  IconData icon;
  bool isSelected;

  Gender(this.name, this.icon, this.isSelected);
}

class GenderSelector extends StatefulWidget {
  const GenderSelector({Key? key}) : super(key: key);

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
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: genders.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  for (var gender in genders) {
                    gender.isSelected = false;
                  }
                  genders[index].isSelected = true;
                  value.gender = genders[index].name;
                  genderSelect = true;
                });
              },
              child: Column(
                children: [
                  CustomRadio(
                    gender: genders[index],
                  ),
                  Sizes.spacerh10,
                ],
              ),
            );
          },
        );
      },
    );
  }
}
