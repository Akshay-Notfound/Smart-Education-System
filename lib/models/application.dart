class Application {
  final String id;
  final String title;
  final String description;
  final String applicantId; // Student ID
  final String applicantName;
  final DateTime submittedDate;
  final ApplicationType type;
  final ApplicationStatus status;
  final double? budgetAmount;
  final String? sponsorDetails;
  final Priority priority;
  final DateTime? approvedDate;
  final String? approvedBy; // Authority ID
  final String? remarks;

  Application({
    required this.id,
    required this.title,
    required this.description,
    required this.applicantId,
    required this.applicantName,
    required this.submittedDate,
    required this.type,
    this.status = ApplicationStatus.pending,
    this.budgetAmount,
    this.sponsorDetails,
    this.priority = Priority.normal,
    this.approvedDate,
    this.approvedBy,
    this.remarks,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      applicantId: json['applicantId'],
      applicantName: json['applicantName'],
      submittedDate: DateTime.parse(json['submittedDate']),
      type: ApplicationType.values.firstWhere(
        (e) => e.toString() == 'ApplicationType.${json['type']}',
        orElse: () => ApplicationType.event,
      ),
      status: ApplicationStatus.values.firstWhere(
        (e) => e.toString() == 'ApplicationStatus.${json['status']}',
        orElse: () => ApplicationStatus.pending,
      ),
      budgetAmount: json['budgetAmount'],
      sponsorDetails: json['sponsorDetails'],
      priority: Priority.values.firstWhere(
        (e) => e.toString() == 'Priority.${json['priority']}',
        orElse: () => Priority.normal,
      ),
      approvedDate: json['approvedDate'] != null
          ? DateTime.parse(json['approvedDate'])
          : null,
      approvedBy: json['approvedBy'],
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'applicantId': applicantId,
      'applicantName': applicantName,
      'submittedDate': submittedDate.toIso8601String(),
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'budgetAmount': budgetAmount,
      'sponsorDetails': sponsorDetails,
      'priority': priority.toString().split('.').last,
      'approvedDate':
          approvedDate?.toIso8601String(),
      'approvedBy': approvedBy,
      'remarks': remarks,
    };
  }
}

enum ApplicationType {
  event,
  budget,
  sponsorship,
}

enum ApplicationStatus {
  pending,
  approved,
  rejected,
  inProgress,
}

enum Priority {
  low,
  normal,
  high,
  urgent,
}