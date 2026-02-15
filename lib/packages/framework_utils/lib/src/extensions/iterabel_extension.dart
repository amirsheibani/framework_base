extension IterabelExtension on Iterable?{
  String toDayName(){
    StringBuffer stringBuffer = StringBuffer();
    this?.forEach((element) {
      if(element is int){
        stringBuffer.write(', ');
        switch(element){
          case 1:
            stringBuffer.write('MONDAY');
            break;
          case 2:
            stringBuffer.write('TUESDAY');
            break;
          case 3:
            stringBuffer.write('WEDNESDAY');
            break;
          case 4:
            stringBuffer.write('THURSDAY');
            break;
          case 5:
            stringBuffer.write('FRIDAY');
            break;
          case 6:
            stringBuffer.write('SATURDAY');
            break;
          case 7:
            stringBuffer.write('SUNDAY');
            break;
          default:
            stringBuffer.write('unKnow day');
            break;
        }
      }
      if(element is String){
        stringBuffer.write(', ');
        switch(element){
          case '1':
            stringBuffer.write('MONDAY');
            break;
          case '2':
            stringBuffer.write('TUESDAY');
            break;
          case '3':
            stringBuffer.write('WEDNESDAY');
            break;
          case '4':
            stringBuffer.write('THURSDAY');
            break;
          case '5':
            stringBuffer.write('FRIDAY');
            break;
          case '6':
            stringBuffer.write('SATURDAY');
            break;
          case '7':
            stringBuffer.write('SUNDAY');
            break;
          default:
            stringBuffer.write('unKnow day');
            break;
        }
      }
    });
    return stringBuffer.toString().replaceFirst(', ', '');
  }

  String? iterableToString(){
    if(this != null){
      StringBuffer stringBuffer = StringBuffer();
      stringBuffer.writeAll(this!);
      return stringBuffer.toString();
    }
    return null;
  }
}