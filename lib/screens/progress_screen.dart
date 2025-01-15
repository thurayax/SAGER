import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  List<Map<String, dynamic>> gameProgress = [];
  double totalDuration = 0; // إجمالي مدة اللعب

  @override
  void initState() {
    super.initState();
    fetchGameProgress().then((data) {
      setState(() {
        gameProgress = data;
        totalDuration = gameProgress.fold(0, (sum, item) => sum + item['duration']);
      });
    });
  }

  // استرجاع بيانات التقدم من قاعدة البيانات
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
        title: Text('تقدم الطفل'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: gameProgress.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // إحصائيات مباشرة
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'إحصائيات اللعب',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text('إجمالي وقت اللعب: ${totalDuration.toStringAsFixed(1)} دقيقة'),
                          Text('متوسط وقت اللعب لكل لعبة: ${(totalDuration / gameProgress.length).toStringAsFixed(1)} دقيقة'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // رسم بياني عمودي
                  Text(
                    'الوقت الذي أمضاه الطفل في كل لعبة (بالدقائق)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
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
                                    gameProgress[value.toInt()]['game_name'],
                                    style: TextStyle(fontSize: 12),
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
                  SizedBox(height: 30),

                  // رسم بياني دائري
                  Text(
                    'توزيع وقت اللعب بين الألعاب',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 300,
                    child: PieChart(
                      PieChartData(
                        sections: gameProgress.map((data) {
                          final duration = data['duration'];
                          final percentage = (duration / totalDuration) * 100;
                          return PieChartSectionData(
                            value: duration.toDouble(),
                            title: '${percentage.toStringAsFixed(1)}%',
                            color: Colors.primaries[gameProgress.indexOf(data) % Colors.primaries.length],
                            radius: 50,
                            titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                          );
                        }).toList(),
                        sectionsSpace: 5,
                        centerSpaceRadius: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
