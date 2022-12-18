import 'package:flutter/material.dart';

class Ground{
  int? _id;
  String? _imgPath;
  String? _name;
  String? _pitch;
  String? _loc;
  Ground(this._id,this._imgPath,this._name,this._pitch,this._loc);
  double? _distance;
  
  String? _date;
  String? _avail1;
  Ground.available1(this._id,this._date,this._avail1);

  int? _overs;
  int? _time;
  String? _team1;
  String? _team2;
  String? _avail2;
  int? _cost;
  String? _ballProvided;
  String? _umpireProvided;
  String? _ballDetail;
  Ground.available2(this._id,this._date,this._overs,this._time,this._team1,this._team2,this._avail2,this._cost,this._ballProvided,this._umpireProvided,this._ballDetail);

  int? get id=>_id;
  String? get imgPath=>_imgPath;
  String? get name=>_name;
  String? get pitch=>_pitch;
  String? get loc=>_loc;

  String? get date=>_date;
  String? get available1=>_avail1;

  int? get overs=>_overs;
  int? get time=>_time;
  String? get team1=>_team1;
  String? get team2=>_team2;
  String? get available2=>_avail2;
  int? get cost=>_cost;
  String? get ballProvided=>_ballProvided;
  String? get umpireProvided=>_umpireProvided;
  String? get ballDetail=>_ballDetail;

  set imgPath(String? x)
  {
    this._imgPath=x;
  }
  set name(String? x)
  {
    this._name=x;
  }
  set pitch(String? x)
  {
    this._pitch=x;
  }
  set loc(String? x)
  {
    this._loc=x;
  }

  set date(String? x)
  {
    this._date=x;
  }
  set available1(String? x)
  {
    this._avail1=x;
  }

  set overs(int? x)
  {
    this._overs=x;
  }
  set time(int? x)
  {
    this._time=x;
  }
  set team1(String? x)
  {
    this._team1=x;
  }
  set team2(String? x)
  {
    this._team2=x;
  }
  set available2(String? x)
  {
    this._avail2=x;
  }
  set cost(int? x)
  {
    this._cost=x;
  }
  set ballProvided(String? x)
  {
    this._ballProvided=x;
  }
  set umpireProvided(String? x)
  {
    this._umpireProvided=x;
  }
  set ballDetail(String? x)
  {
    this._ballDetail=x;
  }



  Map<String,dynamic> toMapGround()
  {
    var map=Map<String,dynamic>();
    if(_id!=null)
    {
      map['id']=_id;
    }
    map['imgPath']=_imgPath;
    map['name']=_name;
    map['pitch']=_pitch;
    map['loc']=_loc;
    return map;
  }
  Map<String,dynamic> toMapAvailable1()
  {
    var map=Map<String,dynamic>();
    map['id']=_id;
    map['date']=_date;
    map['available1']=_avail1;
    return map;
  }
  Map<String,dynamic> toMapAvailable2()
  {
    var map=Map<String,dynamic>();
    map['id']=_id;
    map['date']=_date;
    map['overs']=_overs;
    map['time']=_time;
    map['team1']=_team1;
    map['team2']=_team2;
    map['available2']=_avail2;
    map['cost']=_cost;
    map['ballProvided']=_ballProvided;
    map['umpireProvided']=_umpireProvided;
    map['ballDetail']=_ballDetail;
    return map;
  }

  Ground.fromMapObjectGround(Map<String,dynamic> map)
  {
    _id=map['id'];
    _imgPath=map['imgPath'];
    _name=map['name'];
    _pitch=map['pitch'];
    _loc=map['loc'];
  }
  Ground.fromMapObjectAvailable1(Map<String,dynamic> map)
  {
    _id=map['id'];
    _date=map['date'];
    _avail1=map['available1'];
  }
  Ground.fromMapObjectAvailable2(Map<String,dynamic> map)
  {
    _id=map['id'];
    _date=map['date'];
    _overs=map['overs'];
    _time=map['time'];
    _team1=map['team1'];
    _team2=map['team2'];
    _avail2=map['available2'];
    _cost=map['cost'];
    _ballProvided=map['ballProvided'];
    _umpireProvided=map['umpireProvided'];
    _ballDetail=map['ballDetail'];
  }
}