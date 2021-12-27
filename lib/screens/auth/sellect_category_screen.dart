import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/screens/app/app_screen.dart';
import 'package:tingla/size_config.dart';

class EndScreen extends StatefulWidget {
  const EndScreen({Key? key}) : super(key: key);

  @override
  _HammasiTayyorState createState() => _HammasiTayyorState();
}

class _HammasiTayyorState extends State<EndScreen> {
  final List _items = [
    [
      "Badiiy",
      "Ilmiy",
      "Diniy",
      "Detektiv",
      "Romantik",
      "Hajviy",
      "Tarixiy",
      "Fantastik",
      "Sarguzasht",
      "Biznes",
      "Podkast",
      "Bolalar uchun",
    ],
    [
      "assets/images/boo.png",
      "assets/images/image 969.png",
      "assets/images/tas.png",
      "assets/images/image 1060.png",
      "assets/images/image 235.png",
      "assets/images/image 5.png",
      "assets/images/image 1643.png",
      "assets/images/image 200.png",
      "assets/images/image 1655.png",
      "assets/images/image 1025.png",
      "assets/images/image 1211.png",
      "assets/images/image 387.png",
    ],
    [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionScreenWidth(24.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: getProportionScreenHeight(24.0)),
              Text(
                "O’zingiz uchun qiziq bo’lgan janrlarni tanlang",
                style: TextStyle(
                  color: kTextColor,
                  fontSize: getProportionScreenWidth(26.0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: getProportionScreenHeight(8.0),
              ),
              Text(
                "Kamida 2 ta kategoriyani tanlashingiz zarur",
                style: TextStyle(
                  fontSize: getProportionScreenWidth(14.0),
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: getProportionScreenHeight(8.0),
              ),
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: getProportionScreenHeight(70.0),
                    mainAxisSpacing: getProportionScreenHeight(14.0),
                    crossAxisSpacing: getProportionScreenWidth(14.0),
                  ),
                  itemCount: _items[0].length,
                  itemBuilder: (context, index) {
                    final bool _active = _items[2][index];
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: Color(_active ? 0xFFEBEDFC : 0xFFEEEEEE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(
                            color: Color(_active ? 0xFF3243DC : 0xFFEEEEEE),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _items[2][index] = !_items[2][index];
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: getProportionScreenWidth(24.0),
                              height: getProportionScreenHeight(24.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/icons/category_icons/${_items[0][index].toString().toLowerCase().split(" ")[0] + "_icon.png"}'),
                                ),
                              ),
                            ),
                          ),
                          // Image.asset(_items[1][index]),
                          SizedBox(
                            width: getProportionScreenWidth(8.0),
                          ),
                          Text(
                            _items[0][index],
                            style: TextStyle(
                              fontSize: getProportionScreenWidth(18.0),
                              fontWeight: FontWeight.w400,
                              color: kTextColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: getProportionScreenHeight(60.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(15, 15, 84, 1),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AppScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(
                        "Tayyor",
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(20.0),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: getProportionScreenHeight(58.0),
                      alignment: Alignment.center,
                      child: Text(
                        "O`tkazib yuborish",
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(16.0),
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
