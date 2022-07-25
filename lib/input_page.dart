import 'dart:async';
import 'switch_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reusable_card.dart';
import 'constants.dart';
import 'results_page.dart';
import 'round_icon_button.dart';
import 'bottom_button.dart';
import 'calculator_brain.dart';
import 'package:iconsax/iconsax.dart';

enum Gender {
  male,
  female,
  notSelected,
}

enum UnitWeight {
  kg,
  lb,
}

enum UnitHeight {
  cm,
  ft,
}



class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  UnitHeight unitHeight = UnitHeight.cm;
  UnitWeight unitWeight = UnitWeight.kg;
  Gender selectedGender = Gender.notSelected;
  double height = 180;
  double weight = 60;
  int age = 18;
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: Container(),
        title: Center(child: Text('BMI CALCULATOR')),
        actions: [
          RawMaterialButton(
            // onLongPress: onLongPressed,
            child: Icon(Iconsax.refresh1, size: 30),
            onPressed: () {
              setState(() {
                height = 180;
                weight = 60;
                age = 18;
                selectedGender = Gender.notSelected;
              });
            },
            elevation: 100,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            constraints: BoxConstraints.tightFor(width: 60, height: 56.0),
            fillColor: Color(0xFF0A0D22),
          ),
        ],

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    colour: selectedGender == Gender.male
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.mars,
                      label: 'MALE',
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    colour: selectedGender == Gender.female
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.venus,
                      label: 'FEMALE',
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HEIGHT',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: unitHeight == UnitHeight.cm ? 35 : 50),
                      Text(
                        unitHeight == UnitHeight.cm
                            ? height.toStringAsFixed(0)
                            : (height / 30.48).toStringAsFixed(1),
                        style: kNumberTextStyle,
                      ),
                      const SizedBox(width: 9),
                      SwitchButton(
                        onTap: () {
                          setState(() {
                            unitHeight = unitHeight == UnitHeight.cm
                                ? UnitHeight.ft
                                : UnitHeight.cm;
                          });
                        },
                        unit: unitHeight == UnitHeight.cm ? 'cm' : 'ft',
                      )
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Color(0xFF8E8D98),
                      thumbColor: Color(0xFFEB1555),
                      overlayColor: Color(0x29EB1555),
                      overlayShape:
                      RoundSliderOverlayShape(overlayRadius: 30.0),
                      thumbShape:
                      RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    ),
                    child: Slider(
                      value: height,
                      min: 120,
                      max: 220,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.roundToDouble();
                        });
                      },
                    ),
                  )
                ],
              ),
              colour: kActiveCardColor,
              onPress: () {},
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              unitWeight == UnitWeight.kg
                                  ? weight.toStringAsFixed(0)
                                  : (weight * 2.205).toStringAsFixed(0),
                              style: kNumberTextStyle,
                            ),
                            const SizedBox(width: 9),
                            SwitchButton(
                              onTap: () {
                                setState(() {
                                  unitWeight = unitWeight == UnitWeight.kg
                                      ? UnitWeight.lb
                                      : UnitWeight.kg;
                                });
                              },
                              unit: unitWeight == UnitWeight.kg ? 'kg' : 'lb',
                            ) ,
                            const SizedBox(width: 8),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  if (weight > 1) {
                                    unitWeight == UnitWeight.kg
                                        ? weight--
                                        : weight -= 0.453;
                                  }
                                });
                              },
                              onLongPressed: (TapDownDetails details) {
                                _timer = Timer.periodic(
                                    Duration(milliseconds: 70), (t) {
                                  setState(() {
                                    if (weight > 1) {
                                      unitWeight == UnitWeight.kg
                                          ? weight--
                                          : weight -= 0.453;
                                    }
                                  });
                                });
                              },
                              onTapUp: (TapUpDetails details) {
                                _timer.cancel();
                              },
                              onTapCancel: () {
                                _timer.cancel();
                              },
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  unitWeight == UnitWeight.kg
                                      ? weight++
                                      : weight += 0.453;
                                });
                              },
                              onLongPressed: (TapDownDetails details) {
                                _timer = Timer.periodic(
                                    Duration(milliseconds: 70), (t) {
                                  setState(() {
                                    if (weight >= 0) {
                                      unitWeight == UnitWeight.kg
                                          ? weight++
                                          : weight += 0.453;
                                    }
                                  });
                                });
                              },
                              onTapUp: (TapUpDetails details) {
                                _timer.cancel();
                              },
                              onTapCancel: () {
                                _timer.cancel();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    onPress: () {},
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            // SizedBox(width: ),
                            Text(
                              age.toString(),
                              style: kNumberTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  if (age > 1) {
                                    age--;
                                  }
                                });
                              },
                              onLongPressed: (TapDownDetails details) {
                                _timer = Timer.periodic(
                                    Duration(milliseconds: 70), (t) {
                                  setState(() {
                                    if (age > 1) {
                                      age--;
                                    }
                                  });
                                });
                              },
                              onTapUp: (TapUpDetails details) {
                                _timer.cancel();
                              },
                              onTapCancel: () {
                                _timer.cancel();
                              },
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                              onLongPressed: (TapDownDetails details) {
                                _timer = Timer.periodic(
                                    Duration(milliseconds: 70), (t) {
                                  setState(() {
                                    if (weight >= 0) {
                                      age++;
                                    }
                                  });
                                });
                              },
                              onTapUp: (TapUpDetails details) {
                                _timer.cancel();
                              },
                              onTapCancel: () {
                                _timer.cancel();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    onPress: () {},
                  ),
                )
              ],
            ),
          ),
          BottomButton(
            onTap: () {
              CalculatorBrain calc =
              CalculatorBrain(height: height, weight: weight);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(
                    bmiResult: calc.calculatorBMI(),
                    resultText: calc.getResult(),
                    interpretation: calc.getInterpretation(),
                  ),
                ),
              );
            },
            buttonTitle: 'CALCULATE YOUR BMI ',
          ),
        ],
      ),
    );
  }
}