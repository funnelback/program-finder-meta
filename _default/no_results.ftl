<#ftl encoding="utf-8" output_format="HTML" />

<#--
  Message to display when there are no results.
-->
<#macro NoResults>
    <!-- no_results::NoResults -->
    <#if (response.resultPacket.resultsSummary.totalMatching)!?has_content &&
        response.resultPacket.resultsSummary.totalMatching == 0>
        <div class="no-results">
            <h3 class="no-results__title">
            <svg class="svg-icon no-results__icon">
                <use href="#no-results"></use>
            </svg>
            No matching results
        </h3>
        <div class="wysiwyg-allowed">
            <p>
                Your search for <strong><@s.QueryClean /></strong> did not return any results.
            </p>
            </div>
        </div>
    </#if>
</#macro>
