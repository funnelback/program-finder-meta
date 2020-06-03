<#ftl encoding="utf-8" output_format="HTML" />
<#import "base.ftl" as base />
<#import "facets.ftl" as facets />
<#import "results.ftl" as results />
<#import "history_cart.ftl" as history_cart />

<#macro CartTemplate>
    <@results.CartTemplate/>
</#macro>

<#-- Include all relevant autoc templates here -->
<#macro AutoCompleteTemplates>
    <@results.AutoCompleteTemplate/>
</#macro>

<#macro AutoComplete>
  <#if question.collection.configuration.hasValue("stencils.auto-completion.datasets")>
    jQuery('#query').qc({
        program: '<@s.cfg>auto-completion.program</@s.cfg>',
        alpha: '<@s.cfg>auto-completion.alpha</@s.cfg>',
        show: '<@s.cfg>auto-completion.show</@s.cfg>',
        sort: '<@s.cfg>auto-completion.sort</@s.cfg>',
        length: '<@s.cfg>auto-completion.length</@s.cfg>',
        classes: {
            dataset: "module-search__item",
        },
        datasets:{
          <#list question.collection.configuration.value("stencils.auto-completion.datasets")!?split(",") as dataset>
            ${dataset}: {
                name: '${question.collection.configuration.value("stencils.auto-completion.datasets.${dataset}.name")!}',
                collection: '${question.collection.configuration.value("stencils.auto-completion.datasets.${dataset}.collection")!}',
                profile: '${question.collection.configuration.value("stencils.auto-completion.datasets.${dataset}.profile")!question.profile}',
                show: '${question.collection.configuration.value("stencils.auto-completion.datasets.${dataset}.show")!"10"}'
                <#if dataset != "organic">
                  , template: {
                    suggestion: jQuery('#auto-completion-${dataset}').text()
                  }
                </#if>
            }<#if dataset_has_next>,</#if>
          </#list>
        }
    });
  </#if>
</#macro>

<#macro SearchForm>
    <@base.SearchForm>
    </@base.SearchForm>
</#macro>

<#macro Facets>
    <section class="module-filter js-module-filter">

        <div class="module-filter__wrapper  content-wrapper">
            <h2 class="module-filter__title">Filter by:</h2>

            <div class="module-filter__wrapper-mobile">
                <@facets.DropdownFacets/>
                
                <@facets.CheckboxFacet/>
            </div>
        </div>
    </section>
</#macro> 

<#macro FacetBreadBox>
    <#if response.facetExtras.hasSelectedNonTabFacets>
    <section class="filter-list">
        <h3 class="filter-list__title">Filters:</h3>
        <ul class="filter-list__list">
            <#list response.facets as facet>
                <#if facet.selected && facet.guessedDisplayType != "TAB">
                    <#list facet.selectedValues as value>
                    <li class="filter-list__item">
                        <a href="${value.toggleUrl}" title="Remove '${facet.name}: ${value.label}'" class="filter-list__link"><span class="sr-only">Clear filter </span><strong>${facet.name}:</strong> ${value.label}</a>
                    </li>
                    </#list>
                </#if>
            </#list>
        </ul>
    </section>
    </#if>
</#macro>

<#macro Results>

    <@base.ResultCount />
    <@base.NoResults />  

    <div class="fb-curator">
        <article class="search-results__list--list-view">
            <@base.CuratorExhibits "center" />
        </article>

        <article class="search-results__list--list-view">
            <@base.BestBets />
        </article>
    </div>

    <article class="search-results__list">
        <#list (response.resultPacket.resultsWithTierBars)![] as result>
            <#if result.class.simpleName == "TierBar">
                <@results.TierBar tierbar=result />
            <#else>
                <@results.Result result=result />
            </#if>
        </#list>
    </article>

</#macro>

<#macro Pagination>
<#if response.resultPacket.resultsSummary.nextStart?exists || response.resultPacket.resultsSummary.prevStart?exists>
<section class="pagination">
    <nav class="pagination__nav" aria-label="Pagination Navigation">
        <@fb.Prev>
        <div class="pagination__item pagination__item-navigation pagination__item-previous">
            <a class="pagination__link" rel="prev" href="${fb.prevUrl}">
                <span class="pagination__label">Prev</span>
            </a>
        </div>
        </@fb.Prev>
        <ul class="pagination__pages-list">
        <@fb.Page numPages=5>
            <li class="pagination__item<#if fb.pageCurrent> pagination__item--active</#if>">
                <#if !fb.pageCurrent>
                    <a class="pagination__link" href="${fb.pageUrl}" aria-label="Go to Page ${fb.pageNumber}">
                <#else>
                    <span class="pagination__current"  aria-label="Current Page, Page ${fb.pageNumber}">
                </#if>
                <span class="pagination__label">${fb.pageNumber}</span>
                <#if !fb.pageCurrent>
                    </a>
                <#else>
                    </span>
                </#if>
            </li>
        </@fb.Page>
        </ul>
        <@fb.Next>
        <div class="pagination__item pagination__item-navigation pagination__item-next">
            <a class="pagination__link" href="${fb.nextUrl}" rel="next">
                <span class="pagination__label">Next</span>
            </a>
        </div>
        </@fb.Next>
    </nav>
</section>
</#if>
</#macro>