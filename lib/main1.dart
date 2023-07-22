import 'dart:convert';

import 'package:event/connect.dart';
import 'package:event/edit.dart';
import 'package:event/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'connect.dart';
class main1 extends StatefulWidget {
  const main1({Key? key}) : super(key: key);

  @override
  State<main1> createState() => _main1State();
}

class _main1State extends State<main1> {
  Future<void> _handleRefresh() async {
    // Perform your refresh operation here, such as fetching new data

    // Simulate a delay for demonstration purposes
    await Future.delayed(const Duration(seconds: 2));

    // Update your data or perform any other action

    // Call setState() to notify Flutter that the data has changed
    setState(() {
      // Update your data here
    });
  }//refresh

  var uid;
  var flag=0;
  Future <dynamic> getdata() async{
    var response=await get(Uri.parse("${con.utl}read.php"));
    if (jsonDecode(response.body)[0]['result']=='success')
    {
      flag=1;
      return jsonDecode(response.body);
      
    }
    else
      {
        flag=0;
        Text('No Data');
      }
  }
  //***********************************************view***********************************************************************
  Future <dynamic> deletedata() async{
    var data={'id':uid};
    // var response=await post(Uri.parse("${con.utl}delete.php"),body:data);
    var response=await post(Uri.parse("${con.utl}delete.php"),body: data);
    if (jsonDecode(response.body)['result']=='Success.........') {
      return jsonDecode(response.body);
    }
    else
      {
        const Center(
          child: CircularProgressIndicator(),
        );
      }
  }
  //***********************************************Delete***********************************************************************
@override
void initState(){
    super.initState();
    setState(() {
      getdata();
    });
}
  // @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: Text('To do '),
        actions: [
          Row(
            children: [
              IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
            }, icon: Icon(Icons.add,size: 40,)),
              IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
            ],

          )
        ],
      ),
      body: SafeArea(
          child: Container(
            height: double.infinity,
                 child: FutureBuilder(
                   future: getdata(),
                   builder: (context, snapshot) {
                     if (snapshot.hasError) {
                       print(snapshot.error);
                       
                     }
                     if (!snapshot.hasData ||snapshot.data.length==0) {
                       const Center(
                         child: CircularProgressIndicator(),
                       );
                       
                     }  //************************************view************************************************
                     return flag==1?RefreshIndicator(
                       onRefresh: _handleRefresh,//********************refresh***********************************************
                       child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            ),
                            elevation: 15,
                            child: Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                    color: Colors.black45
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [

                                      IconButton(onPressed: (){
                                        uid=snapshot.data[index]['id'];
                                        setState(() {
                                          deletedata();
                                        });
                                      }, icon: Icon(Icons.delete,size: 30,color: Colors.white70,)),
                                      IconButton(onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>edit(
                                            action: snapshot.data[index]['action'],
                                            time: snapshot.data[index]['time'],
                                            id: snapshot.data[index]['id'])));
                                      }, icon: Icon(Icons.edit,size: 30,color: Colors.white70,)),

                                    ],),
                                    Text('${snapshot.data[index]['action']}',style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold),),
                                  // Text('action',style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),),


                                      // Text('time',style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),),

                                      Text('${snapshot.data[index]['time']}',style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),)

                                  ],
                                ),
                              ),

                            ),
                          ),
                        );
                }
                       ),
                     ):Center(child: CircularProgressIndicator());
                   }
                 )
    )
  )
  );



  }
}
