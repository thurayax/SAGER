import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'services/api_service.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  List<Map<String, dynamic>> gameProgress = [];
  double totalDuration = 0;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchGameProgress().then((data) {
      setState(() {
        gameProgress = data;
        totalDuration =
            gameProgress.fold(0, (sum, item) => sum + item['duration']);
      });
    });
  }

  Future<List<Map<String, dynamic>>> fetchGameProgress() async {
    try {
      final response = await Supabase.instance.client
          .from('game_progress')
          .select('*')
          .order('date_played', ascending: false);

      if (response.isNotEmpty) {
        return List<Map<String, dynamic>>.from(response);
      }
    } catch (error) {
      print('Error fetching game progress: $error');
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تقدم الطفل",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF709E8F),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Blue and Green.png',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: const Color(0xFFFFF9C4),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'إحصائيات اللعب',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                            'إجمالي وقت اللعب: ${totalDuration.toStringAsFixed(1)} دقيقة'),
                        Text(
                            'متوسط وقت اللعب لكل لعبة: ${(totalDuration / gameProgress.length).toStringAsFixed(1)} دقيقة'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'الوقت الذي أمضاه الطفل في كل لعبة (بالدقائق)',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF42A5F5),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 300,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: totalDuration > 100 ? totalDuration : 100,
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() >= 0 &&
                                  value.toInt() < gameProgress.length) {
                                return Text(
                                  gameProgress[value.toInt()]['game_name']
                                      .toString(),
                                  style: const TextStyle(fontSize: 12),
                                );
                              }
                              return const Text('');
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: gameProgress.map((data) {
                        final index = gameProgress.indexOf(data);
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: data['duration'].toDouble(),
                              gradient: LinearGradient(
                                colors: [Colors.blue, Colors.green],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                              width: 20,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
