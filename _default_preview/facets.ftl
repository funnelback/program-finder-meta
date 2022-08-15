<#ftl encoding="utf-8" output_format="HTML" />
<#-- 
  This template contains markup and logic related to the 
  faceted navigation feature. It provides the markup and logic
  to display both the facet and facet categories.
-->

<#macro Facets facets="" maxCategories=6 >
    <!-- facets::Facets -->
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
                <svg class="svg-icon svg-icon--closed">
                    <use href="#add"></use>
                </svg>
                <svg class="svg-icon svg-icon--open">
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
                                    <svg class="svg-icon svg-icon--closed">
                                        <use href="#add"></use>
                                    </svg>
                                    <svg class="svg-icon svg-icon--open">
                                        <use href="#subtract"></use>
                                    </svg>
                                </button>

                                <#--  Facet categories  -->
                                <@FacetCategories facet=facet maxCategories=maxCategories />
                                      
                                <#--  Clear all link - Provide the ability to remove all selections from the current facet.  -->
                                <#if facet.selected>
                                    <a href="${facet.unselectAllUrl}" class="facet-group__clear" title="Remove all '${facet.name}' refinements">
                                        <svg class="svg-icon svg-icon--large">
                                        <title>Close search</title>
                                        <use href="#close"></use>
                                        </svg> Clear all
                                    </a>
                                </#if>
                            </div>
                        </#if>
                    </#if>
                </#list>
            </#list>
        </div>
    </div>
</#macro>

<#--  Display all the facet categories for the given facet.  -->
<#macro FacetCategories facet maxCategories=6>
    <!-- facets::FacetCategories -->
    <div
        role="listbox"
        <#if facet.guessedDisplayType == "CHECKBOX">aria-multiselectable="true"</#if>
        aria-label="${facet.name}"
        class="
        facet-group__list
        facet-group__type-${(facet.guessedDisplayType?lower_case)?replace('_','-')}
        facet-group__list--open
        "
        data-component="facet-group-content"
        data-type="${(facet.guessedDisplayType?lower_case)?replace('_','-')}"
    >
        <#list facet.allValues as category>
            <a 
                <#if facet.guessedDisplayType == "CHECKBOX" || facet.guessedDisplayType == "RADIO_BUTTON">
                    aria-selected="${category.selected?then('true', 'false')}"
                <#elseif facet.guessedDisplayType == "SINGLE_DRILL_DOWN" && category.selected>
                    aria-selected="true"                  
                </#if> 
                role="option" 
                class="facet-group__list-item ${category.selected?then("facet-group__list-item-selected","unchecked")}  <#if category_index gt 5>facet-group__list-item--hidden</#if>" 
                href="${category.toggleUrl!}" 
                title="Refine by '${category.label}'" 
                data-component="facet-group__list-item">
                
                <#--  Display a little symbol to signify a drill down facet has been selected.  -->
                <#if facet.guessedDisplayType == "SINGLE_DRILL_DOWN" && category.selected>
                    <i class="fas fa-level-up-alt"></i>
                </#if> 
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
                <svg class="svg-icon"><use href="#add"></use></svg>
                Show more
                <span class="facet-group-show-more__hidden-items-count">
                    ( ${facet.allValues?size - maxCategories?number} )
                </span>
            </button>
        </#if>
    </div>
</#macro>

<#--  TODO - Update to suit the new design system  -->
<#-- Displays facet catergories in a facet as a dropdown list -->
<#macro DropdownFacet facets=[]>
    <!-- facets::DropdownFacet -->

    <#-- 
        Find all the facets with values and determine if we want to display all tabs or just the tabs specified 
    -->
    <#local facetsToDisplay = (response.facets![])?filter(facet -> 
            (!facets?has_content || facets?seq_contains(facet.name)) 
            && facet.allValues?size gt 0
        )
    >

    <#-- Display the facets as a list -->
    <#list facetsToDisplay as facet>
        <#list facet.allValues>
            <section class="dropdown-list">        
                <span class="sr-only">Refine by ${(facet.name)!}</span>
                <button class="dropdown-list__link js-dropdown-list__link" aria-haspopup="true" aria-expanded="false">
                    <#-- Determine what the label of the dropdown should be -->
                    <#local selectedFacetCategories = facet.allValues?filter(value -> value.selected)>

                    <#if selectedFacetCategories?size gt 0>
                        <#-- Display all the selected facet categories as the label -->
                        <span>${(selectedFacetCategories?map(value -> value.label)?join(", "))!}</span>
                    <#else>
                        <#-- Display the facet name as the label -->
                        <span>${(facet.name)!}</span>
                    </#if>                    
                </button>
                <ul class="dropdown-list__list" role="listbox" tabindex="-1"> 
                    <#items as value>
                        <li role="option">
                            <a class="dropdown-list__list-link" title="Refine by ${value}" href="${question.collection.configuration.value("ui.modern.search_link")}${value.toggleUrl!}">
                                <#if (value.selected)!false>
                                    <i class="fas fa-check"></i>
                                </#if>
                                ${value.label!}
                            </a>                         
                        </li>
                    </#items>          
                </ul>
            </section>  
        </#list>
    </#list> 
</#macro>

<#-- 
    Displays all available facet categories available for a facets
    as a persistent list. It is intended to be used to display an 
    A-Z index for browsing documents such as services (in a directory
    of service) or programs in a Program Finder.
-->
<#macro ListFacets facets=[]>
    <!-- facets.ListFacets -->
    
    <#-- 
        Find all the facets with values and determine if we want to display all tabs or just the tabs specified 
    -->
    <#local facetsToDisplay = (response.facets![])?filter(facet -> 
            (!facets?has_content || facets?seq_contains(facet.name)) 
            && facet.allValues?size gt 0
        )
    >
    
    <#-- Display the facets as a list -->
    <#list facetsToDisplay as facet>
        <div class="az-index">
            <#list facet.allValues>
                <ul class="az-index__list">        
                    <span class="sr-only">Refine by ${(facet.name)!}</span> 
                    <#items as value>
                        <li class="az-index__list-item">
                            <#if value.count gt 0>
                            <#-- Enabled case -->                        
                                <a href="${question.collection.configuration.value("ui.modern.search_link")}${value.toggleUrl!}" 
                                    class="az-index__link ${value.selected?then("active","")}"
                                    title="Refine by ${value.label!} which has about ${(value.count)!"0"?string} results"
                                >
                                    <span class="sr-only">Navigate to</span> 
                                    ${(value.label)!} 
                                </a>                            
                            <#else>
                            <#-- Disabled case -->                        
                                <span
                                    aria-disabled="true"
                                    class="az-index__link disabled"
                                >
                                    <span class="sr-only">
                                        Navigate to
                                    </span>
                                    ${(value.label)!}                                                             
                                <span>
                            </#if>
                        </li>
                    </#items>          
                </ul>
            </#list>
        </div>
    </#list>
</#macro>

<#macro ClearAllFacets>
    <!-- facets::ClearAllFacets -->
    <#if (response.facetExtras.hasSelectedNonTabFacets)!>
        <a href="${(response.facetExtras.unselectAllFacetsUrl)!}"
        class="search-results__tools-link highlight">Clear all filters</a>
    </#if>
</#macro>

<#-- Run the nest code if the list of specified facets have at least one facet category -->
<#macro HasFacets facets="">
    <#if facets?split(",")?filter( x -> response.facets?filter(y -> x == y.name && y.allValues?size gt 0)?size gt 0)?size gt 0>
        <#nested>
    </#if>
</#macro>

<#-- Runs the nested code only when a certain facet is selected -->
<#macro IsSelected facetName="" categoryLabels=[]>
    <#if !facetName?has_content || !categoryLabels?has_content>   
        <#-- 
            By default, we want to run the nested code if no valid
            configurations are supplied.
        -->
        <#nested>
    <#elseif (response.facets![])?filter(facet -> facet.name?upper_case == facetName?upper_case && facet.selectedValues?filter(category -> categoryLabels?filter(value -> value?upper_case == category.label?upper_case)?size gt 0)?size gt 0)?size gt 0>
        <#-- 
            Given that valid configurations are supplied, we ony 
            want to show the nested content of the facet has been selected.
        -->
        <#nested>
    </#if>
</#macro>


<#-- Runs the nested code only when a certain facet is selected -->
<#macro IsNotSelected facetName="" categoryLabel="">
    <#-- 
        Show the nested content only whent he supplied facet category
        has not been selected
    -->
    <#if (response.facets![])?filter(facet -> facet.name?upper_case == facetName?upper_case && facet.selectedValues?filter(category -> category.label?upper_case == categoryLabel?upper_case)?size gt 0)?size == 0>
        <#nested>
    </#if>
</#macro>



