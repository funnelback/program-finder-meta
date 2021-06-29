new com.funnelback.stencils.hook.StencilHooks().apply(transaction, binding.hasVariable("hook") ? hook : null)

/**
 * Return all results if no query is provided
 * to provide an experience for "browsing"
 */
if (transaction.question.query == '' || transaction.question.query == null) {
    transaction.question.query = '!padrenull'
}
