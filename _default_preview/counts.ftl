<#ftl encoding="utf-8" output_format="HTML" />

<#--
    Display the number of results which matches the search terms. The count
    can include fully matching results (documents match all the words 
    in the search terms) and partially matching results (documents contain at 
    one of the search term but less than all terms). 
    
    It also displays if blending has been activated.
-->
<#macro Counts>
    <!-- counts::Counts -->
    <p class="counts">                                                                    
        <#if ((response.resultPacket.resultsSummary.totalMatching)!0) == 0>
            <span class="counts__total-matching">0</span> search results for <strong class="highlight"><@s.QueryClean /></strong>
        </#if>
        <#if ((response.resultPacket.resultsSummary.totalMatching)!0) != 0>
            <span class="counts__page-start">${(response.resultPacket.resultsSummary.currStart)!}</span> -
            <span class="counts__page-end">${(response.resultPacket.resultsSummary.currEnd)!}</span> of
            <span class="counts__total-matching">${(response.resultPacket.resultsSummary.totalMatching)!?string.number}</span>
            <#if (question.inputParameters["s"]?first)!?has_content && question.inputParameters["s"]?first?contains("?:")>
                <em>collapsed</em> 
            </#if>
            search results
            
            <#-- Display the query if it is not the placeholder -->
            <#if (question.query)!?has_content && 
                (question.query)!?upper_case != (question.getCurrentProfileConfig().get("stencils.tabs.browse_mode.default_query"))!"">
                for <strong><@s.QueryClean></@s.QueryClean></strong>
            <#else>
                <#-- We normally don't want to display the placeholder value -->
            </#if>
            
            <#-- Display any blended queries -->
            <#list response.resultPacket.QSups as qsup>
                or <strong>${(qsup.query)!}</strong>
                <#if qsup_has_next>, </#if>
            </#list>
        </#if>

        <#-- 
            Display count for the number of document which match some but
            not all of the the query terms.
        -->
        <#if ((response.resultPacket.resultsSummary.partiallyMatching)!0) != 0>
            where <span class="counts__fully-matching">${(response.resultPacket.resultsSummary.fullyMatching)!?string.number}</span>
            match all words and <span class="counts_partially-matching">${(response.resultPacket.resultsSummary.partiallyMatching)!?string.number}</span>
            match some words.
        </#if>
        
        <#-- 
            Display the count for the number of documents which have been collapsed.
            The collapsed results functionality prevents similar documents from being 
            over represented on the search results page.
        --> 
        <#if ((response.resultPacket.resultsSummary.collapsed)!0) != 0>
            where 
            <span class="counts__collapsed">${(response.resultPacket.resultsSummary.collapsed)!}</span>
            very similar results have been hidden.
        </#if>
    </span>
</#macro>