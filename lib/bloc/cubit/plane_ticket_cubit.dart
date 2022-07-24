import 'package:airplane_ticket/models/plane_ticket.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'plane_ticket_state.dart';

class PlaneTicketCubit extends Cubit<PlaneTicketState> {
  PlaneTicketCubit(PlaneTicket planeTicket) : super(PlaneTicketState(planeTicket: planeTicket));
}
