import 'package:flutter/material.dart';

class CustomAddIcon extends StatelessWidget {
  const CustomAddIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 30,
      child: Stack(children: [
        Container(
          width: 38,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        Container(
          width: 38,
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        Center(
          child: Container(
            width: 38,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Icon(Icons.add, color: Colors.black,),
          ),
        )
      ]),
    );
  }
}
