enum FilterBy { All, P, IP, S, F, UP, ON, CO, CA }

enum SortBy { Desc, Asc }

class EventFilter {
  static String filterStatus = "All";
  static late String filterLabel;
  static String sortEventBy = "Desc";
  static void sortBySelected(SortBy sortBy) {
    switch (sortBy) {
      case SortBy.Desc:
        sortEventBy = "Desc";
        break;
      case SortBy.Asc:
        sortEventBy = "Asc";
        break;
      default:
        sortEventBy = "Desc";
        break;
    }
    // return sortEventBy;
  }

   static String get sortBy {
    return sortEventBy;
  }

  static String filterSelected(FilterBy status) {
    switch (status) {
      case FilterBy.All:
        filterStatus = "All";
        filterLabel = "All";
        break;
      case FilterBy.P:
        filterStatus = "P";
        filterLabel = "Pending";
        break;
      case FilterBy.IP:
        filterStatus = "IP";
        filterLabel = "In Progress";
        break;
      case FilterBy.S:
        filterStatus = "S";
        filterLabel = "Success";
        break;
      case FilterBy.F:
        filterStatus = "F";
        filterLabel = "Fail";
        break;
      case FilterBy.UP:
        filterStatus = "UP";
        filterLabel = "Upcoming";
        break;
      case FilterBy.ON:
        filterStatus = "ON";
        filterLabel = "Ongoing";
        break;
      case FilterBy.CO:
        filterStatus = "CO";
        filterLabel = "Complete";
        break;
      case FilterBy.CA:
        filterStatus = "CA";
        filterLabel = "Cancel";
        break;
      default:
        filterStatus = "All";
        filterLabel = "All";
        break;
    }

    return filterStatus;
  }

  static String get filterStatusBy {
    return filterStatus;
  }
}
