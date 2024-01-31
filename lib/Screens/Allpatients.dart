import 'package:doctorhistory/Screens/Addpatients.dart';
import 'package:doctorhistory/Screens/Controllers/DoctorController.dart';
import 'package:doctorhistory/Screens/Detailpatients.dart';
import 'package:doctorhistory/Screens/Models/PaitentModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Allpatients extends StatelessWidget {
  var viewModel = Get.put(DoctorController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
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
              return Card(
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                  title: Text(patient.pname),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Age: ${patient.page}'),
                      Text('Phone: ${patient.pphone}'),
                      Text('Createddate: ${patient.createdate}'),
                    ],
                  ),
                  onTap: () {
                    // Handle patient selection
                    Get.to(DetailPaitent(model: patient,));
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
