
const String getAllUsersQuery = """
query AllEvents {
    allEvents {
        id
        title
        eventDescription
        amountReceived
        category
        subCategory
        startDate
        posterImg
        createBy
        locationName
    }
}

""";


const String getUserQuery = """
query (\$id: Int){
    getUserInfo(id: \$id) {
      id,
      name,
      job_title,
      email
    }
  }

""";

const String getEventsUserID = """
query FindAllEventsByUid {
    findAllEventsByUid(uid: \$uid) {
        user_event_id
        status
        user {
            userId
        }
        event {
            id
            title
            eventDescription
            category
            endDate
            startDate
            validationType
            validationRules
            posterImg
            createBy
            locationName
            locationLatitude
            locationLongitude
            description
        }
    }
}

""";

