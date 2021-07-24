import 'package:auto_size_text/auto_size_text.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';
import 'package:s2_international/constants/asset_path.dart';
import 'package:flutter_sms/flutter_sms.dart';

class InviteFriends extends StatefulWidget {
  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  Iterable<Contact> _contacts;

  List<Contact> _contactss;

  void contactOnDeviceHasBeenUpdated(Contact contact) {
    this.setState(() {
      var id = _contactss.indexWhere((c) => c.identifier == contact.identifier);
      _contactss[id] = contact;
    });
  }

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

  Widget inviteContainer() => Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black),
            boxShadow: [
              BoxShadow(
                offset: Offset(4, 8),
                blurRadius: 2,
                spreadRadius: 0,
                color: Colors.blue[50],
              ),
            ]),
        child: AutoSizeText(
          "Get the S2 international calls at the lowest. Invites are sent as sms from you to your friend on your contact",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            LineIcons.arrowLeft,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Invite Friends",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            inviteContainer(),
            SizedBox(height: 100),
            Container(
              margin: EdgeInsets.only(top: 80),
              child: _contacts != null
                  //Build a list view of all contacts, displaying their avatar and
                  // display name
                  ? ListView.builder(
                      itemCount: _contacts?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        Contact contact = _contacts?.elementAt(index);
                        return ListTile(
                          // onTap: () => Get.to(ContactDetailsPage(
                          //   contact,
                          //   onContactDeviceSave: contactOnDeviceHasBeenUpdated,
                          // )),
                          onTap: () {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return SmsDialog(contact: contact);
                                });
                          },
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 18),
                          leading: (contact.avatar != null &&
                                  contact.avatar.isNotEmpty)
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(contact.avatar),
                                )
                              : CircleAvatar(
                                  child: Text(contact.initials()),
                                  backgroundColor:
                                      Theme.of(context).accentColor,
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
                  : Center(child: CircularProgressIndicator()),
            )
          ],
        ),
      ),
    );
  }
}

class SmsDialog extends StatefulWidget {
  final Contact contact;

  const SmsDialog({Key key, this.contact}) : super(key: key);
  @override
  _SmsDialogState createState() => _SmsDialogState();
}

class _SmsDialogState extends State<SmsDialog> {
  String roomId = "";
  @override
  void initState() {
    super.initState();
  }

  _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .then(
      (value) => Get.defaultDialog(
        title: "Success",
        content: Text("Invitation sent successfully"),
      ),
    )
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        "Invite",
        style: TextStyle(color: Colors.black),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(sms, height: 200),
          SizedBox(height: 5),
          Text("Send Invite to: "),
          Text(
            widget.contact.displayName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.blue[900],
                child: TextButton(
                  onPressed: () {
                    var phone = widget.contact.phones;
                    String message =
                        "Download S2 International Calling App from playstore!";
                    List<String> recipents = [];
                    phone.forEach((element) {
                      recipents.add(element.value);
                    });
                    print(recipents.first);
                    _sendSMS(message, recipents);
                  },
                  child: Text(
                    "Send as sms",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.blue[900],
                child: TextButton(
                  onPressed: () {
                    Share.text('S2 Notice',
                        'Download S2 international calling app', 'text/plain');
                  },
                  child: Text(
                    "Share",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
