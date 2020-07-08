new com.funnelback.stencils.hook.StencilHooks().apply(transaction, binding.hasVariable("hook") ? hook : null)

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
