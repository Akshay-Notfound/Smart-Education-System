import 'package:flutter/material.dart';
import 'package:smart_education_system/models/app_state.dart';
import 'package:smart_education_system/models/application.dart';
import 'package:smart_education_system/services/data_service.dart';

class ApplicationScreen extends StatefulWidget {
  final AppState appState;

  const ApplicationScreen({super.key, required this.appState});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  late AppState _appState;
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _budgetController = TextEditingController();
  
  // Form fields
  ApplicationType _selectedType = ApplicationType.event;
  Priority _selectedPriority = Priority.normal;

  @override
  void initState() {
    super.initState();
    _appState = widget.appState;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  void _submitApplication() {
    if (_formKey.currentState!.validate()) {
      final newApplication = Application(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        applicantId: _appState.currentStudent!.id,
        applicantName: _appState.currentStudent!.name,
        submittedDate: DateTime.now(),
        type: _selectedType,
        priority: _selectedPriority,
        budgetAmount: _selectedType == ApplicationType.budget || _selectedType == ApplicationType.sponsorship
            ? double.tryParse(_budgetController.text) ?? 0.0
            : null,
      );

      final success = DataService().submitApplication(newApplication);
      
      if (success) {
        setState(() {
          // Refresh the app state
          _appState = DataService().getAppState();
        });
        
        // Clear form
        _titleController.clear();
        _descriptionController.clear();
        _budgetController.clear();
        _selectedType = ApplicationType.event;
        _selectedPriority = Priority.normal;
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application submitted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit application')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final applications = _appState.applications;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Applications'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Submit Application'),
              Tab(text: 'View Applications'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Submit Application Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Submit New Application',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Application Title',
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
      maxLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a description';
        }
        return null;
      },
    ),
    const SizedBox(height: 16),
    DropdownButtonFormField<ApplicationType>(
      value: _selectedType,
      decoration: const InputDecoration(
        labelText: 'Application Type',
        border: OutlineInputBorder(),
      ),
      items: ApplicationType.values.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type.toString().split('.').last.toUpperCase()),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedType = value;
          });
        }
      },
    ),
    const SizedBox(height: 16),
    DropdownButtonFormField<Priority>(
      value: _selectedPriority,
      decoration: const InputDecoration(
        labelText: 'Priority',
        border: OutlineInputBorder(),
      ),
      items: Priority.values.map((priority) {
        return DropdownMenuItem(
          value: priority,
          child: Text(priority.toString().split('.').last.toUpperCase()),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedPriority = value;
          });
        }
      },
    ),
    const SizedBox(height: 16),
    if (_selectedType == ApplicationType.budget || 
        _selectedType == ApplicationType.sponsorship)
      TextFormField(
        controller: _budgetController,
        decoration: const InputDecoration(
          labelText: 'Budget Amount',
          border: OutlineInputBorder(),
          prefixText: '₹ ',
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if ((_selectedType == ApplicationType.budget || 
              _selectedType == ApplicationType.sponsorship) &&
              (value == null || value.isEmpty)) {
            return 'Please enter a budget amount';
          }
          if (value != null && value.isNotEmpty) {
            final parsedNum = num.tryParse(value);
            if (parsedNum == null || parsedNum <= 0) {
              return 'Please enter a valid amount';
            }
          }
          return null;
        },
      ),
    const SizedBox(height: 20),
    Center(
      child: ElevatedButton(
        onPressed: _submitApplication,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        child: const Text('Submit Application'),
      ),
    ),
  ],
),
              ),
            ),
            
            // View Applications Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: applications.isEmpty
                  ? const Center(
                      child: Text(
                        'No applications submitted yet',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: applications.length,
                      itemBuilder: (context, index) {
                        final application = applications[applications.length - 1 - index];
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
                                      application.title,
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
                                        color: _getStatusColor(application.status),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        application.status.toString().split('.').last.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(application.description),
                                const SizedBox(height: 8),
                                Text(
                                  'Submitted by: ${application.applicantName}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Submitted on: ${application.submittedDate.toString().split(' ')[0]}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Type: ${application.type.toString().split('.').last.toUpperCase()}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Priority: ${application.priority.toString().split('.').last.toUpperCase()}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                if (application.budgetAmount != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    'Budget: ₹${application.budgetAmount}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
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
  
  Color _getStatusColor(ApplicationStatus status) {
    switch (status) {
      case ApplicationStatus.approved:
        return Colors.green;
      case ApplicationStatus.rejected:
        return Colors.red;
      case ApplicationStatus.inProgress:
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }
}