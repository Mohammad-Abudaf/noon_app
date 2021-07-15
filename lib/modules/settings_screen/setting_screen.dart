import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/componants/componants.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage('https://mdbootstrap.com/img/new/avatars/2.jpg'),
                  )
                ),
              ),
              SizedBox(width: 10.0,),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Your points',
                    textAlign: TextAlign.center,
                    style: TextStyle(

                      fontSize: 20.0,
                      fontFamily: 'Janna'
                    ),
                  ),
                  Text(
                    '500',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Janna'
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Your credits',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Janna'
                    ),
                  ),
                  Text(
                    '30',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 30.0,
                      fontFamily: 'Janna'
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30,),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Mohammed Abudaf',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    'ID: 1234',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          defaultButton(
            onPressed: (){},
            label: 'Update Info',
            buttonColor: Colors.grey,
            height: 30.0,
            borderRadius: 10.0,
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text(
                'Dark Mode',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Janna',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              ToggleSwitch(
                totalSwitches: 2,
                initialLabelIndex: 0,
                activeBgColor: [defaultColor],
                icons: [
                  Icons.brightness_6, Icons.brightness_3,
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text(
                'Language',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Janna',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              ToggleSwitch(
                totalSwitches: 2,
                initialLabelIndex: 0,
                activeBgColor: [defaultColor],
                labels: ['English', 'Arabic'],
                onToggle: (index){
                  print(index);
                },
              ),
            ],
          ),
          SizedBox(height: 20,),
          Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: MaterialButton(
                      height: 120,
                      onPressed: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: defaultColor,
                        ),
                        child: Icon(Icons.share, size: 100, color: Colors.white,),
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      height: 120,
                      onPressed: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: defaultColor,
                        ),
                        child: Icon(Icons.call, size: 100, color: Colors.white,),
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      height: 120,
                      onPressed: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: defaultColor,
                        ),
                        child: Icon(Icons.alternate_email, size: 100, color: Colors.white,),
                      ),
                    ),
                  ),
                ],
              )
          ),

        ],
      ),
    );
  }
}
