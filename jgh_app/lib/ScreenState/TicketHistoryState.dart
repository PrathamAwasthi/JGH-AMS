import 'package:flutter/material.dart';


class TicketHistoryState with ChangeNotifier{
  void updateState(){
    notifyListeners();
  }
}