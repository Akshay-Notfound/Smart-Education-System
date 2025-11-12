import 'package:flutter/material.dart';
import 'package:smart_education_system/models/app_state.dart';
import 'package:smart_education_system/models/complaint.dart';
import 'package:smart_education_system/services/data_service.dart';

class ComplaintScreen extends StatefulWidget {
  final AppState appState;

  const ComplaintScreen({super.key, required this.appState});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  late AppState _appState;
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  // Form fields
  bool _isAnonymous = true;

  @override
  void initState() {
    super.initState();
    _appState = widget.appState;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitComplaint() {
    if (_formKey.currentState!.validate()) {
      final newComplaint = Complaint(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        submittedDate: DateTime.now(),
        isAnonymous: _isAnonymous,
        complainantId: _isAnonymous ? null : _appState.currentStudent!.id,
        complainantName: _isAnonymous ? null : _appState.currentStudent!.name,
      );

      final success = DataService().submitComplaint(newComplaint);
      
      if (success) {
        setState(() {
          // Refresh the app state
          _appState = DataService().getAppState();
        });
        
        // Clear form
        _titleController.clear();
        _descriptionController.clear();
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Complaint submitted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit complaint')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final complaints = _appState.visibleComplaints;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Complaints'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Submit Complaint'),
              Tab(text: 'View Complaints'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Submit Complaint Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Submit New Complaint',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Complaint Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: _isAnonymous,
                          onChanged: (value) {
                            setState(() {
                              _isAnonymous = value ?? true;
                            });
                          },
                        ),
                        const Text('Submit anonymously'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitComplaint,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        child: const Text('Submit Complaint'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // View Complaints Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: complaints.isEmpty
                  ? const Center(
                      child: Text(
                        'No complaints available',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        final complaint = complaints[complaints.length - 1 - index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      complaint.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(complaint.status),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        complaint.status.toString().split('.').last.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(complaint.description),
                                const SizedBox(height: 8),
                                Text(
                                  'Submitted on: ${complaint.submittedDate.toString().split(' ')[0]}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  complaint.isAnonymous 
                                    ? 'Submitted anonymously' 
                                    : 'Submitted by: ${complaint.complainantName}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
  
  Color _getStatusColor(ComplaintStatus status) {
    switch (status) {
      case ComplaintStatus.resolved:
        return Colors.green;
      case ComplaintStatus.rejected:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}