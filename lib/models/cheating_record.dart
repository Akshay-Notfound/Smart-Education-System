class CheatingRecord {
  final String id;
  final String studentId;
  final String studentName;
  final String enrollmentNumber;
  final String reason;
  final String proofDescription;
  final DateTime incidentDate;
  final String reportedBy;
  final String? proofImageUrl;
  final bool isPublic;

  CheatingRecord({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.enrollmentNumber,
    required this.reason,
    required this.proofDescription,
    required this.incidentDate,
    required this.reportedBy,
    this.proofImageUrl,
    this.isPublic = true,
  });

  factory CheatingRecord.fromJson(Map<String, dynamic> json) {
    return CheatingRecord(
      id: json['id'],
      studentId: json['studentId'],
      studentName: json['studentName'],
      enrollmentNumber: json['enrollmentNumber'],
      reason: json['reason'],
      proofDescription: json['proofDescription'],
      incidentDate: DateTime.parse(json['incidentDate']),
      reportedBy: json['reportedBy'],
      proofImageUrl: json['proofImageUrl'],
      isPublic: json['isPublic'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'studentName': studentName,
      'enrollmentNumber': enrollmentNumber,
      'reason': reason,
      'proofDescription': proofDescription,
      'incidentDate': incidentDate.toIso8601String(),
      'reportedBy': reportedBy,
      'proofImageUrl': proofImageUrl,
      'isPublic': isPublic,
    };
  }
}