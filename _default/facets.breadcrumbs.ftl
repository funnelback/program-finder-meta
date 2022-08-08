
<#ftl encoding="utf-8" output_format="HTML" />

<#--
    Display the facet bread crumb which describes the 
    facets/filter options that have been selected by the user
--> 
<#macro Breadcrumb>
    <!-- facets.breadcrumb::Breadcrumb -->
    <#if response.facetExtras.hasSelectedNonTabFacets>
        <section class="facet-breadcrumb">
            <span class="facet-breadcrumb__label">Selected filters:</span>
            <ul class="facet-breadcrumb__list">
                <#list response.facets as facet>
                    <#if facet.selected && facet.guessedDisplayType != "TAB">
                        <#list facet.selectedValues as value>
                            <li class="facet-breadcrumb__item">
                                <a href="${value.toggleUrl}" title="Remove '${facet.name}: ${value.label}'" class="facet-breadcrumb__link">
                                    <svg class="svg-icon svg-icon--expand">
                                        <use href="#close"></use>
                                    </svg>
                                    <span class="sr-only">Clear filter </span>
                                    <strong>${facet.name}:</strong> ${value.label}
                                </a>                                    
                            </li>
                        </#list>
                    </#if>
                </#list>                
            </ul>
        </section>
    </#if>
</#macro>