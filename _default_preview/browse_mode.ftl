<#ftl encoding="utf-8" output_format="HTML" />
<#--  TODO - Update to suit the new design system  -->

<#-- 
  This template contains markup and logic related to the 
  providing the ability for users to browse documents 
  instead of searching. 
-->

<#-- 
    Show the browse mode only on certain tabs.
    Each tab will have a different default sort option. 
    - Title for services
    - Date for social media
-->
<#macro BrowseModeToggle>
    <!-- browse_mode::BrowseModeToggle -->
    <#-- Check to see if browse mode config has been setup for the current selected tab -->
    <#if (question.getCurrentProfileConfig().get("stencils.tabs.browse_mode.facets.${(response.customData.stencilsTabsSelectedTab)!}"))!?has_content>
        <#switch (question.inputParameters["browse_mode"]?first)!?upper_case>
            <#case "TRUE">
            <#case "ON">
            <#case "1">
                <#break>
            <#default>
                <@BrowseModeToggleOn />
        </#switch>
    </#if>
</#macro>

<#-- Provides the user an option to turn the browse mode off -->
<#-- TODO - Come up with a UX for toggling off browse mode -->
<#macro BrowseModeToggleOff>
    <!-- browse_mode::BrowseModeToggleOff -->            
    <#-- 
        Output the controls to toggle browse mode from on to off 
        TODO - Need to decide how to handles the users query. Do we 
        retain it or do we do something else?
    -->
    <#--  
        <a class="btn--link" href="${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, ["browse_mode", "start_rank","query"])}}">
            Back to search view                        
        </a>  
    -->
</#macro>

<#-- Provides the user an option to turn the browse mode on -->
<#macro BrowseModeToggleOn id="fb-browse-mode">
    <!-- browse_mode::BrowseModeToggleOn -->
    <#-- Output the controls to toggle browse mode from off to on -->
    <section class="module-curator" role="complementary" aria-labelledby="${id}">
        <h2 id="${id}" class="sr-only">Toggle browse mode controls</h2>
        <article class="module-curator__list">
            <article class="module-curator__item">
                <div class="module-curator__top">                                    
                    <div>
                        <h3 class="module-curator__title">
                            <a href="" class="module-curator__link">
                                <#-- 
                                    TODO - Update this section to include an appropriate title 
                                --> 
                                Directory of services
                            </a>
                        </h3>
                    </div>
                    
                </div>                    
                <div class="module-curator__content">
                    <#-- Output the description -->
                    <p class="">
                        <#-- 
                            TODO - Update this section to include the 
                            appropriate message or description (if required)
                        -->                        
                        We are responsible for providing a range of high quality services. 
                        Our residents are at the heart of the services we offer.
                    </p>
                </div>
                <#-- Output and option explicit the call to action link -->
                
                <#local defaultQuery = (question.getCurrentProfileConfig().get("stencils.tabs.browse_mode.default_query"))!"">

                <a class="btn--link" href="${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, ["browse_mode", "start_rank", "query","sort"])}&browse_mode=true&query=${defaultQuery}&sort=title">
                    <#-- 
                        TODO - Update this section to include an appropriate 
                        name for the link. 
                    --> 
                    Browse all our services
                </a>
            </article>
        </article>
    </section>    
</#macro>

<#-- 
    Outputs the facets which are associated with browsing a 
    list of documents 
-->
<#macro BrowseByFilter>
    <!-- browse_mode::BrowseByFilter -->
    <#switch (question.inputParameters["browse_mode"]?first)!?upper_case>
        <#case "TRUE">
            
            <#-- Get the list of list facets to be displayed which has been configured by the user -->               
            <#local listFacets = (question.getCurrentProfileConfig().get("stencils.tabs.browse_mode.facets.${(response.customData.stencilsTabsSelectedTab)!}"))!?split(",")![]>
            
            <#-- Only print the browse mode filter when it has been configured. -->
            <#if listFacets?filter(x -> x != "")?size gt 0>
                <section class="module-az">
                    <#-- 
                        TODO - Currently this can be hardcoded for each implementation.
                        Determine if is needed to make this configurable.
                    -->
                    <#--                  
                    <section class="module-az__filter">
                        I’m a
                        <@facets.DropdownFacet facets=["Radio"] />
                        looking to study in
                        <@facets.DropdownFacet facets=["Date"] />
                        I’m interested in a career in
                        <@facets.DropdownFacet facets=["Format"] /> 
                        . I’d like to study
                        <@facets.DropdownFacet facets=["Format"] />
                    </section>  
                    -->
                                    
                    <@facets.ListFacets facets=listFacets />
                </section>
            </#if>
            <#break>
        <#default>        
    </#switch>
</#macro>