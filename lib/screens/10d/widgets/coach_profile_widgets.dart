import 'package:flutter/material.dart';

import '../../../widgets/coaching_widgets.dart';

class ContractCard extends StatelessWidget {
  const ContractCard({super.key});

  @override
  Widget build(BuildContext context) => UiCard(
    borderColor: const Color(0x99F4877B),
    child: const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Contract',
              style: TextStyle(color: Color(0xFF6B7886), fontSize: 10),
            ),
            StatusPill('Active', positive: true),
          ],
        ),
        SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  '214',
                  style: TextStyle(
                    color: Color(0xFFF4877B),
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 6),
            Text(
              'days left',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(9)),
          child: LinearProgressIndicator(
            value: 0.59,
            minHeight: 5,
            backgroundColor: Color(0xFFE3ECEA),
            color: Color(0xFF5FD0BF),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 7),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Ends May 17, 2027',
                  style: TextStyle(color: Color(0xFF6B7886), fontSize: 8),
                ),
              ),
              Expanded(
                child: Text(
                  'Managed by admin',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Color(0xFF6B7886), fontSize: 8),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
