import 'package:doctorhistory/Screens/Addpatients.dart';
import 'package:doctorhistory/Screens/Controllers/DoctorController.dart';
import 'package:doctorhistory/Screens/Models/PaitentModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Detailspatients extends StatelessWidget {
   var viewModel = Get.put(DoctorController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text("+"),
        onPressed: (){Get.to(Addpaitents());},
      ),
      appBar: AppBar(
        title: Text('Patients'),
      ),
      body: Obx(() {
        if (viewModel.patients.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: viewModel.patients.length,
            itemBuilder: (context, index) {
              PaitentModel patient = viewModel.patients[index];
              return ListTile(
                title: Text(patient.pname),
                subtitle: Text('Age: ${patient.page}'),
                onTap: () {
                  // Handle patient selection
                },
              );
            },
          );
        }
      }),
    );
  }
}
