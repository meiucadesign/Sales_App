import 'package:flutter/material.dart';
import 'package:sales_app/widgets/custom_drawer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class DashBoard extends StatelessWidget {
  static const String routeName = "/DashBoard";

  final List<ChartData> chartData = [
    ChartData('Total Sales', 25, Colors.black),
    ChartData('Total Expenses', 38, Colors.red),
    ChartData('Services', 34, Colors.blue),
    ChartData('Employee Salary', 52, Colors.yellowAccent)
  ];
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
    _SalesData('Jun', 32),
    _SalesData('Jul', 35),
    _SalesData('Aug', 40),
    _SalesData('Sep', 28),
    _SalesData('Oct', 32),
    _SalesData('Nov', 35),
    _SalesData('Dec', 40),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          SfCircularChart(
            title: ChartTitle(text: "Sales"),
            legend: Legend(isVisible: true),
            series: <CircularSeries>[
              PieSeries<ChartData, String>(
                dataSource: chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                explode: true,
                legendIconType: LegendIconType.circle,
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          ),
          const Divider(
            color: Colors.blue,
            height: 10,
            thickness: 3,
            indent: 30,
            endIndent: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SfSparkLineChart.custom(
              axisCrossesAt: 35,
              axisLineColor: Colors.blue,
              color: Colors.black,
              highPointColor: Colors.red,
              lowPointColor: Colors.green,
              isInversed: true,
              trackball: SparkChartTrackball(
                  activationMode: SparkChartActivationMode.tap),
              marker: SparkChartMarker(
                  displayMode: SparkChartMarkerDisplayMode.all),
              labelDisplayMode: SparkChartLabelDisplayMode.all,
              xValueMapper: (int index) => data[index].year,
              yValueMapper: (int index) => data[index].sales,
              dataCount: 12,
            ),
          ),
          const Divider(
            color: Colors.blue,
            height: 10,
            thickness: 3,
            indent: 30,
            endIndent: 30,
          ),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'Half yearly sales analysis'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_SalesData, String>>[
              LineSeries<_SalesData, String>(
                isVisibleInLegend: true,
                legendItemText: "data",
                yAxisName: "Sales",
                xAxisName: "Months",
                
                dataSource: data,
                xValueMapper: (_SalesData sales, _) => sales.year,
                yValueMapper: (_SalesData sales, _) => sales.sales,
                name: 'Sales',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(
    this.x,
    this.y,
    this.color,
  );
  final String x;
  final double y;
  final Color color;
}

class _SalesData {
  _SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
