import 'package:flutter/material.dart';


class DashboardBox extends StatelessWidget {
  int Number;
  String Value;
  dynamic color;
  DashboardBox(this.Number, this.Value, this.color);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text("${Number}",
              style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(Value,
              style:const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w400
              ),
            ),
            const SizedBox(height: 10,),
            const Align(
              alignment: Alignment.bottomRight,
              child:Text("View",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
