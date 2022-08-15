
<#ftl encoding="utf-8" output_format="HTML" />
<#--   
    This template contains markup and logic related to the 
    displayign tier bars. Tier bars provide a separation between
    full matching results and results which match one at least 1 term
    (but not all terms).
-->

<#--
  Display a tier bar
-->
<#macro TierBars result>
    <!-- tier_bars::TierBars -->
    <#-- A tier bar -->
    <#if result.matched != result.outOf>
        <div class="tier-bar">Results that match ${result.matched} of ${result.outOf} words</div>
    <#else>
        <div class="tier-bar" class="sr-only search-tier">Fully-matching results</div>
    </#if>
    <#-- Print event tier bars if they exist -->
    <#if result.eventDate??>
        <div class="tier-bar">Events on ${result.eventDate?date}</div>
    </#if>
</#macro>