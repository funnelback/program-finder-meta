<#ftl encoding="utf-8" output_format="HTML" />
<#-- 
    This template contains markup and logic related to the 
    concierge feature. Concierge is a advanced form of auto complete
    where you can have suggestions from multuple channels. These
    channels are powered by result pages on the search package.

    The version of concierge used here was created by the plug and play team
    to address the use of deprecated libraries problem and various
    accessiblity issues. Although both the plug and play version and 
    the auto complete concierge version created by Funnelback R&D team
    share some similaries, there are also quite a bit of differences.

    e.g. 
    - The ability to specify auto complete when the user has not
    entered a query.
    - Templating for the version in plug and play requires access to the 
    the design system as it involves modifying or creating new react templates.
-->
<#macro Concierge portal=false>
    <!-- auto_complete.concierge::Concierge -->

    <#-- Grab the variables used to construct the varioius requests -->
    <#local host=httpRequest.getHeader('host')>
    <#local alpha=(question.getCurrentProfileConfig().get("stencils.auto-completion.alpha"))!"0.5">
    <#local length=(question.getCurrentProfileConfig().get("stencils.auto-completion.length"))!"3">
    <#local program=(question.getCurrentProfileConfig().get("stencils.auto-completion.program"))!"/s/suggest.json">
    <#local sort=(question.getCurrentProfileConfig().get("stencils.auto-completion.sort"))!"0">
    <#local inputID=(question.getCurrentProfileConfig().get("stencils.auto-completion.input_id"))!"query">

    <div
        id="autocomplete-concierge"
        data-component="autocomplete-concierge"
        data-autocomplete-config="{
            <#if portal=true>&quot;portal&quot;:&quot;#${inputID}&quot;,</#if>
            &quot;showSubmit&quot;:true
        }"
    >
        <input type="hidden" name="collection" value="${question.collection.id}">

        <@base.inputsForForms allowList= ["enc", "form", "scope", "lang", "profile", "userType", "displayMode", "num_ranks"] />

    
        <#-- 
            Diplay the markup for each channel using the config 
            specified by the user in the result page configurations. 
        -->
        <#list question.getCurrentProfileConfig().get("stencils.auto-completion.datasets")!?split(",") as dataset>
            <#local collection = question.getCurrentProfileConfig().get("stencils.auto-completion.datasets.${dataset}.collection")!question.collection.id>
            
            <#-- Determine if we need the live or preview view. -->
            <#if question.profile?ends_with("_preview") && question.getCurrentProfileConfig().get("stencils.auto-completion.datasets.${dataset}.profile")!?has_content>
                <#local profile = question.getCurrentProfileConfig().get("stencils.auto-completion.datasets.${dataset}.profile")! + "_preview">
            <#else>
                <#local profile = question.getCurrentProfileConfig().get("stencils.auto-completion.datasets.${dataset}.profile")!question.profile>   
            </#if>
            <#-- Used to style each channel. -->
            <#local customClass = question.getCurrentProfileConfig().get("stencils.auto-completion.datasets.${dataset}.customClass")!"">
            <#-- THe display heading of each auto complete channel. -->
            <#local label = question.getCurrentProfileConfig().get("stencils.auto-completion.datasets.${dataset}.label")!"Suggestions">
            <#-- The react template to use. -->
            <#local template = question.getCurrentProfileConfig().get("stencils.auto-completion.datasets.${dataset}.template")!"organic">
            <#-- The API used to submit requests to. -->
            <#local serviceUrl = "//${host}${program}">
            <#-- The number of results to show for each auto complete channel. -->
            <#local show = question.getCurrentProfileConfig().get("stencils.auto-completion.datasets.${dataset}.show")!"10">
            
            <#local format=(question.getCurrentProfileConfig().get("stencils.auto-completion.datasets.${dataset}.format"))!"json++">

            <#local params="fmt=${format}&alpha=${alpha}&show=5&sort=${sort}&collection=${collection}&profile=${profile}">

            <#-- Output the markup required to show each auto complete channel -->
            <span class="${customClass}"
                data-id="auto-complete-${dataset_index}"
                data-label="${label}"
                data-template="${template}"
                data-service-url="${serviceUrl}"
                data-params="${params}"
            > </span>
        </#list>
    </div>    
</#macro>