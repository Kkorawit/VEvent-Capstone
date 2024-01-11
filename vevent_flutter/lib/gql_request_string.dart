
String readRepositories = """
  query ReadRepositories(\$nRepositories: Int!) {
    viewer {
      repositories(last: \$nRepositories) {
        nodes {
          id
          name
          viewerHasStarred
        }
      }
    }
  }
""";

const String findAllRegisEventsByUEmail = """
          query (\$uEmail: String){
            FindAllRegisEventsByUEmail{
              findAllRegisEventsByUEmail (uEmail: \$uEmail) {
                  user_event_id
                  status
                  doneTimes
                  user {
                      userEmail
                      username
                  }
                  event {
                      id
                      title
                      amountReceived
                      category
                      startDate
                      endDate
                      validationType
                      validationRules
                      posterImg
                      createBy
                      locationName
                      locationLatitude
                      locationLongitude
                      description
                      validate_times
                      eventStatus
                  }
              }
          }
          }

          """;