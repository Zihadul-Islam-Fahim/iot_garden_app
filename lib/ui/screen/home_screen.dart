import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_garden/ui/screen/camera_screen.dart';
import 'package:iot_garden/ui/utitlities/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isMotorOn = false;

  void motorOn(value){
    isMotorOn =! isMotorOn;
    setState(() { });
  }


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('IOT Garden',style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [

              Container(
                height: 200,
                width: double.infinity,
                color: AppColors.primaryColor.withOpacity(0.9),
                child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('28° C',style: TextStyle(fontSize: 50,color: Colors.white),),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Max 42°C',style: TextStyle(fontSize: 20,color: Colors.white),),
                        Text('Min 33°C',style: TextStyle(fontSize: 20,color: Colors.white),),
                        Text('Humidity: 40%',style: TextStyle(fontSize: 20,color: Colors.white),),
                      ],
                    )
                  ],
                )),
              ),
              SizedBox(height: 2,),

              Container(
                height: 200,
                width: double.infinity,
                color: AppColors.primaryColor.withOpacity(0.8),
                child: Center(child: Text('Soil Humidity 30%',style: TextStyle(fontSize: 30,color: Colors.white),)),
              ),
              SizedBox(height: 2,),
              Container(
                height: 100,
                width: double.infinity,
                color:AppColors.primaryColor.withOpacity(0.76),
                child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text('Water Motor',style: TextStyle(fontSize: 30,color: Colors.white),),
                    SizedBox(width: 20,),
                    Switch(value: isMotorOn, onChanged: motorOn),
                  ],
                ))
              ),
              SizedBox(height: 2,),

              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CameraScreen()));
                  },

                  child: Container(

                    width: double.infinity,
                    color:AppColors.primaryColor.withOpacity(0.68),
                    child: Center(child: Icon(Icons.camera_alt,color: Colors.white,size: 60,)),
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
