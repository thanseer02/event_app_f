import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'connect.dart';
import 'main1.dart';
class edit extends StatefulWidget {
   edit({Key? key,required this.action,required this.time,required this.id}) : super(key: key);
var action,time,id;
  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  var actonctrl=TextEditingController();
  var timectrl=TextEditingController();
  Future <void> senddata() async{
    var data={
      'action':actonctrl.text,
      'time': timectrl.text,
      'id':widget.id
    };
    var response=await post(Uri.parse("${con.utl}update.php"),body: data);
    print(response.body);
    if (jsonDecode(response.body)   ['result']=='success') {
      setState(() {
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>main1()),(Route <dynamic> route )=>false);

      });
    }  
setState(() {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated')));
});
  }
  @override
  void initState(){
    super.initState();
    actonctrl.text=widget.action;
    timectrl.text=widget.time;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            TextFormField(
              controller: actonctrl,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'action'
              ),
            ),
            TextFormField(
              controller: timectrl,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: 'time'
              ),
            ),
          OutlinedButton(onPressed: (){
            if (actonctrl.text.isNotEmpty && timectrl.text.isNotEmpty) {
              print(actonctrl.text);
              print(timectrl.text);
              setState(() {
              });

              senddata();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>main1()));
            }
            else
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All field reqired')));
              }
          }, child: Text('Update'))
            
          ],
        ),
    );
  }
}
