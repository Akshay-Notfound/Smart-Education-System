import 'package:flutter/material.dart';
import 'package:smart_education_system/models/app_state.dart';
import 'package:smart_education_system/models/facility.dart';
import 'package:smart_education_system/services/data_service.dart';

class FacilityScreen extends StatefulWidget {
  final AppState appState;

  const FacilityScreen({super.key, required this.appState});

  @override
  State<FacilityScreen> createState() => _FacilityScreenState();
}

class _FacilityScreenState extends State<FacilityScreen> {
  late AppState _appState;
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _purposeController = TextEditingController();
  
  // Form fields
  String? _selectedFacilityId;
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);

  @override
  void initState() {
    super.initState();
    _appState = widget.appState;
  }

  @override
  void dispose() {
    _purposeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked != null && picked != _endTime) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  void _submitBooking() {
    if (_formKey.currentState!.validate()) {
      if (_selectedFacilityId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a facility')),
        );
        return;
      }

      // Create DateTime objects from selected date and time
      final startDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _startTime.hour,
        _startTime.minute,
      );
      
      final endDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _endTime.hour,
        _endTime.minute,
      );
      
      // Validate time selection
      if (endDateTime.isBefore(startDateTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('End time must be after start time')),
        );
        return;
      }

      final selectedFacility = _appState.facilities
          .firstWhere((facility) => facility.id == _selectedFacilityId);

      final newBooking = Booking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        facilityId: selectedFacility.id,
        bookedBy: _appState.currentStudent!.id,
        bookedByName: _appState.currentStudent!.name,
        bookingDate: DateTime.now(),
        startTime: startDateTime,
        endTime: endDateTime,
        purpose: _purposeController.text,
      );

      final success = DataService().submitBooking(newBooking);
      
      if (success) {
        setState(() {
          // Refresh the app state
          _appState = DataService().getAppState();
        });
        
        // Clear form
        _purposeController.clear();
        _selectedFacilityId = null;
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking request submitted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit booking request')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final facilities = _appState.facilities;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Facility Booking'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Book Facility'),
              Tab(text: 'Available Facilities'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Book Facility Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Request Facility Booking',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedFacilityId,
                      decoration: const InputDecoration(
                        labelText: 'Select Facility',
                        border: OutlineInputBorder(),
                      ),
                      items: facilities.map((facility) {
                        return DropdownMenuItem(
                          value: facility.id,
                          child: Text(facility.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedFacilityId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a facility';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _purposeController,
                      decoration: const InputDecoration(
                        labelText: 'Purpose of Booking',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the purpose';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Booking Date & Time',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectDate(context),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Date',
                                border: OutlineInputBorder(),
                              ),
                              child: Text(
                                '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectStartTime(context),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Start Time',
                                border: OutlineInputBorder(),
                              ),
                              child: Text(
                                _startTime.format(context),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectEndTime(context),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'End Time',
                                border: OutlineInputBorder(),
                              ),
                              child: Text(
                                _endTime.format(context),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitBooking,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        child: const Text('Submit Booking Request'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Available Facilities Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: facilities.isEmpty
                  ? const Center(
                      child: Text(
                        'No facilities available',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: facilities.length,
                      itemBuilder: (context, index) {
                        final facility = facilities[index];
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
                                      facility.name,
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
                                        color: _getFacilityColor(facility.type),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        facility.type.toString().split('.').last.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(facility.description),
                                const SizedBox(height: 8),
                                Text(
                                  'Location: ${facility.location}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Capacity: ${facility.capacity} people',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Upcoming Bookings:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (facility.bookings.isEmpty)
                                  const Text(
                                    'No upcoming bookings',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  )
                                else
                                  ...facility.bookings.map((booking) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            booking.purpose,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Booked by: ${booking.bookedByName}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${booking.startTime.toString().split(' ')[0]} '
                                            '${booking.startTime.toString().split(' ')[1].substring(0, 5)} - '
                                            '${booking.endTime.toString().split(' ')[1].substring(0, 5)}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getBookingStatusColor(booking.status),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              booking.status.toString().split('.').last.toUpperCase(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
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
  
  Color _getFacilityColor(FacilityType type) {
    switch (type) {
      case FacilityType.auditorium:
        return Colors.blue;
      case FacilityType.sports:
        return Colors.green;
      case FacilityType.classroom:
        return Colors.orange;
      case FacilityType.laboratory:
        return Colors.purple;
      case FacilityType.library:
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }
  
  Color _getBookingStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.approved:
        return Colors.green;
      case BookingStatus.rejected:
        return Colors.red;
      case BookingStatus.completed:
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }
}