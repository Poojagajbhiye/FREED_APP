import 'package:flutter/material.dart' hide Colors;
import 'package:freed/screen/SignIn.dart';
import 'package:freed/storage/TempStorage.dart';
import 'package:freed/value/Colors.dart';

class StudentProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentProfile();
  }
}

class _StudentProfile extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.yellow,
            automaticallyImplyLeading: false,
            shadowColor: Colors.transparent,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: TextButton(
                    onPressed: () {
                      TempStorage.removePreferences();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                          (route) => false);
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w700),
                    )),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45))),
            child: ProfileForm(),
          ))
        ],
      ),
    );
  }
}

class ProfileForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileForm();
  }
}

class _ProfileForm extends State<ProfileForm> {
  var defCourse;
  var defSemester;
  var defBranch;

  //dropdown lists
  var courseList = ["Diploma", "B.tech", "M.tech"];
  var semesterList = ["1", "2", "3", "4", "5", "6", "7", "8"];
  var branchList = [
    "Civil Engineering",
    "Computer Science and Engineering",
    "Electrical Engineering",
    "Machanical Engineering",
    "Metallurgical and Material Engineering"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0, top: 30.0),
          child: Text(
            "Profile",
            style: TextStyle(
                fontFamily: 'roboto',
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                decoration: TextDecoration.none),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(
                top: 10.0, left: 25.0, right: 25.0, bottom: 50.0),
            children: [
              //first name field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 7.0, bottom: 5.0),
                    child: Text(
                      "First Name",
                      style: TextStyle(
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Colors.default_color),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.gray,
                        borderRadius: BorderRadius.circular(7.0)),
                    child: TextFormField(
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "eg- Roshan",
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 20.0),
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    ),
                  )
                ],
              ),

              SizedBox(
                height: 20.0,
              ),

              //last name field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 7.0, bottom: 5.0),
                    child: Text(
                      "Last Name",
                      style: TextStyle(
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Colors.default_color),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.gray,
                        borderRadius: BorderRadius.circular(7.0)),
                    child: TextFormField(
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "eg- Nahak",
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 20.0),
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    ),
                  )
                ],
              ),

              SizedBox(
                height: 20.0,
              ),

              //email field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 7.0, bottom: 5.0),
                    child: Text(
                      "Email",
                      style: TextStyle(
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Colors.default_color),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.gray,
                        borderRadius: BorderRadius.circular(7.0)),
                    child: TextFormField(
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "eg- abc@gmail.com",
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 20.0),
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    ),
                  )
                ],
              ),

              SizedBox(
                height: 20.0,
              ),

              //course and semester dropdown
              Row(
                children: [
                  //course
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 7.0, bottom: 5.0),
                          child: Text(
                            "Course",
                            style: TextStyle(
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                                color: Colors.default_color),
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                                color: Colors.gray,
                                borderRadius: BorderRadius.circular(7.0)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  right: 5.0,
                                  left: 15.0),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: Text("choose"),
                                underline: DropdownButtonHideUnderline(
                                  child: Container(),
                                ),
                                items: courseList.map((String currentValue) {
                                  return DropdownMenuItem(
                                    child: Text(currentValue),
                                    value: currentValue,
                                  );
                                }).toList(),
                                value: defCourse,
                                onChanged: (value) {
                                  setState(() {
                                    defCourse = value;
                                  });
                                },
                              ),
                            ))
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 20.0,
                  ),

                  //semester
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 7.0, bottom: 5.0),
                          child: Text(
                            "Semester",
                            style: TextStyle(
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                                color: Colors.default_color),
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                                color: Colors.gray,
                                borderRadius: BorderRadius.circular(7.0)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  right: 5.0,
                                  left: 15.0),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: Text("choose"),
                                underline: DropdownButtonHideUnderline(
                                  child: Container(),
                                ),
                                items: semesterList.map((String currentValue) {
                                  return DropdownMenuItem(
                                    child: Text(currentValue),
                                    value: currentValue,
                                  );
                                }).toList(),
                                value: defSemester,
                                onChanged: (value) {
                                  setState(() {
                                    defSemester = value;
                                  });
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 20.0,
              ),

              //Branch dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 7.0, bottom: 5.0),
                    child: Text(
                      "Branch",
                      style: TextStyle(
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Colors.default_color),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.gray,
                          borderRadius: BorderRadius.circular(7.0)),
                      child: Container(
                          width: double.infinity,
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                              color: Colors.gray,
                              borderRadius: BorderRadius.circular(7.0)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, right: 5.0, left: 15.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text("choose"),
                              underline: DropdownButtonHideUnderline(
                                child: Container(),
                              ),
                              items: branchList.map((String currentValue) {
                                return DropdownMenuItem(
                                  child: Text(currentValue),
                                  value: currentValue,
                                );
                              }).toList(),
                              value: defBranch,
                              onChanged: (value) {
                                setState(() {
                                  defBranch = value;
                                });
                              },
                            ),
                          )))
                ],
              ),

              SizedBox(height: 40.0),

              //save profile button
              Container(
                height: 45,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Save Changes",
                    style: TextStyle(
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0)))),
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
