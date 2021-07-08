import 'package:flutter/material.dart' hide Colors;
import 'package:freed/value/Colors.dart';

class ViewRequest extends StatelessWidget {
  final recordId;

  ViewRequest({Key? key, @required this.recordId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              shadowColor: Colors.transparent,
              leadingWidth: 70,
              leading: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Back",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w700),
                    )),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 15),
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Header(),
                  SizedBox(height: 15),
                  DetailedCard(),
                  SizedBox(height: 20),
                  ReasonExpendedCard(),
                  SizedBox(height: 50),
                  CancelButton(),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 35),
      child: ElevatedButton(
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Cancel Request",
            style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.w400,
                fontSize: 18.0,
                color: Colors.default_color),
          ),
        ),
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
            side: MaterialStateProperty.all(
                BorderSide(color: Colors.gray, width: 2.0)),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shadowColor: MaterialStateProperty.all(Colors.transparent)),
      ),
    );
  }
}

class ReasonExpendedCard extends StatelessWidget {
  const ReasonExpendedCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.gray),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              "Reason for leave",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  color: Colors.black),
            ),
            childrenPadding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            children: [
              Text(
                "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae.",
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w300,
                    fontSize: 16.0,
                    color: Colors.default_color),
              )
            ],
          ),
        ));
  }
}

class DetailedCard extends StatelessWidget {
  const DetailedCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "From",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  color: Colors.black),
            ),
            Text(
              "To",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  color: Colors.black),
            )
          ]),
          SizedBox(
            height: 5,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "20 May 2021",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  color: Colors.black),
            ),
            Text(
              "20 May 2021",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  color: Colors.black),
            )
          ]),
          SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Destination",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Ahmedabad, Gujarat",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w300,
                  fontSize: 16.0,
                  color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text("Leave Application",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  color: Colors.black)),
          SizedBox(
            height: 5,
          ),
          Text("RID1024",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 22.0,
                  color: Colors.default_color)),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 85,
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Align(
              child: Text(
                "Regular",
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0), color: Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Aman Vishwakarma",
            style: TextStyle(
                fontFamily: 'roboto',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          Text(
            "B.tech CSE - 6",
            style: TextStyle(
                fontFamily: 'roboto',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          )
        ],
      ),
    );
  }
}
