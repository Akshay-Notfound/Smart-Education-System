import 'package:flutter/material.dart';
import 'package:smart_education_system/models/app_state.dart';
import 'package:smart_education_system/models/election.dart';
import 'package:smart_education_system/services/data_service.dart';

class ElectionScreen extends StatefulWidget {
  final AppState appState;

  const ElectionScreen({super.key, required this.appState});

  @override
  State<ElectionScreen> createState() => _ElectionScreenState();
}

class _ElectionScreenState extends State<ElectionScreen> {
  late AppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = widget.appState;
  }

  void _vote(Election election, Candidate candidate) {
    if (election.votedStudents.contains(_appState.currentStudent?.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have already voted in this election')),
      );
      return;
    }

    final success = DataService().voteInElection(
      election.id, 
      candidate.id, 
      _appState.currentStudent!.id
    );

    if (success) {
      setState(() {
        // Refresh the app state
        _appState = DataService().getAppState();
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vote submitted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit vote')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeElections = _appState.activeElections;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Elections'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: activeElections.isEmpty
          ? const Center(
              child: Text(
                'No active elections at the moment',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: activeElections.length,
              itemBuilder: (context, index) {
                final election = activeElections[index];
                final hasVoted = election.votedStudents.contains(_appState.currentStudent?.id);
                
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          election.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(election.description),
                        const SizedBox(height: 8),
                        Text(
                          'Voting Period: ${election.startDate.toString().split(' ')[0]} to ${election.endDate.toString().split(' ')[0]}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Candidates:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...election.candidates.map((candidate) {
                          final votes = candidate.votes;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  candidate.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(candidate.manifesto),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Votes: $votes'),
                                    if (!hasVoted)
                                      ElevatedButton(
                                        onPressed: () => _vote(election, candidate),
                                        child: const Text('Vote'),
                                      )
                                    else if (election.votedStudents.contains(_appState.currentStudent?.id))
                                      const Text(
                                        'You have voted',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                  ],
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
    );
  }
}