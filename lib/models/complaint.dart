class Complaint {
  final String id;
  final String title;
  final String description;
  final String? complainantId; // Null for anonymous complaints
  final String? complainantName; // Null for anonymous complaints
  final DateTime submittedDate;
  final bool isAnonymous;
  final bool isModerated;
  final bool isVisible; // After moderation
  final ComplaintStatus status;
  final bool identityRevealed; // If revealed by board members

  Complaint({
    required this.id,
    required this.title,
    required this.description,
    this.complainantId,
    this.complainantName,
    required this.submittedDate,
    this.isAnonymous = true,
    this.isModerated = false,
    this.isVisible = false,
    this.status = ComplaintStatus.pending,
    this.identityRevealed = false,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      complainantId: json['complainantId'],
      complainantName: json['complainantName'],
      submittedDate: DateTime.parse(json['submittedDate']),
      isAnonymous: json['isAnonymous'] ?? true,
      isModerated: json['isModerated'] ?? false,
      isVisible: json['isVisible'] ?? false,
      status: ComplaintStatus.values.firstWhere(
        (e) => e.toString() == 'ComplaintStatus.${json['status']}',
        orElse: () => ComplaintStatus.pending,
      ),
      identityRevealed: json['identityRevealed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'complainantId': complainantId,
      'complainantName': complainantName,
      'submittedDate': submittedDate.toIso8601String(),
      'isAnonymous': isAnonymous,
      'isModerated': isModerated,
      'isVisible': isVisible,
      'status': status.toString().split('.').last,
      'identityRevealed': identityRevealed,
    };
  }
}

enum ComplaintStatus {
  pending,
  resolved,
  rejected,
}