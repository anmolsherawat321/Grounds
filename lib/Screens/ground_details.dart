import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../database_helper.dart';
import '../ground.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroundDetail extends StatefulWidget{
  final Ground ground;
  var _selectedValue;
  GroundDetail(this.ground,this._selectedValue);
  @override
  State<GroundDetail> createState(){
    return GroundDetailState(this.ground,_selectedValue);
  }
}

class GroundDetailState extends State<GroundDetail>{

  DatabaseHelper helper=DatabaseHelper();
  Ground ground;
  var _selectedValue;
  GroundDetailState(this.ground,this._selectedValue);



  //Dummy Data
  List<Ground> g1=[
    Ground.available2(1,'2022-12-18',20,10,'Mumbai Indians','Chennai Super Kings','N',1000,'Y','Y','Cosco'),
    Ground.available2(1,'2022-12-18',20,4,'Royal Challengers Banglore','Available','N',3000,'N','Y','Tennis'),
    Ground.available2(1,'2022-12-19',20,10,'Available','Available','N',4000,'N','Y','Cosco'),
    Ground.available2(1,'2022-12-20',20,10,'Punjab Kings','Chennai Super Kings','N',2000,'Y','Y','Cosco'),
    Ground.available2(2,'2022-12-18',20,4,'Punjab Kings','Available','N',2500,'Y','Y','Cosco'),
    Ground.available2(2,'2022-12-19',20,10,'Mumbai Indians','Gujarat Titans','N',4000,'Y','Y','Tennis'),
    Ground.available2(2,'2022-12-19',20,4,'Available','Available','Y',1000,'Y','Y','Rocky'),
    Ground.available2(3,'2022-12-18',20,10,'Mumbai Indians','Chennai Super Kings','N',6000,'Y','Y','Cosco'),
    Ground.available2(3,'2022-12-19',20,10,'Mumbai Indians','Chennai Super Kings','N',2500,'Y','Y','Cosco'),
    Ground.available2(3,'2022-12-20',20,10,'Mumbai Indians','Gujarat Titans','N',3000,'Y','Y','Tennis'),
  ];
late String team1,team2,cost,ball,available1,available2;
late bool ballProvided=true,umpireProvided=true;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<g1.length;i++)
    {
      if(ground.id==g1[i].id && _selectedValue.compareTo(DateFormat.yMMMEd().format(DateTime.parse(g1[i].date!)))==0)
      {
        team1=g1[i].team1!;
        team2=g1[i].team2!;
        cost=g1[i].cost!.toString();
        ball=g1[i].ballDetail!;
        if(g1[i].ballProvided=='Y')
        ballProvided=true;
        else
        ballProvided=false;
        if(g1[i].umpireProvided=='Y')
        umpireProvided==true;
        else
        umpireProvided=false;

        available1=(g1[i].team1!='Available')?'Booked':'Available';
        available2=(g1[i].team2!='Available')?'Booked':'Available';
      }
    }
  }


  //End of dummy data - Logic to be modified
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenUtilInit(
      designSize: const Size(360,690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
      return Scaffold(
        appBar: AppBar(title: Text('Ground Details',style: TextStyle(color: Colors.white)),backgroundColor: Color.fromARGB(255, 62, 174, 180),
        iconTheme: IconThemeData(color: Colors.white),
        ),
        
        body: SingleChildScrollView(
          child: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 90.0,
                    ),
                    Expanded(
                      child: ListTile(
                      
                      leading: Icon(Icons.calendar_month),
                      title: Text(_selectedValue.toString(),style: TextStyle(color: Colors.black),),
                                  ),
                    ),
                  ],
                  
                ),
              Image(
                fit: BoxFit.fill,
                height: 150.0,
                width: 350.0,
                image: AssetImage(ground.imgPath!),
                ),
              Align(alignment: Alignment(-0.9,0),child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(ground.name!,style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold),),
              )),
              Row(
                children: [
                  Expanded(child: Align(alignment: Alignment(-0.82, 0.0),child: Icon(Icons.location_on_outlined,color: Color.fromARGB(255, 62, 174, 180),))),
                  Expanded(child: Align(alignment: Alignment(-3.0, 0.0),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color.fromARGB(255, 62, 174, 180),width: 1.0)),
                    ),
                    child: Text('Navigate',style: TextStyle(fontSize: 14.0,color: Color.fromARGB(255, 62, 174, 180),)),
                  ),
                  
                  )),
                      
                  Expanded(child: Align(alignment: Alignment(0.00, 0.0),child: Text('Pitch Type: Mat',style: TextStyle(fontSize: 14.0)))),
                        
                          ],
                        ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Expanded(child: Align(alignment:Alignment(-0.51,0),child: Icon(Icons.food_bank_outlined,color: Color.fromARGB(255, 62, 174, 180),))),
                  
                  Expanded(child: Align(alignment:Alignment(-1.8,0),child: Icon(Icons.wash_outlined,color: Color.fromARGB(255, 62, 174, 180),))),
                  Container(
                          width: 210.0,
                        ),
                  Expanded(
                          
                          child: ListTile(
                            
                            leading: Icon(Icons.assistant_navigation,size: 20.0,),
                            title: Text('5 km',style: TextStyle(color: Color.fromARGB(255, 62, 174, 180),fontSize: 14.0),),
                          ),
                        ),
                ],),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  elevation: 1.0,
                  child: Column(
                    children: [

                      Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('For 20 overs',style: TextStyle(fontSize: 17.0),),
                            ),
                          ),
                          Align(
                            alignment: Alignment(10.0,0),
                            child: Text('10 a.m.',style: TextStyle(fontSize: 17.0),),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Align(alignment: Alignment.centerLeft,child: Text('Team 1',style: TextStyle(fontSize: 15.0))),
                                Align(alignment:Alignment.centerLeft,child: Text(team1,style: TextStyle(fontSize: 15.0))),
                                Align(
                                  alignment:Alignment.centerLeft,
                                  child: Container(
                                    width: 110.0,
                                    color: Color.fromARGB(255, 211, 219, 226),
                                    child: Align(alignment:Alignment.center,child: Text(available1,style: TextStyle(fontSize: 15.0,color: Colors.black),))),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Align(alignment: Alignment.centerLeft,child: Text('Team 2',style: TextStyle(fontSize: 15.0))),
                                Align(alignment:Alignment.centerLeft,child: Text(team2,style: TextStyle(fontSize: 15.0))),
                                Align(
                                  alignment:Alignment.centerLeft,
                                  child: Container(
                                    width: 110.0,
                                    color: Color.fromARGB(255, 211, 219, 226),
                                    child: Align(alignment:Alignment.center,child: Text(available2,style: TextStyle(fontSize: 15.0,color: Colors.black),))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Ball Provided'),
                          Checkbox(value: ballProvided, onChanged: (bool? value) { },),
                          Text('Umpire Provided'),
                          Checkbox(value: umpireProvided, onChanged: (bool? value) { },),
                          Text('Ball Detail: $ball'),
                          
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListTile(
                              leading: Icon(Icons.currency_rupee),
                              title: Text(cost,style: TextStyle(fontSize: 23.0,color: Color.fromARGB(255, 62, 174, 180)),),
                            ),
                          ),
                           ElevatedButton(
                              onPressed: (){}, child: 
                              Text('Book Now',style: TextStyle(color: Colors.white),),
                              style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 62, 174, 180),maximumSize: Size(170.0,30.0),minimumSize: Size(170.0,30.0)),
                              )
                        ],
                      )
                    ],
                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  elevation: 1.0,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('For 30 overs',style: TextStyle(fontSize: 17.0),),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text('2 p.m.',style: TextStyle(fontSize: 17.0),),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Align(alignment: Alignment.centerLeft,child: Text('Team 1',style: TextStyle(fontSize: 17.0))),
                                Align(alignment:Alignment.centerLeft,child: Text('Mumbai Indians',style: TextStyle(fontSize: 17.0))),
                                Align(
                                  alignment:Alignment.centerLeft,
                                  child: Container(
                                    width: 110.0,
                                    color: Color.fromARGB(255, 211, 219, 226),
                                    child: Align(alignment:Alignment.center,child: Text('Booked',style: TextStyle(fontSize: 15.0,color: Colors.black),))),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Align(alignment: Alignment.centerLeft,child: Text('Team 2',style: TextStyle(fontSize: 17.0))),
                                Align(alignment:Alignment.centerLeft,child: Text('XYZ',style: TextStyle(fontSize: 17.0))),
                                Align(
                                  alignment:Alignment.centerLeft,
                                  child: Container(
                                    width: 110.0,
                                    color: Color.fromARGB(255, 211, 219, 226),
                                    child: Align(alignment:Alignment.center,child: Text('Available',style: TextStyle(fontSize: 15.0,color: Colors.black),))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Ball Provided'),
                          Checkbox(value: true, onChanged: (bool? value) { },),
                          Text('Umpire Provided'),
                          Checkbox(value: false, onChanged: (bool? value) { },),
                          Text('Ball Detail: Cosco'),
                        
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListTile(
                              leading: Icon(Icons.currency_rupee),
                              title: Text('2000',style: TextStyle(fontSize: 23.0,color: Color.fromARGB(255, 62, 174, 180)),),
                            ),
                          ),
                           ElevatedButton(
                              onPressed: (){}, child: 
                              Text('Book Now',style: TextStyle(color: Colors.white),),
                              style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 62, 174, 180),maximumSize: Size(170.0,30.0),minimumSize: Size(170.0,30.0)),
                              )
                        ],
                      )
                    ],
                    ),
                ),
              ),
            ],
              ),
          ),
        ),
      );}
    );
  }


}