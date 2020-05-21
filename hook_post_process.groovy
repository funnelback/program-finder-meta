new com.funnelback.stencils.hook.StencilHooks().apply(transaction, binding.hasVariable("hook") ? hook : null)

// Allow the modern UI to handle an undefined queryCleaned value (will occur for the above code as s params aren't included in queryClean)
if ( transaction.response != null && transaction.response.resultPacket.queryCleaned == null)
{
    transaction.response.resultPacket.queryCleaned ="";
}