import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iot_garden/ui/screen/camera_screen.dart';
import 'package:iot_garden/ui/utitlities/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final databaseRef = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              "https://iot-garden-b741c-default-rtdb.asia-southeast1.firebasedatabase.app")
      .ref("gardenData");

  bool isMotorOn = false;
  String humidity = "0";
  String soilHumidity = "0";
  String temperature = "0";

  Future<void> getData() async {
    DataSnapshot dataSnapshot = await databaseRef.get();
    humidity = dataSnapshot.child("humidity").value.toString();
    temperature = dataSnapshot.child("temprature").value.toString();
    humidity = dataSnapshot.child("humidity").value.toString();
    soilHumidity = dataSnapshot.child("soilHumidity").value.toString();
    String motor = dataSnapshot.child("waterMotor").value.toString();
    motor == "false" ? isMotorOn = false : isMotorOn = true;

    setState(() {});
  }

  Future<void> motorOn(value) async {
    isMotorOn = !isMotorOn;
    setState(() {});
    await databaseRef.update({
      "waterMotor": isMotorOn,
    });
  }

  Future<void> refresh() async {
    await getData();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'IOT Garden',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          // centerTitle: true,
          backgroundColor: AppColors.primaryColor,
        ),
        body: RefreshIndicator(
          color: Colors.teal,
          backgroundColor: Colors.amberAccent,
          onRefresh: refresh,
          child: ListView(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: AppColors.primaryColor.withOpacity(0.9),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$soilHumidity%',
                      style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                          fontFamily: 'sans'),
                    ),
                    const Text(
                      'Soil Humidity',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: 'sans'),
                    ),
                  ],
                )),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                height: 200,
                width: double.infinity,
                color: AppColors.primaryColor.withOpacity(0.8),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '$temperature° C',
                      style: const TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                          fontFamily: 'sans'),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Humidity: $humidity%',
                          style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'sans'),
                        ),
                      ],
                    )
                  ],
                )),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                  height: 100,
                  width: double.infinity,
                  color: AppColors.primaryColor.withOpacity(0.76),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Water Motor',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontFamily: 'sans'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Switch(
                        value: isMotorOn,
                        onChanged: motorOn,
                        activeColor: AppColors.primaryColor,
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                      ),
                    ],
                  ))),
              const SizedBox(
                height: 2,
              ),
              SizedBox(
                height: 300,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CameraScreen()));
                  },
                  child: Container(
                    width: double.infinity,
                    color: AppColors.primaryColor.withOpacity(0.68),
                    child: const Center(
                        child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 60,
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
