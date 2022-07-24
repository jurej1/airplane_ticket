import 'package:airplane_ticket/models/plane_ticket.dart';
import 'package:airplane_ticket/plane_ticket_displayer.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(),
      body: Center(
        child: PlaneTicketDisplayer.provider(
          const PlaneTicket(
            airline:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Swiss_International_Air_Lines_Logo_2011.svg/1280px-Swiss_International_Air_Lines_Logo_2011.svg.png',
            from: 'Stockholm',
            fromShort: 'STN',
            to: 'Geneva',
            toShort: 'GVA',
            flightClass: Class.business,
            airplane: 'Airbus A321',
            status: FlightStatus.boarding,
          ),
        ),
      ),
    );
  }
}
