import 'package:equatable/equatable.dart';

enum Class { first, economy, business }

extension ClassX on Class {
  get isFirst => this == Class.first;
  get isEconomy => this == Class.economy;
  get isBusiness => this == Class.business;

  String get valToString {
    if (isFirst) return 'First';
    if (isEconomy) return 'Economy';
    return 'Business';
  }
}

enum FlightStatus { boarding, flying, canceled }

extension FlightStatusX on FlightStatus {
  get isBoarding => this == FlightStatus.boarding;
  get isFlying => this == FlightStatus.flying;
  get isCanceled => this == FlightStatus.canceled;

  String get valToString {
    if (isBoarding) return 'Passengers Boarding ...';
    if (isFlying) return 'Airplain in air';
    return 'Flight canceled';
  }
}

class PlaneTicket extends Equatable {
  final String from;
  final String fromShort;
  final String to;
  final String toShort;
  final String airline;
  final Class flightClass;
  final String airplane;
  final FlightStatus status;

  const PlaneTicket({
    required this.from,
    required this.fromShort,
    required this.to,
    required this.toShort,
    required this.airline,
    required this.flightClass,
    required this.airplane,
    required this.status,
  });

  @override
  List<Object> get props {
    return [
      from,
      fromShort,
      to,
      toShort,
      airline,
      flightClass,
      airplane,
      status,
    ];
  }

  PlaneTicket copyWith({
    String? from,
    String? fromShort,
    String? to,
    String? toShort,
    String? airline,
    Class? flightClass,
    String? airplane,
    FlightStatus? status,
  }) {
    return PlaneTicket(
      from: from ?? this.from,
      fromShort: fromShort ?? this.fromShort,
      to: to ?? this.to,
      toShort: toShort ?? this.toShort,
      airline: airline ?? this.airline,
      flightClass: flightClass ?? this.flightClass,
      airplane: airplane ?? this.airplane,
      status: status ?? this.status,
    );
  }
}
