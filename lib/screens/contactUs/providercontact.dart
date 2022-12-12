import 'package:flutter/cupertino.dart';
import 'package:validators/validators.dart';

class Contactprovider extends ChangeNotifier {

  bool focusedmsg = false;
  bool focusname = false;
  bool focusmail = false;
  bool focusedsub = false;


 bool isemailcorrect = false;
  bool subcontrolercrt = false;
  bool messagecontrolercrt = false;
  bool suffixchange = false;
  bool isnameiscrt = false;


  void focusnametrfn(bool value){
    focusname=value;
    notifyListeners();
  }
    void focusmailfn(bool value){
    focusmail=value;
    notifyListeners();
  }
  void focussubfn(bool value){
    focusedsub=value;
    notifyListeners();
  }
    void focusmsgfn(bool value){
    focusedmsg=value;
    notifyListeners();
  }
   onpressed(bool value){
       focusedmsg = value;
   focusname = value;
   focusmail = value;
   focusedsub = value;
notifyListeners();
  }
void  isnameiscrfn(value){
       isnameiscrt = isByteLength(value, 2, 15);
       notifyListeners();
}
void  ismailiscrtfn(value){
       isemailcorrect = isEmail(value);
       notifyListeners();
}
void issubiscrtfn(val){
   subcontrolercrt = isByteLength(val, 2, 40);
   notifyListeners();
}
void msgiscrtfn(val){
  messagecontrolercrt = isByteLength(val, 4, 100);
   notifyListeners();
} 
void  start(){
  messagecontrolercrt=false;
  subcontrolercrt=false;
  isemailcorrect=false;
  isnameiscrt=false;
}

}