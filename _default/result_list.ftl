<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
    This template contains all the logic to determine how a list of 
    search results should be displayed to the end user.
-->

<#-- 
    Determines if the results are to be displayed normally
    or grouped together by some criteria

    TODO - Add browsing results to this
-->
<#macro ResultList nestedRank=-1>
    <#assign displayMode = search_tools.getDisplayMode(question)>

    <#if (response.customData["stencilsGroupingResults"].mode)!?has_content>
        <@GroupedResults view=displayMode/>
    <#else>
        <@StandardResults view=displayMode nestedRank=-1>
            <#nested>    
        </@StandardResults>
    </#if>
</#macro>

<#--
    Iterate over results and choose the right template depending
    on the results type and what is configured in collection.cfg

    Defaults to <code>&lt;@project.Result /&gt;

    @param nestedRank Before which result to insert the nested content of the macro.
        This is used to insert content (usually an extra search) between results.
-->
<#macro StandardResults view="LIST" nestedRank=-1>
    <!-- result_list::StandardResults -->
    <div class="no-wysiwyg listing listing--linked-item ">
        <div class="listing__items listing__items--${view?lower_case}-view">
            <#list (response.resultPacket.resultsWithTierBars)![] as result>
                <#if result.class.simpleName == "TierBar">
                    <@tier_bars.TierBars result=result />
                <#else>
                    <#if nestedRank gte 0 && result.rank == nestedRank>
                        <#nested>
                    </#if>
                    
                    <#-- Display the result based on the configured template -->
                    <@Result result=result view=view/>                
                </#if>
            </#list>
        </div>
    </div>
</#macro>

<#--
    Displays a search result using the the right template depending
    on the results type and what is configured in collection.cfg

    Defaults to <code>&lt;@project.Result /&gt;

    @param result The search result to output
-->
<#macro Result result question=question view="LIST">
    <#-- Get result template depending on collection name -->
    <#assign resultDisplayLibrary = question.getCurrentProfileConfig().get("stencils.template.result.${result.collection}")!"" />

    <#-- If not defined, attempt to get it depending on the gscopes the result belong to -->
    <#if !resultDisplayLibrary?has_content>
        <#list (result.gscopesSet)![] as gscope>
            <#assign resultDisplayLibrary = question.getCurrentProfileConfig().get("stencils.template.result.${gscope}")!"" />
            <#if resultDisplayLibrary?has_content>
                <#break>
            </#if>
        </#list>
    </#if>

    <#if .main[resultDisplayLibrary]??>
        <#-- Output the result using the presentation specified in the configurations -->
        <@.main[resultDisplayLibrary].Result result=result view=view />
    <#elseif .main["results"]??>
        <#-- Default presentation -->
        <@.main["results"].Result result=result view=view />
    <#elseif .main["project"]??>
        <#-- Default presentation for legacy (pre 15.24.x) implementations -->
        <@.main["project"].Result result=result view=view />
    <#else>
        <div class="alert alert-danger" role="alert">
            <strong>Result template not found</strong>: Template <code>&lt;@<#if resultDisplayLibrary?has_content>${resultDisplayLibrary}<#else>(default namespace)</#if>.Result /&gt;</code>
            not found for result from collection <em>${result.collection}</em>.
        </div>
    </#if>
</#macro>

<#macro GroupedResults view="LIST">
    <#-- Loop through each grouped result tier -->
    <#if (response.resultPacket.results)!?has_content>
        <article class="search-results__list <#if search_tools.getDisplayMode(question)! == 'LIST' || search_tools.getDisplayMode(question)! == 'BROWSE'>search-results__list--list-view</#if>">
            <#list (response.customData["stencilsGroupingResults"].groups)![] as group>
                <#-- Create facet link to be used in the title and "see more" -->
                <#assign searchLink = question.getCurrentProfileConfig().get("ui.modern.search_link")!>
                <#assign facetLink = (group.url)!"">

                <a class="highlight search-results__group-label" href="${searchLink + facetLink}">           
                    ${group.label}
                </a>
        
                <#list response.resultPacket.results as result>                        
                    <#-- Display the result based on the configured template -->
                    <#switch ((response.customData["stencilsGroupingResults"].mode)!"")?upper_case>
                        <#case "METADATA">
                            <#if (result.listMetadata["group.field"]?first)!?has_content>
                                <@Result result=result view=view />
                            </#if>
                            <#break> 
                        <#case "COLLECTION">
                            <#if result.collection == (group.field)!"">
                                <@Result result=result view=view />
                            </#if>
                            <#break>
                        <#default>                
                            <#break>
                    </#switch>         
                </#list>

                <#-- See more link -->
                <a href="${searchLink + facetLink}" class="search-results__group-see-more-label highlight"> 
                    <i class="fas fa-arrow-right mr-1"></i>
                    See more ${group.label} 
                </a>
            </#list>    
        </article>
    </#if>
</#macro>

<#--
    Iterate over results and choose the right quick view template depending
    on the results type and what is configured in collection.cfg

    Defaults to <code>&lt;@project.Result /&gt;
-->
<#macro QuickViewList Templates>
    <!-- result_list::QuickViewTemplates -->
    <#list (response.resultPacket.resultsWithTierBars)![] as result>
        <#if result.class.simpleName == "TierBar">
            <#-- Ignore tier bars -->
        <#else>            
            <#-- Display the result based on the configured template -->
            <@QuickView result=result />                
        </#if>
    </#list>
</#macro>

<#--
    Displays a search result using the the right quick view template depending
    on the results type and what is configured in collection.cfg

    Defaults to <code>&lt;@project.Result /&gt;

    @param result The search result to output
-->
<#macro QuickView result question=question>
    <#-- Get result template depending on collection name -->
    <#assign resultDisplayLibrary = question.getCurrentProfileConfig().get("stencils.template.result.${result.collection}")!"" />

    <#-- If not defined, attempt to get it depending on the gscopes the result belong to -->
    <#if !resultDisplayLibrary?has_content>
        <#list (result.gscopesSet)![] as gscope>
            <#assign resultDisplayLibrary = question.getCurrentProfileConfig().get("stencils.template.result.${gscope}")!"" />
            <#if resultDisplayLibrary?has_content>
                <#break>
            </#if>
        </#list>
    </#if>

    <#if .main[resultDisplayLibrary]??>
        <@.main[resultDisplayLibrary].QuickView result=result />
    <#elseif .main["project"]??>
        <#-- Default Result macro in current namespace -->
        <@.main["project"].QuickView result=result/>
    <#else>
        <div class="alert alert-danger" role="alert">
            <strong>Result template not found</strong>: Template <code>&lt;@<#if resultDisplayLibrary?has_content>${resultDisplayLibrary}<#else>(default namespace)</#if>.Result /&gt;</code>
            not found for result from collection <em>${result.collection}</em>.
        </div>
    </#if>
</#macro>