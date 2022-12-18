import 'package:flutter/material.dart';
import 'package:ground/main.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../database_helper.dart';
import '../ground.dart';
import 'ground_details.dart';
import 'package:sqflite/sqflite.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';


class GroundList extends StatefulWidget {
  const GroundList({Key? key}) : super(key: key);

  @override
  State<GroundList> createState() => _GroundListState();
}

class _GroundListState extends State<GroundList> {


  DatabaseHelper databaseHelper=DatabaseHelper();
  List<Ground> groundList=List.empty();
  int count=0;
  var _selectedValue=DateFormat.yMMMEd().format(DateTime.now());

int updateListView(){
  final Future<Database> dbFuture=databaseHelper.initializeDatabase();
  dbFuture.then((database){
    Future<List<Ground>> groundListFuture=databaseHelper.getGroundList();
    groundListFuture.then((groundList){
      setState(() {
        this.groundList=groundList;
        this.count=groundList.length;
        print("C=$count");
      });
    });
  });
  return count;
}
Future<int> addGround() async{
  List<Ground> g=[
  Ground(1,'images/edengardens.jpg','Eden Gardens Stadium','Mat','Kolkata, India'),
  Ground(2,'images/greenpark.jpg','Green Park Stadium','Mat','Kanpur, India'),
  Ground(3,'images/wankhede.jpg','Wankhede Stadium','Mat','Mumbai, India'),
  ];
 List<Ground> g1=[
    Ground.available1(1,'2022-12-18','Y'),
    Ground.available1(1,'2022-12-19','Y'),
    Ground.available1(1,'2022-12-20','Y'),
    Ground.available1(1,'2022-12-21','N'),
    Ground.available1(2,'2022-12-18','Y'),
    Ground.available1(1,'2022-12-18','Y'),
    Ground.available1(3,'2022-12-18','Y'),
  ];
  List<Ground> g2=[
    Ground.available2(1,'2022-12-18',20,10,'Mumbai Indians','Chennai Super Kings','N',5000,'Y','Y','Cosco'),
    Ground.available2(1,'2022-12-18',30,4,'Royal Challengers Banglore','Available','N',5000,'N','Y','Tennis'),
    Ground.available2(1,'2022-12-19',20,10,'Delhi Capitals','Available','N',5000,'N','Y','Cosco'),
    Ground.available2(2,'2022-12-18',20,4,'Punjab Kings','Available','N',5000,'Y','Y','Cosco'),
    Ground.available2(2,'2022-12-19',20,10,'Mumbai Indians','Gujarat Titans','N',5000,'Y','Y','Tennis'),
    Ground.available2(2,'2022-12-19',30,4,'Available','Available','Y',5000,'Y','Y','Rocky'),
    Ground.available2(3,'2022-12-19',20,10,'Mumbai Indians','Chennai Super Kings','N',5000,'Y','Y','Cosco'),
  ];
  for(int i=0;i<g2.length;i++)
  {
    await databaseHelper.insertAvailable2(g2[i]);
  }
  int result=0;
  for(int i=0;i<g.length;i++)
  {
    int c=updateListView();
    if(g[i].id!>c){
      
      result=await databaseHelper.insertGround(g[i]);
    }
  }
  
  return result;
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    addGround();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grounds',style: TextStyle(color: Colors.white)),backgroundColor: Color.fromARGB(255, 62, 174, 180),
      actions: [
        Icon(Icons.search,size: 40.0,),
        Icon(Icons.more_horiz_sharp,size: 40.0,),
      ],
      iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
      
          children: <Widget>[
        DatePicker(
          
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: Color.fromARGB(255, 62, 174, 180),
          selectedTextColor: Colors.white,
          
          onDateChange: (date) {
            // New date selected
            setState(() {
              _selectedValue=DateFormat.yMMMEd().format(date);
              
            });
          },
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: count,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){navigateToDetail(groundList[index], _selectedValue);},
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                              margin: EdgeInsets.all(20.0),
                              child: Image(
                                fit: BoxFit.fill,
                                height: 100.0,
                                width: 100.0,
                                image: AssetImage(groundList[index].imgPath!),
                              ),
                            ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('20 over',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   ElevatedButton(
                                      onPressed: (){},
                                      child: Text('10:00 am',style: TextStyle(fontSize: 9.0),textAlign: TextAlign.start,),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        side: BorderSide(width: 1.2,color: Colors.black),
                                        minimumSize: Size(70.0, 25.0),
                                        maximumSize: Size(70.0, 25.0),
                                        ),
                                    ),
                                    Padding(padding: EdgeInsets.all(10.0)),
                                   ElevatedButton(
                                      onPressed: (){},
                                      child: Text('1:00 pm',style: TextStyle(fontSize: 9.0),textAlign: TextAlign.start,),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        side: BorderSide(width: 1.2,color: Colors.black),
                                        minimumSize: Size(70.0, 25.0),
                                        maximumSize: Size(70.0, 25.0),
                                        ),
                                    ),
                                    Padding(padding: EdgeInsets.all(10.0)),
                                   ElevatedButton(
                                      onPressed: (){},
                                      child: Text('4:00 pm',style: TextStyle(fontSize: 9.0),textAlign: TextAlign.start,),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        side: BorderSide(width: 1.2,color: Colors.black),
                                        minimumSize: Size(70.0, 25.0),
                                        maximumSize: Size(70.0, 25.0),
                                        ),
                                    ),
                                ],
                              ),
                              Text('30 over',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   ElevatedButton(
                                      onPressed: (){},
                                      child: Text('2:00 pm',style: TextStyle(fontSize: 9.0),textAlign: TextAlign.start,),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        side: BorderSide(width: 1.2,color: Colors.black),
                                        minimumSize: Size(70.0, 25.0),
                                        maximumSize: Size(70.0, 25.0),
                                        ),
                                    ),
                                  Padding(padding: EdgeInsets.all(10.0)),
                                   ElevatedButton(
                                      onPressed: (){},
                                      child: Text('4:00 pm',style: TextStyle(fontSize: 9.0),textAlign: TextAlign.start,),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        side: BorderSide(width: 1.2,color: Colors.black),
                                        minimumSize: Size(70.0, 25.0),
                                        maximumSize: Size(70.0, 25.0),
                                        ),
                                    ),
                                ],
                              )
                            ],
                            ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment(-0.84, 0.0),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(groundList[index].name!,style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold),),
                      ),
                      ),
                    Row(
                      children: [
                        Expanded(child: Align(alignment: Alignment(-0.82, 0.0),child: Icon(Icons.location_on_outlined,color: Color.fromARGB(255, 62, 174, 180),))),
                        Expanded(child: Align(alignment: Alignment(-3.6, 0.0),child: Text(groundList[index].loc!,style: TextStyle(fontSize: 14.0,color: Color.fromARGB(255, 62, 174, 180))))),
                      ],
                    ),
                    Divider(color: Color.fromARGB(255, 62, 174, 180),thickness: 0.2,indent: 25.0,endIndent: 25.0,),
                    Row(
                      
                      children: [
                        
                        Expanded(child: Align(alignment: Alignment(0.00, 0.0),child: Text('Pitch Type: '+groundList[index].pitch!,style: TextStyle(fontSize: 14.0)))),
                        
                        Container(
                          width: 115.0,
                        ),
                        Expanded(
                          
                          child: ListTile(
                            
                            leading: Icon(Icons.assistant_navigation),
                            title: Text('Navigate',style: TextStyle(color: Color.fromARGB(255, 62, 174, 180),fontSize: 14.0),),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
          ],
      ),
      ),
    );
  }


void navigateToDetail(Ground ground,var _selectedValue) async{
  bool result=await Navigator.push(context,MaterialPageRoute(builder: (context){
    return GroundDetail(ground,_selectedValue);
  }));
}



}