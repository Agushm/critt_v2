part of '../services.dart';
class ServiceStorage{
  static firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  static Future<String> uploadImageToFirebase(File imageFile,String email,String fileName) async {
    firebase_storage.Reference reference = storage.ref().child(email).child(fileName);
    firebase_storage.UploadTask uploadTask = reference.putFile(imageFile);
    firebase_storage.TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
    
    return imageUrl;
  }

  static Future<String> uploadBuktiTransferToFirebase(File imageFile,String email,String fileName) async {
    firebase_storage.Reference reference = storage.ref().child(email).child('Bukti_Transfer').child(fileName);
    firebase_storage.UploadTask uploadTask = reference.putFile(imageFile);
    firebase_storage.TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
    
    return imageUrl;
  }
}