import 'package:auth_login_app/views/contacts/models/contact_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class BuildCourseWidget extends StatelessWidget {
  ContactModel contactModel;
  Function update,delete;
  BuildCourseWidget(this.contactModel,this.update,this.delete);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      InkWell(
        onTap: (){},
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 12),
          child: Container(
            height: size.height * 0.2,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 30.0,
                      offset: Offset(10, 15))
                ]),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [

                  CircleAvatar(radius :40,backgroundImage:NetworkImage(contactModel.imageUrl),

                   ),
                  Container(
                    width: size.width * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contactModel.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.email,
                                color: Colors.black.withOpacity(0.3),
                              ),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Text(
                                contactModel.email,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: 20,
         right: 30,
        child: Container(
          child: InkWell(
            onTap:(){delete(contactModel);},
            child: Icon(Icons.delete,color: Colors.red,size: 30,),
          ),
        ),
      ),
      Positioned(
          right: 30,
          bottom: 30,
        child: Container(
          child: InkWell(
            child: CircleAvatar(backgroundColor:Colors.blue,child: Icon(Icons.edit,color: Colors.white,size: 20,),)
          ),
        ),
      ),
      Positioned(
          right: 80,
          bottom: 30,
        child: Container(
          child: InkWell(
            // onTap: ()async{ launch(contactModel.phoneNo);},
            child: CircleAvatar(backgroundColor:Colors.green,child: Icon(Icons.call,color: Colors.white,size: 20,),)
          ),
        ),
      ),
    ]);
  }
}