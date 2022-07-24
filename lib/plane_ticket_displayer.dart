import 'package:airplane_ticket/bloc/cubit/plane_ticket_cubit.dart';
import 'package:airplane_ticket/models/plane_ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

class PlaneTicketDisplayer extends StatelessWidget {
  const PlaneTicketDisplayer._({
    Key? key,
  }) : super(key: key);

  static Widget provider(PlaneTicket planeTicket) {
    return BlocProvider(
      create: ((context) => PlaneTicketCubit(planeTicket)),
      child: const PlaneTicketDisplayer._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        width: size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const _PlaneInfo(),
            const _FlighDirectionDisplayer(),
            const _FlightStatus(),
          ],
        ),
      ),
    );
  }
}

class _PlaneInfo extends StatelessWidget {
  const _PlaneInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final planeTicketCubit = BlocProvider.of<PlaneTicketCubit>(context);
    final planeTicket = planeTicketCubit.state.planeTicket;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          planeTicket.airline,
          height: 35,
          filterQuality: FilterQuality.medium,
        ),
        const Spacer(),
        Chip(
          backgroundColor: Colors.blue[900],
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 18,
          ),
          padding: const EdgeInsets.all(6),
          label: Text(
            planeTicket.flightClass.valToString,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          planeTicket.airplane,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class _FlighDirectionDisplayer extends StatelessWidget {
  const _FlighDirectionDisplayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final planeTicketCubit = BlocProvider.of<PlaneTicketCubit>(context);
    final planeTicket = planeTicketCubit.state.planeTicket;

    return SizedBox(
      height: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationDisplayer(planeTicket.from, planeTicket.fromShort),
          Expanded(
            child: CustomPaint(
              painter: _PlanePainter(),
              size: Size.infinite,
            ),
          ),
          _locationDisplayer(planeTicket.to, planeTicket.toShort),
        ],
      ),
    );
  }

  Widget _locationDisplayer(String longLocation, String shortLocation) {
    return Column(
      key: UniqueKey(),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          shortLocation,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          longLocation,
          style: TextStyle(
            fontSize: 25,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class _PlanePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawDots(canvas, size);
  }

  void _drawDots(Canvas canvas, Size size) {
    final width = size.width * 0.8;
    double radiusSize = 0.0;
    for (int i = 0; i < 9; i++) {
      const double radius = 6;
      double dx = (width / 9) * i + size.width * 0.1;
      dx = dx + radius * 3;

      if (i < 5) {
        radiusSize = radius * (i / 8) + 3;
      } else {
        radiusSize = radiusSize - 0.75;
      }

      canvas.drawCircle(
        Offset(dx, size.height * 0.5),
        radiusSize,
        Paint()..color = i != 4 ? Colors.grey.shade300 : Colors.red,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _FlightStatus extends StatelessWidget {
  const _FlightStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final planeTicketCubit = BlocProvider.of<PlaneTicketCubit>(context);
    final planeTicket = planeTicketCubit.state.planeTicket;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            planeTicket.status.valToString.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomPaint(
                painter: _FlightStatusLinePainter(0.8),
                size: Size(size.width * 0.7, 10),
              ),
              Spacer(),
              const Icon(
                Icons.nordic_walking,
                size: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FlightStatusLinePainter extends CustomPainter {
  final double progress;

  const _FlightStatusLinePainter(this.progress);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(
            0,
            0,
            size.width * (progress - 0.01),
            size.height,
          ),
          const Radius.circular(20)),
      Paint()
        ..shader = ui.Gradient.linear(
          Offset(0, size.height * 0.5),
          Offset(
            size.width * (progress - 0.2),
            size.height * 0.5,
          ),
          [
            Colors.blue.shade800,
            Colors.lightBlue,
          ],
        ),
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width,
            0,
            -size.width * (1 - progress - 0.01),
            size.height,
          ),
          const Radius.circular(20)),
      Paint()..color = Colors.grey.shade400,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
