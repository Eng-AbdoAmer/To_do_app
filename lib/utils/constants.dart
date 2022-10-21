import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const DB_NAME="notes.db";
const DB_version=1;
const TABLE_NAME='notes'; 


// name column in note table
const COL_ID='noteId';
const COL_TEXT='title';
const Col_Date='date';
const Col_Time='time';

const sizeH=SizedBox(height: 10,);
const sizeW=SizedBox(width: 10,);

const myYello=Color.fromARGB(255, 216, 221, 142);
const myPink=Color.fromARGB(255, 245, 96, 146);