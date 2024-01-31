class VisitModel{

  String pid;
  String issue;
  String specialInstruction;
  String entryDate;
  String imageUrl;

  VisitModel({
  required this.pid,
  required this.issue,
  required this.specialInstruction,
  required this.entryDate,
  required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
  return {
  'pid': pid,
  'issue': issue,
  'special_instruction': specialInstruction,
  'entry_date': entryDate,
  'image_url': imageUrl,
  };
  }

  factory VisitModel.fromMap(Map<String, dynamic> map) {
  return VisitModel(
  pid: map['pid'],
  issue: map['issue'],
  specialInstruction: map['special_instruction'],
  entryDate: map['entry_date'], // Assuming entry_date is stored as a Timestamp
  imageUrl: map['image_url'],
  );
  }


}