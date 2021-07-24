import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:s2_international/screens/control/contacts_details.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  Iterable<Contact> _contacts;
  List<Contact> _contactss;

  // Future<PermissionStatus> _getPermission() async {
  //   final PermissionStatus permission = await Permission.contacts.status;
  //   if (permission != PermissionStatus.granted &&
  //       permission != PermissionStatus.denied) {
  //     final Map<Permission, PermissionStatus> permissionStatus =
  //         await [Permission.contacts].request();
  //     return permissionStatus[Permission.contacts] ??
  //         PermissionStatus.undetermined;
  //   } else {
  //     return permission;
  //   }
  // }

  void contactOnDeviceHasBeenUpdated(Contact contact) {
    this.setState(() {
      var id = _contactss.indexWhere((c) => c.identifier == contact.identifier);
      _contactss[id] = contact;
    });
  }

  // load() async {
  //   final PermissionStatus permissionStatus = await _getPermission();

  //   if (permissionStatus == PermissionStatus.granted) {
  //     //We can now access our contacts here
  //   } else {
  //     Get.defaultDialog(
  //         title: 'Permissions error',
  //         content: Text('Please enable contacts access '
  //             'permission in system settings'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Get.back(),
  //             child: Text("ok"),
  //           ),
  //         ]);
  //   }
  // }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  @override
  Widget build(BuildContext context) {
    var WIDTH = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Contacts",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(LineIcons.list, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CustomPaint(
              size: Size(
                  WIDTH,
                  (WIDTH * 1.525)
                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RPSCustomPainter(),
            ),
          ),
          _contacts != null
              //Build a list view of all contacts, displaying their avatar and
              // display name
              ? ListView.builder(
                  itemCount: _contacts?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    Contact contact = _contacts?.elementAt(index);
                    return ListTile(
                      onTap: () => Get.to(ContactDetailsPage( 
                        contact,
                        onContactDeviceSave: contactOnDeviceHasBeenUpdated,
                      )),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 18),
                      leading: (contact.avatar != null &&
                              contact.avatar.isNotEmpty)
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(contact.avatar),
                            )
                          : CircleAvatar(
                              child: Text(contact.initials()),
                              backgroundColor: Theme.of(context).accentColor,
                            ),
                      title: Text(
                        contact.displayName ?? '',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // subtitle: Text(
                      //   contact.phones.first ?? '',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      //This can be further expanded to showing contacts detail
                      // onPressed().
                    );
                  },
                )
              : Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Colors.blue[50]
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.0040000);
    path_0.quadraticBezierTo(size.width * 0.4931250, size.height * 0.1015000,
        size.width * 0.5000000, size.height * 0.4980000);
    path_0.quadraticBezierTo(size.width * 0.5009375, size.height * 0.9030000,
        size.width * 0.0012500, size.height * 0.9980000);
    path_0.cubicTo(
        size.width * 0.0015625,
        size.height * 0.7485000,
        size.width * -0.0034375,
        size.height * 0.7505000,
        0,
        size.height * 0.0040000);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
