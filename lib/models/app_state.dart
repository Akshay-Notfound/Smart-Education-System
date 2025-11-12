import 'package:smart_education_system/models/student.dart';
import 'package:smart_education_system/models/election.dart';
import 'package:smart_education_system/models/application.dart';
import 'package:smart_education_system/models/complaint.dart';
import 'package:smart_education_system/models/budget.dart';
import 'package:smart_education_system/models/facility.dart';
import 'package:smart_education_system/models/cheating_record.dart';

class AppState {
  // Current logged in student
  Student? currentStudent;
  
  // Elections
  List<Election> elections;
  
  // Applications
  List<Application> applications;
  
  // Complaints
  List<Complaint> complaints;
  
  // Budgets
  List<Budget> budgets;
  
  // Facilities
  List<Facility> facilities;
  
  // Cheating Records
  List<CheatingRecord> cheatingRecords;

  AppState({
    this.currentStudent,
    this.elections = const [],
    this.applications = const [],
    this.complaints = const [],
    this.budgets = const [],
    this.facilities = const [],
    this.cheatingRecords = const [],
  });

  // Check if student is logged in
  bool get isLoggedIn => currentStudent != null;

  // Get active elections
  List<Election> get activeElections => 
      elections.where((election) => election.isActive).toList();

  // Get pending applications
  List<Application> get pendingApplications => 
      applications.where((app) => app.status == ApplicationStatus.pending).toList();

  // Get approved budgets
  List<Budget> get approvedBudgets => 
      budgets.where((budget) => budget.allocatedAmount > 0).toList();

  // Get available facilities
  List<Facility> get availableFacilities => facilities;

  // Get visible complaints
  List<Complaint> get visibleComplaints => 
      complaints.where((complaint) => complaint.isVisible).toList();

  // Get public cheating records
  List<CheatingRecord> get publicCheatingRecords => 
      cheatingRecords.where((record) => record.isPublic).toList();

  // Add a new election
  void addElection(Election election) {
    elections = [...elections, election];
  }

  // Add a new application
  void addApplication(Application application) {
    applications = [...applications, application];
  }

  // Add a new complaint
  void addComplaint(Complaint complaint) {
    complaints = [...complaints, complaint];
  }

  // Add a new budget
  void addBudget(Budget budget) {
    budgets = [...budgets, budget];
  }

  // Add a new facility
  void addFacility(Facility facility) {
    facilities = [...facilities, facility];
  }

  // Add a new cheating record
  void addCheatingRecord(CheatingRecord record) {
    cheatingRecords = [...cheatingRecords, record];
  }

  // Vote in an election
  void voteInElection(String electionId, String candidateId, String studentId) {
    final electionIndex = elections.indexWhere((e) => e.id == electionId);
    if (electionIndex != -1) {
      final election = elections[electionIndex];
      
      // Check if student has already voted
      if (election.votedStudents.contains(studentId)) {
        return;
      }
      
      // Add student to voted list
      final updatedVotedStudents = [...election.votedStudents, studentId];
      
      // Update candidate votes
      final updatedCandidates = <Candidate>[];
      for (var candidate in election.candidates) {
        if (candidate.id == candidateId) {
          updatedCandidates.add(Candidate(
            id: candidate.id,
            studentId: candidate.studentId,
            name: candidate.name,
            manifesto: candidate.manifesto,
            votes: candidate.votes + 1,
          ));
        } else {
          updatedCandidates.add(candidate);
        }
      }
      
      // Update election
      final updatedElection = Election(
        id: election.id,
        title: election.title,
        description: election.description,
        startDate: election.startDate,
        endDate: election.endDate,
        candidates: updatedCandidates,
        isActive: election.isActive,
        votedStudents: updatedVotedStudents,
      );
      
      // Replace election in list
      final updatedElections = [...elections];
      updatedElections[electionIndex] = updatedElection;
      elections = updatedElections;
    }
  }
}