import 'package:equatable/equatable.dart';

class OpeningHours extends Equatable{
  final String id;
  final String day;
  final num openAt;//string change to num for database
  final num closeAt;//string changed to num for database
  final bool isOpen;

  const OpeningHours({
    required this.id,
    required this.day,
    required this.openAt,
    required this.closeAt,
    required this.isOpen,
  });

  OpeningHours copyWith({
    String? id,
    String? day,
    double? openAt,
    double? closeAt,
    bool? isOpen,
  }) {
    return OpeningHours(
      id: id ?? this.id,
      day: day ?? this.day,
     // openAt: openAt as num ?? this.openAt, //- database
     // closeAt: closeAt as num?? this.closeAt, //- database
      openAt: openAt ?? this.openAt, //- string
      closeAt: closeAt ?? this.closeAt, //- string
      isOpen: isOpen ?? this.isOpen,
    );
  }

  factory OpeningHours.fromSnapshot(Map<String, dynamic> snap) {
    return OpeningHours(
      id: snap['id'].toString(),
      day: snap['day'],
      //openAt: snap['openAt'],
      //closeAt: snap['closeAt'],
      openAt: snap['openAt'] != null ? num.tryParse(snap['openAt'].toString()) ?? 0 : 0,
    closeAt: snap['closeAt'] != null ? num.tryParse(snap['closeAt'].toString()) ?? 0 : 0,
      isOpen: snap['isOpen'],
    );
  }

  @override
  List<Object?> get props => [id, day, openAt, closeAt, isOpen];

  static List<OpeningHours> openingHoursList = const [
    OpeningHours(
      id: '1',
      day: 'Monday',
      openAt: 12.00,//openAt: '09:00',
      closeAt: 24.00,//closeAt: '19:00',
      isOpen: true,
    ),
    OpeningHours(
      id: '2',
      day: 'Tuesday',
      openAt: 09.00,
      closeAt: 19.00,
      isOpen: true,
    ),
    OpeningHours(
      id: '3',
      day: 'Wednesday',
      openAt: 09.00,
      closeAt: 19.00,
      isOpen: true,
    ),
    OpeningHours(
      id: '4',
      day: 'Thursday',
      openAt: 09.00,
      closeAt: 21.00,
      isOpen: true,
    ),
    OpeningHours(
      id: '5',
      day: 'Friday',
      openAt: 09.00,
      closeAt: 21.00,
      isOpen: true,
    ),
    OpeningHours(
      id: '6',
      day: 'Saturday',
      openAt: 09.00,
      closeAt: 19.00,
      isOpen: true,
    ),
    OpeningHours(
      id: '7',
      day: 'Sunday',
      openAt: 10.00,
      closeAt: 18.00,
      isOpen: true,
    ),
  ];
}


/*closeAt: 24 - string
day: Monday - string
id: 2 - string
isOpen: True - boolean
openAt: 12 - string*/