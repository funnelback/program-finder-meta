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
                    <div 
                        class="overflow-menu__wrapper" 
                        data-tab-group-element="overflow-menu-wrapper"
                        data-component="button-overflow"
                        data-container=".tabs"
                        data-items="[data-tab-group-control]"
                        data-items-container="[data-tab-group-element='tab-list-nav']"
                    >
                        <button 
                            class="overflow-menu__button" 
                            type="button" 
                            data-tab-group-element="overflow-menu-button" 
                            aria-labelledby="View more"
                        >
                            <span class="sr-only">show more tabs</span>
                            <svg class="overflow-menu__icon">
                                <use href="#overflow-menu"></use>
                            </svg>
                        </button>
                        <div class="overflow-menu" data-tab-group-element="overflow-menu-container"></div>
                    </div>                    
                </div>
            </div>
        </div>
     </#list>
</#macro>


<#macro TabsAsRadio facets="" >
    <!-- tabs::TabsAsRadio -->
    <#local facetNames = [] />
    <#if facets != "">
        <#local facetNames = facets?split(",") />
    </#if>

    <#-- 
        List the provided names first rather than the facet order, to
        to preserve the order that was passed in 
    -->
    <div class="facet funnelback-facet no-wysiwyg" data-component="facet">
        <#--  Title for all facets -->
        <div class="facet__group">
            <button 
                type="button" 
                class="facet-group__title facet-group__title--open facet-groups-controller" 
                data-component="collapse-all"
            >
                Refine your results
                <svg class="facet-group__icon facet-group__icon--closed">
                    <use href="#add"></use>
                </svg>
                <svg class="facet-group__icon facet-group__icon--open">
                    <use href="#subtract"></use>
                </svg>
                <span class="sr-only">Collapse all facets</span>
            </button>
        </div>
        <div 
            class="facet-groups"
            data-component="facet-group-content"
            aria-hidden="true"
        >
            <#list facetNames as facetName>
                <#list response.facets![] as facet>
                    <#--  
                        Show only the facets which have been configured. 
                        If nothing has been configured, we want all facets 
                        by default.
                    -->
                    <#if facetName == facet.name || facetNames?has_content == false>
                        <#if facet.allValues?size gt 0>
                            <#--  Facet  -->
                            <div class="facet-group" data-component="facet-group">
                                <#--  
                                    Show the name of the facet as a heading which allows the 
                                    user to expland and collapse the associated facet categories.  
                                -->
                                <button 
                                    type="button" 
                                    class="facet-group__title facet-group__title--open"
                                    data-component="facet-group-control" 
                                    >
                                    ${facet.name}
                                    <svg class="facet-group__icon facet-group__icon--closed">
                                        <use href="#add"></use>
                                    </svg>
                                    <svg class="facet-group__icon facet-group__icon--open">
                                        <use href="#subtract"></use>
                                    </svg>
                                </button>

                                <#--  Facet categories  -->
                                <@FacetCategoriesRadio facet=facet />                                      
                            </div>
                        </#if>
                    </#if>
                </#list>
            </#list>
        </div>
    </div>
</#macro>

<#--  Display all the facet categories as Radio. To be used for radio type facets or tab facets. -->
<#macro FacetCategoriesRadio facet maxCategories=6>
    <!-- tabs::FacetCategoriesRadio -->
    <div
        role="listbox"
        aria-label="${facet.name}"
        class="
        facet-group__list
        facet-group__type-radio-button
        facet-group__list--open
        "
        data-component="facet-group-content"
        data-type="${(facet.guessedDisplayType?lower_case)?replace('_','-')}"
    >
        <#list facet.allValues as category>
            <a 
                aria-selected="${category.selected?then('true', 'false')}"
                role="option" 
                class="facet-group__list-item ${category.selected?then("facet-group__list-item-selected","unchecked")}  <#if category_index gt 5>facet-group__list-item--hidden</#if>" 
                href="${category.toggleUrl!}" 
                title="Refine by '${category.label}'" 
                data-component="facet-group__list-item">
                
                ${category.label}  

                <#if category.count?? && !category.selected>
                    <span class="facet-group__results-number">${category.count}</span>
                </#if>
            </a>
        </#list>

        <#if facet.allValues?size gt maxCategories?number >
            <button
                type="button"
                class="facet-group__show-more"
                data-component="facet-group-show-more-button"
            >
                <svg class="facet-group__icon"><use href="#add"></use></svg>
                Show more
                <span class="facet-group-show-more__hidden-items-count">
                    ( ${facet.allValues?size - maxCategories?number} )
                </span>
            </button>
        </#if>
    </div>
</#macro>


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

