import 'package:equatable/equatable.dart';

class OpeningHours extends Equatable{
  final String id;
  final String day;
  final String openAt;
  final String closeAt;
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
    String? openAt,
    String? closeAt,
    bool? isOpen,
  }) {
    return OpeningHours(
      id: id ?? this.id,
      day: day ?? this.day,
      openAt: openAt ?? this.openAt,
      closeAt: closeAt ?? this.closeAt,
      isOpen: isOpen ?? this.isOpen,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'day': day,
      'openAt': openAt,
      'closeAt': closeAt,
      'isOpen': isOpen,
    };
  }

  factory OpeningHours.fromSnapshot(Map<String, dynamic> snap) {
    return OpeningHours(
      id: snap['id'].toString(),
      day: snap['day'],
      openAt: snap['openAt'],
      closeAt: snap['closeAt'],
      isOpen: snap['isOpen'],
    );
  }

  @override
  List<Object?> get props => [id, day, openAt, closeAt, isOpen];

  static List<OpeningHours> openingHoursList = const [
    OpeningHours(
      id: '1',
      day: 'Monday',
      openAt: '09:00',
      closeAt: '19:00',
      isOpen: true,
    ),
    OpeningHours(
      id: '2',
      day: 'Tuesday',
      openAt: '09:00',
      closeAt: '19:00',
      isOpen: true,
    ),
    OpeningHours(
      id: '3',
      day: 'Wednesday',
      openAt: '09:00',
      closeAt: '19:00',
      isOpen: true,
    ),
    OpeningHours(
      id: '4',
      day: 'Thursday',
      openAt: '09:00',
      closeAt: '21:00',
      isOpen: true,
    ),
    OpeningHours(
      id: '5',
      day: 'Friday',
      openAt: '09:00',
      closeAt: '21:00',
      isOpen: true,
    ),
    OpeningHours(
      id: '6',
      day: 'Saturday',
      openAt: '09:00',
      closeAt: '19:00',
      isOpen: true,
    ),
    OpeningHours(
      id: '7',
      day: 'Sunday',
      openAt: '10:00',
      closeAt: '18:00',
      isOpen: true,
    ),
  ];
}