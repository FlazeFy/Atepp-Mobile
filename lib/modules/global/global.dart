int selectedIndex = 0;

class PieData {
  PieData(this.xData, this.yData, [this.text = ""]);
  final String xData;
  final num yData;
  final String text;
}

String selectedProject = '-';

List<Map<String, String>> projectSlug = [];
