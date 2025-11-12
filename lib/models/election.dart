class Election {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<Candidate> candidates;
  final bool isActive;
  final List<String> votedStudents; // List of student IDs who have voted

  Election({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.candidates,
    this.isActive = false,
    this.votedStudents = const [],
  });

  factory Election.fromJson(Map<String, dynamic> json) {
    var candidatesList = json['candidates'] as List;
    List<Candidate> candidates = candidatesList.map((c) => Candidate.fromJson(c)).toList();

    var votedStudentsList = json['votedStudents'] as List? ?? [];
    List<String> votedStudents = votedStudentsList.map((s) => s.toString()).toList();

    return Election(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      candidates: candidates,
      isActive: json['isActive'] ?? false,
      votedStudents: votedStudents,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'candidates': candidates.map((c) => c.toJson()).toList(),
      'isActive': isActive,
      'votedStudents': votedStudents,
    };
  }
}

class Candidate {
  final String id;
  final String studentId;
  final String name;
  final String manifesto;
  final int votes;

  Candidate({
    required this.id,
    required this.studentId,
    required this.name,
    required this.manifesto,
    this.votes = 0,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['id'],
      studentId: json['studentId'],
      name: json['name'],
      manifesto: json['manifesto'],
      votes: json['votes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'name': name,
      'manifesto': manifesto,
      'votes': votes,
    };
  }
}