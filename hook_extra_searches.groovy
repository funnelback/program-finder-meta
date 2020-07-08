if ( transaction.extraSearchesQuestions["programs"] != null ) {
    def q = transaction.extraSearchesQuestions["programs"]
    q.inputParameterMap.remove("f.Display|AllDocumentsFill")
    q.inputParameterMap.remove("f.Display|program-finder-courses-web")
    q.inputParameterMap["f.Display|program-finder-programs-web"] = "Programs"
}

if ( transaction.extraSearchesQuestions["courses"] != null ) {
    def q = transaction.extraSearchesQuestions["courses"]
    q.inputParameterMap.remove("f.Display|AllDocumentsFill")
    q.inputParameterMap.remove("f.Display|program-finder-programs-web")
    q.inputParameterMap["f.Display|program-finder-courses-web"] = "Courses"
}