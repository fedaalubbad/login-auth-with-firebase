import 'package:auth_login_app/views/contacts/models/contact_model.dart';
import 'package:auth_login_app/views/contacts/widgets/build_contact_widget.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:auth_login_app/views/contacts/backend/contact_firebase.dart';

class ContactPage extends StatelessWidget{
  List<ContactModel> contactModelList;
  Function update,delete;

  ContactPage(this.contactModelList,this.update,this.delete);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('contacts'),),
      body: Container(
          child:ListView.builder(
                  physics: BouncingScrollPhysics(),
                  // itemCount: courses.length,
                  itemCount: contactModelList.length,
                  itemBuilder: (context, index) {
                    return BuildCourseWidget(contactModelList[index],update,delete);
                  },

                )

      ),
    );
  }

}