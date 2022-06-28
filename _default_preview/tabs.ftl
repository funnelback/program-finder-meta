<#ftl encoding="utf-8" output_format="HTML" />

<#--
    Display tabs
    @param facets List of tabs to display as a string. The default is that all tabs
        will be displayed
-->
<#macro Tabs tabs=[]>
    <!-- tabs::Tabs -->
    <#-- 
        Find all the tabs with values and determine if we want to display all tabs or just the tabs specified 
    -->
    <#local facets = (response.facets![])?filter(facet -> 
            facet.guessedDisplayType == "TAB"
            && facet.allValues?size gt 0
            && (!tabs?has_content || tabs?seq_contains(facet.name))
        )
    >

    <#list facets![] as facet>
        <div class="tabs tabs--center">
            <div class="tab__list" role="tablist">
                <div class="tab-list__nav" data-tab-group-element="tab-list-nav">
                    <#-- 
                        Show all the tabs as individual buttons. 
                        Note: Even though storybook uses buttons, we want to use anchors here 
                        so that request are submitted when click which will display the new results.
                    -->
                    <#list facet.allValues as value>

                        <#if value.count gt 0>
                            <a class="tab__button <#if value.selected>tab__button--active</#if>" 
                                id="${base.getCssID(value.label)+value_index}" 
                                role="tab" 
                                aria-selected="${(value.selected)!?string('true','false')}"
                                aria-controls="0-tab" 
                                tabindex="0" 
                                data-tab-group-control="${base.getCssID(value.label)+value_index}"
                                href="${value.toggleUrl}"
                            > 
                                <#-- Display the icon if it is configured -->
                                <#if question.getCurrentProfileConfig().get("stencils.tabs.icon.${value.label}")??>
                                    <span class="${question.getCurrentProfileConfig().get("stencils.tabs.icon.${value.label}")}"></span>
                                </#if>                            

                                ${value.label}                            
                                &nbsp; <#--  Prevent the count from being glued to the value  -->
                                <span class="tabs__count">(${value.count})</span>                             
                            </a>
                        <#else>
                            <span class="tab__button <#if value.selected>tab__button--active</#if> tab__button--disabled" 
                                id="${base.getCssID(value.label)+value_index}" 
                                role="tab" 
                                aria-selected="${(value.selected)!?string('true','false')}"
                                aria-controls="0-tab" 
                                tabindex="0" 
                                data-tab-group-control="${base.getCssID(value.label)+value_index}"
                            > 
                                <#-- Display the icon if it is configured -->
                                <#if question.getCurrentProfileConfig().get("stencils.tabs.icon.${value.label}")??>
                                    <span class="${question.getCurrentProfileConfig().get("stencils.tabs.icon.${value.label}")}"></span>
                                </#if>                            

                                ${value.label}                            
                                &nbsp; <#--  Prevent the count from being glued to the value  -->
                                <span class="tabs__count">(${value.count})</span>                             
                            </span>
                        </#if>
                    </#list>                                        

                    <#-- 
                        Display the show more button which will be visible whent he viewport 
                        is smaller than the available space to show all the tabs.
                    -->
                    <div class="tab-list-nav-overflow-menu__wrapper" data-tab-group-element="overflow-menu-wrapper">
                        <button class="tab-list-nav-overflow-menu__button" type="button" data-tab-group-element="overflow-menu-button" aria-labelledby="View more">
                            <span class="sr-only">show more tabs</span>
                            <svg class="svg-icon">
                                <use href="#overflow-menu"></use>
                            </svg>
                        </button>
                        <div class="tab-list-nav__overflow-menu" data-tab-group-element="overflow-menu-container"></div>
                    </div>                    
                </div>
            </div>
        </div>
     </#list>
</#macro>

<#--  TODO - Update to suit the new design system  -->
<#-- 
    Provides preview of a tab. This allows the user to see 
    a sample of the results on another tab without having to click
    back and forwards. It also improves the user flow by providing
    a link to navigate to the target tab.

    @param extraSearchName The extra search of the documents of the target tab.
    @param documentType The type of documents which is being displayed by
        the extra search.
    @param view Controls how the documents will be presented.
    @param parentQuestion The question containin the tabs facet. This is required
        as extra searches remove facet navigation results. It defaults to the
         global question which is currently in scope.
-->
<#macro Preview extraSearchName documentType="" view="DETAILED" parentQuestion=question>
    <!-- tabs::Preview -->
    <#assign parentQuestion = question>
    <@fb.ExtraResults name=extraSearchName>
        <#if (response.resultPacket.results)!?has_content>
            <div class="search-tab-preview text-muted mb-3">
                <h4>Related ${documentType!}</h4>
                <ol class="list-unstyled">
                    <#list (response.resultPacket.results)![] as result>
                        <@base.Result result=result view=view question=parentQuestion/>
                    </#list>
                </ol>

                <#if (response.customData.stencilsTabsPreviewLink)!?has_content>
                    
                    <#assign searchLink = question.getCurrentProfileConfig().get("ui.modern.search_link")!>
                    <#assign previewLink = response.customData.stencilsTabsPreviewLink!>
                    
                    <a href="${searchLink}${previewLink}" title="See more results for ${tabDisplayName!}">
                        <i class="fas fa-arrow-right mr-1"></i>
                        See more results for ${documentType!} 
                    </a>
                </#if>
            </div>
        </#if>
    </@fb.ExtraResults>
</#macro>

