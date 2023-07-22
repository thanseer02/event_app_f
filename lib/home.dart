import 'dart:convert';

import 'package:event/main1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'connect.dart';
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  var actonctrl=TextEditingController();
  var timectrl=TextEditingController();
  Future<void>  sentdata() async{
    var data=    {
      'action':actonctrl.text,
      'time':timectrl.text,
    };
    var response=await post(Uri.parse("${con.utl}insert.php"),body:data);
    // var response=await post(Uri.parse('${con.Uri}insert.php'),body:data);
       print(response.body);
       print(response.statusCode);
        // return jsonDecode(response.body);
    if (jsonDecode(response.body)['result']=='success....') {
      setState(() {
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>main1()),(Route <dynamic> route )=>false);

      });
    }  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        title: Text('Add task'),
      ),
      backgroundColor: Colors.white38,
      body: SafeArea(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 20.0),
              //     child: TextField(
              //       // controller: emailclr ,
              //       // keyboardType: TextInputType.text,
              //       decoration: InputDecoration(
              //         fillColor: Colors.grey,
              //         filled: true,
              //         border: InputBorder.none,
              //         hintText: 'What to do ',
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 50,
              ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              controller: actonctrl,
              keyboardType: TextInputType.text,
              maxLines:8,
              decoration: InputDecoration(
                hintText: 'Add task',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)

                ),
              ),
            ),
          ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: TextField(
                  controller: timectrl,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Time',
                    filled: true,
                    fillColor: Colors.white,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)

                    ),
                  ),
                ),
              ),              Padding(
                padding: const EdgeInsets.only(right: 58.0),
                child: OutlinedButton(onPressed: (){
                  print(actonctrl.text);
                  print(timectrl.text);
                  sentdata();
                  setState(() {
                  }
                  );
                },  child: Icon(Icons.add_box,size: 70,color: Colors.white38,),style:ElevatedButton.styleFrom(backgroundColor: Colors.transparent),),
              )
            ],

          ) ),

    );
  }
}
