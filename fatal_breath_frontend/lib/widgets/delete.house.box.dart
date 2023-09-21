import 'package:fatal_breath_frontend/models/house.model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteHouseBox extends StatelessWidget {
  const DeleteHouseBox({Key? key, required this.house}) : super(key: key);

  final House house;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Image.asset(
                    'assets/images/house_icon.png',
                    scale: 1.7,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(house.name,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Delete'),
                      content: const Text(
                          'Are you sure you want to delete this house?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                height: 25,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text('Delete',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
