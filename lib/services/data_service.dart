// Mock data service for the Smart Education System
// In a real application, this would connect to a backend API or database

import 'dart:math';
import 'package:smart_education_system/models/student.dart';
import 'package:smart_education_system/models/election.dart';
import 'package:smart_education_system/models/application.dart';
import 'package:smart_education_system/models/complaint.dart';
import 'package:smart_education_system/models/budget.dart';
import 'package:smart_education_system/models/facility.dart';
import 'package:smart_education_system/models/cheating_record.dart';
import 'package:smart_education_system/models/app_state.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  // Mock data storage
  List<Student> _students = [];
  List<Election> _elections = [];
  List<Application> _applications = [];
  List<Complaint> _complaints = [];
  List<Budget> _budgets = [];
  List<Facility> _facilities = [];
  List<CheatingRecord> _cheatingRecords = [];

  // Initialize with sample data
  void initializeData() {
    // Sample students
    _students = [
      Student(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@college.edu',
        rollNumber: 'CS101',
        department: 'Computer Science',
        year: 2,
      ),
      Student(
        id: '2',
        name: 'Jane Smith',
        email: 'jane.smith@college.edu',
        rollNumber: 'EC102',
        department: 'Electronics',
        year: 3,
      ),
      Student(
        id: '3',
        name: 'Robert Johnson',
        email: 'robert.j@college.edu',
        rollNumber: 'ME103',
        department: 'Mechanical',
        year: 1,
      ),
    ];

    // Sample elections
    _elections = [
      Election(
        id: '1',
        title: 'Student Council President Election',
        description: 'Election for the next Student Council President',
        startDate: DateTime.now().subtract(Duration(days: 1)),
        endDate: DateTime.now().add(Duration(days: 5)),
        candidates: [
          Candidate(
            id: '1',
            studentId: '1',
            name: 'John Doe',
            manifesto: 'I will improve campus facilities and organize more events.',
            votes: 0,
          ),
          Candidate(
            id: '2',
            studentId: '2',
            name: 'Jane Smith',
            manifesto: 'Focus on academic excellence and student welfare.',
            votes: 0,
          ),
        ],
        isActive: true,
        votedStudents: [],
      ),
    ];

    // Sample applications
    _applications = [
      Application(
        id: '1',
        title: 'Tech Fest 2025',
        description: 'Annual technical festival organizing request',
        applicantId: '1',
        applicantName: 'John Doe',
        submittedDate: DateTime.now().subtract(Duration(days: 2)),
        type: ApplicationType.event,
        status: ApplicationStatus.pending,
        budgetAmount: 50000.0,
        priority: Priority.high,
      ),
      Application(
        id: '2',
        title: 'Department Budget Request',
        description: 'Request for additional budget for lab equipment',
        applicantId: '2',
        applicantName: 'Jane Smith',
        submittedDate: DateTime.now().subtract(Duration(days: 1)),
        type: ApplicationType.budget,
        status: ApplicationStatus.inProgress,
        budgetAmount: 100000.0,
        priority: Priority.normal,
      ),
    ];

    // Sample complaints
    _complaints = [
      Complaint(
        id: '1',
        title: 'Canteen Food Quality',
        description: 'Food quality in the canteen has deteriorated recently.',
        submittedDate: DateTime.now().subtract(Duration(days: 3)),
        isAnonymous: true,
        isModerated: true,
        isVisible: true,
        status: ComplaintStatus.pending,
      ),
      Complaint(
        id: '2',
        title: 'Library Timing Issue',
        description: 'Library closes too early, need extended hours for exam preparation.',
        submittedDate: DateTime.now().subtract(Duration(days: 1)),
        isAnonymous: false,
        complainantId: '2',
        complainantName: 'Jane Smith',
        isModerated: true,
        isVisible: true,
        status: ComplaintStatus.pending,
      ),
    ];

    // Sample budgets
    _budgets = [
      Budget(
        id: '1',
        title: 'College Annual Budget',
        description: 'Overall college budget for academic year 2025-26',
        allocatedAmount: 5000000.0,
        spentAmount: 2500000.0,
        allocationDate: DateTime.now().subtract(Duration(days: 30)),
        allocatedBy: 'Dr. Principal',
        expenses: [
          Expense(
            id: '1',
            description: 'Library Books Purchase',
            amount: 500000.0,
            expenseDate: DateTime.now().subtract(Duration(days: 25)),
            receiptUrl: 'https://example.com/receipt1.jpg',
            approvedBy: 'Librarian',
            budgetId: '1',
          ),
        ],
        type: BudgetType.college,
      ),
      Budget(
        id: '2',
        title: 'Mess Budget',
        description: 'Monthly mess budget for student meals',
        allocatedAmount: 200000.0,
        spentAmount: 150000.0,
        allocationDate: DateTime.now().subtract(Duration(days: 30)),
        allocatedBy: 'Mess Committee',
        expenses: [],
        type: BudgetType.mess,
      ),
    ];

    // Sample facilities
    _facilities = [
      Facility(
        id: '1',
        name: 'Main Auditorium',
        description: 'Large capacity auditorium for events and ceremonies',
        type: FacilityType.auditorium,
        capacity: 500,
        location: 'Main Building, Ground Floor',
        bookings: [
          Booking(
            id: '1',
            facilityId: '1',
            bookedBy: '1',
            bookedByName: 'John Doe',
            bookingDate: DateTime.now().subtract(Duration(days: 5)),
            startTime: DateTime.now().add(Duration(days: 2, hours: 10)),
            endTime: DateTime.now().add(Duration(days: 2, hours: 13)),
            purpose: 'Tech Fest Inauguration',
            status: BookingStatus.approved,
            approvedBy: 'Admin',
            approvedDate: DateTime.now().subtract(Duration(days: 4)),
          ),
        ],
      ),
      Facility(
        id: '2',
        name: 'Tennis Court',
        description: 'Outdoor tennis court for students',
        type: FacilityType.sports,
        capacity: 4,
        location: 'Sports Complex',
        bookings: [],
      ),
    ];

    // Sample cheating records
    _cheatingRecords = [
      CheatingRecord(
        id: '1',
        studentId: '3',
        studentName: 'Robert Johnson',
        enrollmentNumber: 'ME103',
        reason: 'Using unauthorized materials during exam',
        proofDescription: 'Found notes written on hand',
        incidentDate: DateTime.now().subtract(Duration(days: 10)),
        reportedBy: 'Exam Invigilator',
        isPublic: true,
      ),
    ];
  }

  // Get current app state
  AppState getAppState() {
    return AppState(
      elections: _elections,
      applications: _applications,
      complaints: _complaints,
      budgets: _budgets,
      facilities: _facilities,
      cheatingRecords: _cheatingRecords,
    );
  }

  // Student authentication
  Student? authenticateStudent(String email) {
    try {
      return _students.firstWhere((student) => student.email == email);
    } catch (e) {
      return null;
    }
  }

  // Get all students
  List<Student> getAllStudents() {
    return _students;
  }

  // Get all elections
  List<Election> getAllElections() {
    return _elections;
  }

  // Get active elections
  List<Election> getActiveElections() {
    return _elections.where((election) => election.isActive).toList();
  }

  // Vote in election
  bool voteInElection(String electionId, String candidateId, String studentId) {
    try {
      final electionIndex = _elections.indexWhere((e) => e.id == electionId);
      if (electionIndex == -1) return false;

      final election = _elections[electionIndex];

      // Check if student has already voted
      if (election.votedStudents.contains(studentId)) {
        return false;
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
      _elections[electionIndex] = updatedElection;
      return true;
    } catch (e) {
      return false;
    }
  }

  // Submit application
  bool submitApplication(Application application) {
    try {
      _applications.add(application);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Submit complaint
  bool submitComplaint(Complaint complaint) {
    try {
      _complaints.add(complaint);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Submit facility booking
  bool submitBooking(Booking booking) {
    try {
      final facilityIndex = _facilities.indexWhere((f) => f.id == booking.facilityId);
      if (facilityIndex == -1) return false;

      final facility = _facilities[facilityIndex];
      final updatedBookings = [...facility.bookings, booking];
      
      final updatedFacility = Facility(
        id: facility.id,
        name: facility.name,
        description: facility.description,
        type: facility.type,
        capacity: facility.capacity,
        location: facility.location,
        bookings: updatedBookings,
      );

      _facilities[facilityIndex] = updatedFacility;
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get all applications
  List<Application> getAllApplications() {
    return _applications;
  }

  // Get all complaints
  List<Complaint> getAllComplaints() {
    return _complaints;
  }

  // Get all budgets
  List<Budget> getAllBudgets() {
    return _budgets;
  }

  // Get all facilities
  List<Facility> getAllFacilities() {
    return _facilities;
  }

  // Get all cheating records
  List<CheatingRecord> getAllCheatingRecords() {
    return _cheatingRecords;
  }
}