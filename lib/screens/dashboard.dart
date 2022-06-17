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

  List<_ChartData> graphData = [
    _ChartData('Dextrose', 307.00),
    _ChartData('raw1', 306.00),
    _ChartData('final product', 85.00),
    _ChartData('test', 32.00),
    _ChartData('test Final Product', 1)
  ];
  TooltipBehavior _tooltip = TooltipBehavior(enable: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        actions: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
              onPressed: () {
                showMenu(
                  context: context,
                  position: const RelativeRect.fromLTRB(40, 60, 20, 20),
                  items: [
                    PopupMenuItem(
                      child: Text("Branch 1"),
                    ),
                    PopupMenuItem(
                      child: Text("Branch 2"),
                    ),
                    PopupMenuItem(
                      child: Text("Branch 3"),
                    ),
                  ],
                );
              },
              label: Text("Change Branch"),
              icon: const Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
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
                trackball: const SparkChartTrackball(
                    activationMode: SparkChartActivationMode.tap),
                marker: const SparkChartMarker(
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
            SizedBox(
              height: 400,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  title: AxisTitle(text: 'Products'),
                ),
                title: ChartTitle(text: 'Half yearly sales analysis'),
                primaryYAxis: NumericAxis(
                  minimum: 0,
                  maximum: 317,
                  interval: 50,
                  title: AxisTitle(text: 'Quantity'),
                ),
                tooltipBehavior: _tooltip,
                series: <ChartSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: graphData,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    name: 'Sales Product',
                    color: Color.fromRGBO(8, 142, 255, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
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

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
