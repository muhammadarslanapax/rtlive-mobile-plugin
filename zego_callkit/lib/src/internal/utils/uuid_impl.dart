import 'package:uuid/uuid.dart';
import '../../zego_callkit_defines.dart';

class UUIDImpl implements UUID{
  late String uuidString;

  UUIDImpl({String? uuidString_}){
    if(uuidString_ == null){
      uuidString = const Uuid().v4();
    }else{
      uuidString = uuidString_;
    }
  }

  static UUIDImpl getUUID(){
    return UUIDImpl();
  }

  @override
  bool operator==(Object other){
    if(other is UUIDImpl){
      return uuidString == (other).uuidString?true:false;
    }else{
      return false;
    }
  }

  @override
  int get hashCode{
    return uuidString.hashCode;
  }

}