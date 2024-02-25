import 'package:equatable/equatable.dart';

class DeliveryTime  extends Equatable{
  final int id;
  final String value;
  final DateTime time;

  DeliveryTime({
    required this.id,
    required this.value,
    required this.time,
  });
  
  @override
  List<Object?> get props => [id, value, time];

  static List<DeliveryTime> deliveryTimes = [
    DeliveryTime(
      id: 1,
      value: '8:00pm',
      time: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          20,
          0,
        ),
      ),
    
    DeliveryTime(
      id: 2,
      value: '9:00pm',
      time: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          21,
          0,
        ),
      ),
    
    DeliveryTime(
      id: 3,
      value: '10:00pm',
      time: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          22,
          0,
        ),
      ),

      DeliveryTime(
      id: 4,
      value: '11:00pm',
      time: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          23,
          0,
        ),
      ),

     DeliveryTime(
      id: 5,
      value: '12:00pm',
      time: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          0,
          0,
        ),
      ),
      DeliveryTime(
      id: 5,
      value: '12:30pm',
      time: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          0,
          30,
        ),
      ),
    
    
  ];

}