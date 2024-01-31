import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorhistory/Screens/Controllers/DoctorController.dart';
import 'package:doctorhistory/Screens/widgets/Snakebar.dart';
import 'package:doctorhistory/Screens/widgets/TakepictureScreen.dart';
import 'package:doctorhistory/Screens/widgets/app_text_form.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
class Addvisitissues extends StatefulWidget {
  String id;
  Addvisitissues({required this.id});
  @override
  State<Addvisitissues> createState() => _AddvisitissuesState();
}

class _AddvisitissuesState extends State<Addvisitissues> {
  TextEditingController patientnameController = TextEditingController();
  TextEditingController paitentphoneController = TextEditingController();
  TextEditingController paitentageController = TextEditingController();

  var controller_ = Get.put(DoctorController());
  String selectedDate = "";

  // Show progress dialog

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime lastSelectableDate = currentDate.subtract(Duration(days: 25));
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: lastSelectableDate,
      lastDate: currentDate,
    );

    if (picked != null && picked != currentDate) {
      selectedDate = '${picked}'.split(' ')[0];
      setState(() {});
    }
  }

  // Function to upload image to Firebase Storage
  Future<String> _uploadImageToStorage(File imageFile) async {
    try {
      DateTime currentDate = DateTime.now();
      String name=currentDate.toString()+'.jpg';
      // Create a reference to the location you want to upload to in Firebase Storage
      var storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('visits')
          .child(name);

      // Upload the file to Firebase Storage
      await storageRef.putFile(imageFile);

      // Return the download URL
      return await storageRef.getDownloadURL();
    } catch (e) {
      // Error uploading image
      print(e.toString());
      return '';
    }
  }

  // Function to save image URL and metadata to Cloud Firestore
  Future<void> _saveImageToFirestore(String imageUrl,String pid) async {
    try {

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      var collectionRef = firestore.collection('CHECKUPS');
      var docRef = collectionRef.doc(pid);
      // await docRef.set({
      //   'pid': pid,
      // });
      var subCollectionRef = docRef.collection('CHECKIN');
      await subCollectionRef.add({
        'pid':pid,
        'issue': patientnameController.text,
        'special_instruction': paitentphoneController.text,
        'Entry date': selectedDate,
        'image_url': imageUrl,
        // Add any other fields for the sub-document
      });

    } catch (e) {
      // Error saving to Firestore
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog _progressDialog = ProgressDialog(context: context);
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Visit',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Summary',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              AppTextFormField(
                labelText: 'Issue',

                keyboardType: TextInputType.name,


                controller: patientnameController,
              ),
              AppTextFormField(
                controller:paitentphoneController ,
                keyboardType: TextInputType.text,
                labelText: 'Special Instruction',
              ),
              // Add your text form fields here
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: selectedDate.isNotEmpty
                            ? Text(
                          selectedDate,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 8,
                          ),
                        )
                            : Text(
                          "Please Select Transaction Date",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                      print(image!.path.toString());
                      controller_.imageurl = image!.path.toString();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(color: Colors.white),
                    ),
                    child: Text("Attach Photo"),
                  ),
                  InkWell(
                    onTap: () async {
                      Get.to(DisplayPictureScreen( imagePath: controller_.imageurl,));
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: controller_.imageurl.isNotEmpty
                          ? Image.file(
                        File(controller_.imageurl),
                        fit: BoxFit.cover,
                      )
                          : const Center(
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "No Image Taken",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Add your submit button here
              ElevatedButton(
                onPressed: () async {
                  if (patientnameController.text.isEmpty) {
                    showErrorMessage("Please Enter summary", context);
                  }
                  else if(selectedDate.isEmpty){
                    showErrorMessage("Please Select date of Entry",context);

                  }else {

                    if (controller_.imageurl.isNotEmpty) {
                      _progressDialog.show(msg: "Sending Wait...");
                      // Upload image to Firebase Storage
                      String imageUrl = await _uploadImageToStorage(File(controller_.imageurl));
                      // Save image URL and metadata to Cloud Firestore
                      if (imageUrl.isNotEmpty) {
                        _saveImageToFirestore(imageUrl,
                            widget.id

                        );
                      }
                      _progressDialog.close();

                      Get.back();
                    }
                    else{
                      showErrorMessage("Add Image", context);
                    }
                    // Do whatever you need to do on form submission

                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
