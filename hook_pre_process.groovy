new com.funnelback.stencils.hook.StencilHooks().apply(transaction, binding.hasVariable("hook") ? hook : null)


/**
  * Determine which extra searches we should show
  * All         - Show both
  * Programs    - Only show programs
  * Courses     - Only show courses
  * 
  * Note: We won't be using the results from the original transaction.
  */ 
def stencilsShowPrograms = true
def stencilsShowCourses = true

transaction.question.inputParameterMap.each { k,v -> 
    if ( k.startsWith("f.Display") ) {
        switch(v.toLowerCase()) {
            case "programs": 
                stencilsShowCourses = false
                break
            case "courses": 
                stencilsShowPrograms = false
                break
        }
    }
}
transaction.question.customData.put("stencilsShowPrograms", stencilsShowPrograms)
transaction.question.customData.put("stencilsShowCourses",  stencilsShowCourses)
