import 'dart:io';
import 'dart:typed_data';
import 'package:auth_login_app/views/contacts/models/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:contacts_service/contacts_service.dart';

class ContactsFirebaseHelper {
  ContactsFirebaseHelper._();
  static ContactsFirebaseHelper helper = ContactsFirebaseHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  final String usersCollectionName = 'Contacts';

  Future<String> addContact(ContactModel contact) async {
    File file = contact.file;
    String uploadedImageUrl = await uploadContactImage(file);
    contact.imageUrl = uploadedImageUrl;

    firestore.collection(usersCollectionName).add(contact.toMap());
  }

  Future<String> uploadContactImage(File file) async {
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    String fullPath = 'Contacts/$fileName';
    Reference refrence = storage.ref(fullPath);
    TaskSnapshot task = await refrence.putFile(file);
    String imageUrl = await refrence.getDownloadURL();
    return imageUrl;
  }

  Future<List<ContactModel>> getAllContacts() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await firestore.collection(usersCollectionName).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        querySnapshot.docs;
    // print(documents.first.data());
    List<ContactModel> contactList=  documents.map((e) {
      String id = e.id;
      Map map = e.data();
      map['id'] = id;
      return  ContactModel.fromJson(map);
    }).toList();
    return contactList;
  }

  editContact(ContactModel contactModel) async {
    firestore.collection(usersCollectionName).doc(contactModel.id).update(contactModel.toMap());

  }
  deleteContact(ContactModel contactModel) async {
    firestore.collection(usersCollectionName).doc(contactModel.id).delete();
  }

  ////////////////
// Get all contacts on device
 Future<Iterable<Contact>> getContacts()async {
    // Iterable<Contact> contacts = await ContactsService.getContacts();

// Get all contacts without thumbnail (faster)
    Iterable<Contact> contacts = await ContactsService.getContacts(
        withThumbnails: false);
    return contacts;
    // Contact contact=contacts.first;
// // Android only: Get thumbnail for an avatar afterwards (only necessary if `withThumbnails: false` is used)
//     Uint8List avatar = await ContactsService.getAvatar(contact);
//
// // Get contacts matching a string
//     Iterable<Contact> johns = await ContactsService.getContacts(query: "john");

// Add a contact
// The contact must have a firstName / lastName to be successfully added
//     await ContactsService.addContact(newContact);

// // Delete a contact
// // The contact must have a valid identifier
//     await ContactsService.deleteContact(contact);
//
// // Update a contact
// // The contact must have a valid identifier
//     await ContactsService.updateContact(contact);
//
// // Usage of the native device form for creating a Contact
// // Throws a error if the Form could not be open or the Operation is canceled by the User
//     await ContactsService.openContactForm();
//
// // Usage of the native device form for editing a Contact
// // The contact must have a valid identifier
// // Throws a error if the Form could not be open or the Operation is canceled by the User
//     await ContactsService.openExistingContact(contact);
  }
}
