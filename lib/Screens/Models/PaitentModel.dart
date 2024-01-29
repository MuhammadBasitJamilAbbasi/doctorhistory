class PaitentModel {
  String pname, pphone, page, createdate;

  PaitentModel(
      {required this.pname, required this.pphone, required this.page, required this.createdate});

  // Method to convert PaitentModel to a map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'pname': pname,
      'pphone': pphone,
      'page': page,
      'createdate': createdate,
    };
  }




  factory PaitentModel.fromJson(Map<String, dynamic> map) {
    return PaitentModel(
        pname : map['pname'],
        pphone : map['pphone'],
        page : map['page'],
        createdate : map['createdate']
    );
  }
}
