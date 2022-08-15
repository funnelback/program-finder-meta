<#ftl encoding="utf-8" output_format="HTML" />
<#import "results.facebook.pages.ftl" as pages />
<#import "results.facebook.posts.ftl" as posts />
<#import "results.facebook.events.ftl" as events />
<#-- 
    Macro decides how each facebook result should be presented. 

    @param result An individual result fron the data model
    @param view An uppercase string which represents how
        the result should be displayed. Defaults to DETAILED.
-->
<#macro Result result=result view="LIST">
    <#switch view?upper_case>
        <#case "CARD">
            <@CardView result=result />
            <#break>
        <#case "LIST">
            <#-- Determine if results should be hidden or not -->
            <@ListView result=result />
            <#break>
        <#default>
            <@ListView result=result />
    </#switch>
</#macro>

<#--
    Stardard view of a result which is to be displayed in the 
    main section of the search engine result page (SERP)
    @param result An individual result fron the data model
-->
<#macro ListView result>
    <@GenericView result=result />
</#macro>

<#--
    Card view of a result which is to be displayed in the 
    main section of the search engine result page (SERP)
    @param result An individual result fron the data model
-->
<#macro CardView result>
    <@GenericView result=result />
</#macro>

<#--
    A generic view used to drive both the the list and card view
    @param result An individual result fron the data model
-->
<#macro GenericView result>
    <#switch (result.listMetadata["stencilsFacebookType"]?first?upper_case)!"">
        <#case "PAGE">
            <@pages.Result result=result />
            <#break>
        <#case "POST">
            <@posts.Result result=result />
            <#break>
        <#case "EVENT">
            <@events.Result result=result />
            <#break>
        <#default>
            <div class="alert alert-danger" role="alert">
                <#if result.listMetadata["stencilsFacebookType"]!?has_content>
                    <strong>Facebook content type not available</strong>: Ensure the content possesses a
                    <code>facebookType</code> metadata and that it is returned in the data model.
                <#else>
                    <strong>Unsupported Facebook content type "${result.listMetadata["stencilsFacebookType"]?first!}":</strong>
                    You may need to create a result template for this content type
                </#if>
            </div>
        <#break>
    </#switch>
</#macro>
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->