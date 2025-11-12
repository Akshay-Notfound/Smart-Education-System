import 'package:flutter/material.dart';
import 'package:smart_education_system/models/app_state.dart';

class CheatingScreen extends StatelessWidget {
  final AppState appState;

  const CheatingScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    final records = appState.publicCheatingRecords;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Integrity Records'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: records.isEmpty
          ? const Center(
              child: Text(
                'No cheating records available',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[records.length - 1 - index];
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
                              record.studentName,
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
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'CHEATING',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Enrollment No: ${record.enrollmentNumber}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Reason:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(record.reason),
                        const SizedBox(height: 8),
                        const Text(
                          'Proof:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(record.proofDescription),
                        const SizedBox(height: 8),
                        Text(
                          'Reported on: ${record.incidentDate.toString().split(' ')[0]}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Reported by: ${record.reportedBy}',
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
    );
  }
}