<#ftl encoding="utf-8" output_format="HTML" />

<#--
    Radio facets

    The facets to display as radio buttons are configured in the `stencils.facets.radio`
    configuration parameter as a comma-separated list.

    If this configuration parameter is not present, or is an empty string, then this
    section is not displayed.
-->
<#macro RadioFacet>
    <#local facetNamesStr = question.currentProfileConfig.get("stencils.facets.radio")!"">
    <#if facetNamesStr?has_content>
        <#local facetNames = facetNamesStr?split(",") >
        <#if facetNames?has_content>
        <div class="module-filter__wrapper-mobile">
            <#nested>
            <#list getFacets(response, facetNames) as facet>
                <#if facet.allValues?size != 0>
                    <!-- facets.RadioFacet -->
                    <ul class="module-filter__list module-filter__radio-list">
                        <#list facet.allValues as value>
                            <li class="module-filter__radio-item">
                                <input type="radio" id="${value.label}" name="${facet.name}" value="${value.label}" <#if value.selected>checked</#if>>
                                <label class="program-finder-display" data-url="${value.toggleUrl}" for="${value.label}">${value.label}</label>
                            </li>
                        </#list>
                    </ul>
                </#if>
            </#list>
        </div>
        </#if>
    </#if>
</#macro>

<#macro DropdownFacets>
    <#local facetNames = question.currentProfileConfig.get("stencils.facets.dropdown")!"">
    <!-- facets.DropdownFacets -->
    <ul class="module-filter__list">
        <#if facetNames?has_content>
            <#-- If facets are explicitly defined in the config, use those -->
            <#list getFacets(response, facetNames?split(",")) as facet>
                <#if facet.allValues?size != 0>
                    <@DropdownFacetItem facet=facet />
                </#if>
            </#list>
        <#else>
            <#-- If facets aren't limited by the config, then iterate through all of them -->
            <#list response.facets as facet>
                <#if facet.allValues?size != 0>
                    <@DropdownFacetItem facet=facet />
                </#if>
            </#list>
        </#if>
    </ul>
</#macro>

<#macro DropdownFacetItem facet>
<li>
    <details class="module-filter__item">
        <summary class="module-filter__item-title">
            ${facet.name}
        </summary>
        <div class="module-filter__facets">
            <div class="content-wrapper">
                <ul class="module-filter__facets-list" role="menu">
                <#list facet.allValues as value>
                    <li class="module-filter__facets-item" role="menuitem">
                        <a href="${value.toggleUrl}" class="module-filter__facets-link<#if value.selected> active</#if>">
                            ${value.label}
                        </a>
                    </li>
                </#list>
                </ul>
            </div>
        </div>
    </details>
</li>
</#macro>

<#macro CheckboxFacet>
    <#-- This can be only 1 facet -->
    <#local facetName = (question.getCurrentProfileConfig().get("stencils.facets.checkbox"))!"" >
    <!-- facets.CheckboxFacet -->
    <h1>${facetName}</h1>
    <#list getFacets(response, facetName) as facet>
        <ul class="module-filter__list module-filter__checkbox-list">
            <#list facet.allValues as value>
            <li class="module-filter__checkbox-item">
                <input <#if value.selected>checked</#if> type="checkbox" id="${value.label?lower_case?replace(" ", "-")}" name="compare" value="${value.label}">
                <label class="module-filter__label" for="campus" data-url="${value.toggleUrl}">${value.label}</label>
            </li>
            </#list>
        </ul>
    </#list>
    <script type="text/javascript">
        jQuery(document).ready( function() {
           $(".module-filter__label").click(function() {
               var url = $(this).attr("data-url");
               window.location = url;
           });
        });
    </script>
</#macro>

<#--
    Display the facet bread crumb which describes the 
    facets/filter options that have been selected by the user
--> 
<#macro FacetBreadBox>
    <#if response.facetExtras.hasSelectedNonTabFacets>
        <!-- facets.FacetBreadBox -->
        <section class="filter-list">
            <h3 class="filter-list__title">Filters:</h3>
            <ul class="filter-list__list">
                <#list response.facets?filter(facet -> facet.selected && facet.guessedDisplayType != "TAB") as facet>
                    <#list facet.selectedValues as value>
                        <li class="filter-list__item">
                            <a href="${value.toggleUrl}" title="Remove '${facet.name}: ${value.label}'" class="filter-list__link"><span class="sr-only">Clear filter </span><strong>${facet.name}:</strong> ${value.label}</a>
                        </li>
                    </#list>
                </#list>
            </ul>
        </section>
    </#if>
</#macro>

<#-- Run the nest code if the list of specified facets have at least one facet category -->
<#macro HasFacets facets="">
    <#if facets?split(",")?filter( x -> response.facets?filter(y -> x == y.name && y.allValues?size gt 0)?size gt 0)?size gt 0>
        <#nested>
    </#if>
</#macro>

<#-- Runs the nested code only when a certain facet is selected -->
<#macro IsSelected facetName="" categoryLabel="">
    <#if !facetName?has_content || !categoryLabel?has_content>   
        <#-- 
            By default, we want to run the nested code if no valid
            configurations are supplied.
        -->
        <#nested>
    <#elseif (response.facets![])?filter(facet -> facet.name?upper_case == facetName?upper_case && facet.selectedValues?filter(category -> category.label?upper_case == categoryLabel?upper_case)?size gt 0)?size gt 0>
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
