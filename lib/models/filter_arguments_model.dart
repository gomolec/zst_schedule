class FilterArguments {
  bool showClasses;
  bool showClassrooms;
  bool showTeachers;

  FilterArguments({
    this.showClasses = true,
    this.showClassrooms = true,
    this.showTeachers = true,
  });
  void handleFiltersChanged(
    FilterArguments changes,
  ) {
    showClasses = changes.showClasses;
    showClassrooms = changes.showClassrooms;
    showTeachers = changes.showTeachers;
  }
}
