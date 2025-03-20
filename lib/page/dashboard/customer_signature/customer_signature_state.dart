class CustomerSignatureState {
  late List<String> tabs;
  late List<DateTime> selectDateRange;
  late int fixNumber;
  late int regularNumber;

  CustomerSignatureState() {
    selectDateRange = [DateTime.now().subtract(const Duration(days: 7)), DateTime.now()];
    tabs = ['例行保养', '故障报修'];
    fixNumber = 0;
    regularNumber = 0;
  }
}
