<#ftl encoding="utf-8" output_format="HTML" />

<#macro RadioFacet>
    <#local facetNames = (question.getCurrentProfileConfig().get("stencils.facets.radio"))!""?split(",") >
    <#list getFacets(response, facetNames) as facet>
        <#if facet.allValues?size != 0>
            <ul class="module-filter__radio-list">
                <#list facet.allValues as value>
                    <li class="module-filter__radio-item">
                        <input type="radio" id="${value.label}" name="${facet.name}" value="${value.label}" <#if value.selected>checked</#if>>
                        <label class="program-finder-display" data-url="${value.toggleUrl}" for="${value.label}">${value.label}</label>
                    </li>
                </#list>
            </ul>
        </#if>
    </#list>
</#macro>

<#macro DropdownFacets>
    <#local facetNames = (question.getCurrentProfileConfig().get("stencils.facets.dropdown"))!""?split(",") >
    <ul class="module-filter__list">
        <#list getFacets(response, facetNames) as facet>
        <#if facet.allValues?size != 0>
        <li class="module-filter__item" tabindex="0">
            <span class="module-filter__item-title<#if facet.selected> active</#if>" aria-haspopup="true" aria-expanded="false">
                ${facet.name}
            </span>
            <div class="module-filter__facets">
                <div class="content-wrapper">
                    <#-- These counts allow us to split the values evenly along the ULs -->
                    <#local breakCount = ((facet.allValues?size) / 3)?floor >
                    <#local valueCount = 0>
                    <#list facet.allValues as value>
                        <#if valueCount == 0>
                            <ul class="module-filter__facets-list" role="menu">
                        </#if>
                        <li class="module-filter__facets-item" role="menuitem">
                                <a href="${value.toggleUrl}" class="module-filter__facets-link<#if value.selected> active</#if>">
                                ${value.label}
                                </a>
                        </li>
                        <#local valueCount = valueCount + 1>
                        <#-- reset once we reach our breakpoint -->
                        <#if valueCount &gt;= breakCount>
                            <#local valueCount = 0>
                        </#if>
                        <#if valueCount == 0 || value_index == (facet.allValues?size - 1) >
                            </ul>
                        </#if>
                    </#list>
                </div>
            </div>
        </li>
        </#if>
        </#list>
    </ul>
</#macro>

<#macro CheckboxFacet>
    <#-- This can be only 1 facet -->
    <#local facetName = (question.getCurrentProfileConfig().get("stencils.facets.checkbox"))!"" >
    <h1>${facetName}</h1>
    <#list getFacets(response, facetName) as facet>
        <ul class="module-filter__checkbox-list">
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