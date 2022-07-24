part of 'plane_ticket_cubit.dart';

class PlaneTicketState extends Equatable {
  const PlaneTicketState({
    required this.planeTicket,
  });

  final PlaneTicket planeTicket;
  @override
  List<Object> get props => [planeTicket];

  PlaneTicketState copyWith({
    PlaneTicket? planeTicket,
  }) {
    return PlaneTicketState(
      planeTicket: planeTicket ?? this.planeTicket,
    );
  }
}
