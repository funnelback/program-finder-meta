<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
    Include all the cart templates which determines 
    how items in the cart are to be displayed.
-->
<#macro CartTemplate>
    <@results.CartTemplate/>
</#macro>

<#-- Display the search form required to query this search implementation -->
<#macro SearchForm>
    <@base.SearchForm />
</#macro>

<#-- Display the facets allowing the user to refine the search results -->
<#macro Facets>
    <section class="module-filter module-filter--dark js-module-filter content-wrapper">
        <div class="module-filter__wrapper">
            <h2 class="module-filter__title">Refine by<span class="mobile-hide">:</span></h2>

            <div class="module-filter__wrapper-mobile">
                <@facets.RadioFacet/>
            </div>
            
            <h2 class="module-filter__title">Filter by<span class="mobile-hide">:</span></h2>
            <div class="module-filter__wrapper-mobile">
                <@facets.DropdownFacets/>
            </div>
            
            <a href="#" class="btn__compare">
                <span class="btn__compare-text">${question.collection.configuration.value("stencils.I18n.finder_type_primary", "Course")?cap_first} comparison</span>
                <span class="btn__compare-total">0</span>
            </a>
        </div>
    </section>
</#macro> 


<#-- Displays the search results -->
<#macro Results name="Programs">
    <@base.TypeDisplay name=name />
    <@base.Count />
    <@base.NoResults />  

    <article class="search-results__list">
        <#list (response.resultPacket.resultsWithTierBars)![] as result>
            <#if result.class.simpleName == "TierBar">
                <@results.TierBar tierbar=result />
            <#else>
                <#if name!?upper_case == (question.collection.configuration.value("stencils.I18n.finder_type_primary", "Course") + "s")?upper_case >
                    <@programs.Result result=result />
                <#else>
                    <@courses.Result result=result />
                </#if>
            </#if>
        </#list>
    </article>
</#macro>




