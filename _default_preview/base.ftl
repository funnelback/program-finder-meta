<#ftl encoding="utf-8" output_format="HTML" />
<#---
  Generates a search form for the current collection, passing through the
  relevant parameters like collection, profile, form, scope, ...

  @param class Optional <code>class</code> attribute to use on the &lt;form&gt; tag
-->
<#macro SearchForm class="">
    <form action="${question.collection.configuration.value("ui.modern.search_link")}" method="GET"<#if class?has_content> class="${class}"</#if>>
        <div class="module-search__group">
            <input type="hidden" name="collection" value="${question.collection.id}">
            <#list ["enc", "form", "scope", "lang", "profile"] as parameter>
              <@s.IfDefCGI name=parameter><input type="hidden" name="${parameter}" value="${question.inputParameterMap[parameter]!}"></@s.IfDefCGI>
            </#list>
            <label for="query" class="sr-only">Search</label>
            <input name="query" id="query" type="search" class="module-search__query" autocomplete="off" placeholder="Search for ${question.collection.configuration.value("stencils.I18n.finder_type_primary", "Course")?lower_case}s, a career or topic" value="${question.query!}">
            <button type="submit" class="module-search__btn"><span class="sr-only">Search</span></button>
        </div>
        <#nested>
    </form>
</#macro>

<#macro TypeDisplay name="">
    <h3 class="search-results__section-title">${name} (<span>${response.resultPacket.resultsSummary.totalMatching!}</span>)</h3>
</#macro>

<#macro Count>
    <#if (response.resultPacket.resultsSummary.totalMatching)! != 0>
        <span class="search-results__total text-right">Showing <span>${response.resultPacket.resultsSummary.currStart!}</span> - <span>${response.resultPacket.resultsSummary.currEnd!}</span> of <span>${response.resultPacket.resultsSummary.totalMatching!}</span> Results</span>
    </#if>
</#macro>

<#--
  Message to display when there are no results
-->
<#macro NoResults>
    <#if (response.resultPacket.resultsSummary.totalMatching)!?has_content &&
        response.resultPacket.resultsSummary.totalMatching == 0>
        <section class="module-info content-wrapper">
            <figure class="module-info__bg">
                <img src="/s/resources/${question.collection.id}/${question.profile}/css/mysource_files/no-results-icon.svg" alt="">
            </figure>
            <h2 class="module-info__title">No matching results</h2>
            <p class="module-info__desc">
                Your search for <strong><@s.QueryClean /></strong> did not return any results.
            </p>
        </section>
    </#if>
</#macro>

<#macro DisplayMode>
    <a href='${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, "displayMode")}&displayMode=card' 
        class="search-results__icon search-results__icon--box <#if getDisplayMode(question)! == 'CARD'>active</#if>"
        title="Display results as cards">
        <span class="sr-only">Card view</span>
    </a>
    <a href='${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, "displayMode")}&displayMode=list' 
        class="search-results__icon search-results__icon--list <#if getDisplayMode(question)! == 'LIST'>active</#if>"
        title="Display results as a list">
        <span class="sr-only">List view</span>
    </a>
</#macro>

<#--
  Generate an HTML drop-down for sorting results

  @param options Map of sort options, where keys are the `sort` paratmeter (e.g. `date`) and values the label (e.g. `Date (Newest first)`)
-->
<#macro SortDropdown options={
  "": "Relevance",
  "date": "Date (Newest first)",
  "adate": "Date (Oldest first)",
  "title": "Title (A-Z)",
  "dtitle": "Title (Z-A)",
  "prox": "Distance",
  "url": "URL (A-Z)",
  "durl": "URL (Z-A)",
  "shuffle": "Shuffle"} >

    <section class="dropdown-list">
        <button class="dropdown-list__link js-dropdown-list__link" aria-haspopup="true" aria-expanded="false">
            <span>${(options[question.inputParameterMap["sort"]])!"Sort by"}</span>
        </button>
        <ul class="dropdown-list__list" role="listbox" tabindex="-1"">
            <#list options as key, value>
                <li role="option">                
                    <a class="dropdown-list__list-link" title="Sort by ${value}" href="${question.collection.configuration.value("ui.modern.search_link")}?${removeParam(QueryString, "sort")}&sort=${key}">
                        <#if ((options[question.inputParameterMap["sort"]])!"") == value>
                            <i class="fas fa-check"></i>
                        </#if>
                        ${value}
                    </a>
                </li>
            </#list>
        </ul>
    </section>
</#macro>

<#--
  Generate an HTML drop-down to control the number of results

  @param limits Array of number of results to provide (defaults to 10, 20, 50)
-->
<#macro LimitDropdown limits=[10, 20, 50]>

    <section class="dropdown-list">
        <button class="dropdown-list__link js-dropdown-list__link" aria-haspopup="true" aria-expanded="false">
            <span>${question.inputParameterMap["num_ranks"]!"10"}</span>
        </button>
        <ul class="dropdown-list__list" role="listbox" tabindex="-1"">
            <#list limits as limit>
                <li role="option">
                    <a class="dropdown-list__list-link" title="Limit to ${limit} results" href="${question.collection.configuration.value("ui.modern.search_link")}?${removeParam(QueryString, "num_ranks")}&num_ranks=${limit}">
                        <#if ((question.inputParameterMap["num_ranks"]?number)!0) == limit>
                            <i class="fas fa-check"></i>
                        </#if>
                        ${limit} results
                    </a>
                </li>
            </#list>
        </ul>
    </section>
</#macro>


<#--
  Display paging controls
-->
<#macro Paging>
    <section class="pagination">
        <nav class="pagination__nav" aria-label="Pagination Navigation">
            <#-- Previous page -->
            <#if (response.customData.stencilsPaging.previousUrl)??>
                <div class="pagination__item pagination__item-navigation pagination__item-previous">
                    <a class="pagination__link" rel="prev" href="${response.customData.stencilsPaging.previousUrl}">
                        <span class="pagination__label">Prev</span>
                    </a>
                </div>
            </#if>

            <#-- Sibling pages -->
            <#if (response.customData.stencilsPaging.pages)!?has_content &&
                response.customData.stencilsPaging.pages?size gt 1>
                <ul class="pagination__pages-list">
                    <#list response.customData.stencilsPaging.pages as page>
                        <#if page.selected>
                            <li class="pagination__item pagination__item--active">

                                <span class="pagination__current" aria-label="Current Page, Page ${page.number}">
                                    <span class="pagination__label">${page.number}</span>
                                </span>                            
                            </li>
                        <#else>                    
                            <li class="pagination__item">
                                <a class="pagination__link" href="${page.url}" aria-label="Goto Page 1">
                                    <span class="pagination__label">${page.number}</span>
                                </a>
                            </li>
                        </#if>
                    </#list>
                </ul>
            </#if>

            <#-- Next page -->
            <#if (response.customData.stencilsPaging.nextUrl)??>            
                <div class="pagination__item pagination__item-navigation pagination__item-next">
                    <a class="pagination__link" rel="next" href="${response.customData.stencilsPaging.nextUrl}" >
                        <span class="pagination__label">Next</span>
                    </a>
                </div>
            </#if> 
        </nav>
    </section>
</#macro>

<#--
  Display the contextual navigation panel only if there are valid values
-->
<#macro ContextualNavigation>
    <#if (response.resultPacket.contextualNavigation.categories)!?has_content &&
        response.resultPacket.contextualNavigation.categories?filter(category -> category.clusters?size gt 0)?size gt 0>
        <section class="related-links">
            <h2 class="related-links__title">
                Related searches for <strong><@s.QueryClean /></strong>
            </h2>
            <ul class="related-links__list">
                <#list (response.resultPacket.contextualNavigation.categories)![] as category>
                        <#list category.clusters as cluster>
                            <li class="related-links__item">
                                <a href="${cluster.href}" class="related-links__link">
                                    ${cluster.label?replace("...", " <strong>${response.resultPacket.contextualNavigation.searchTerm} </strong> ")?no_esc}
                                </a>
                            </li>
                        </#list>
                </#list>
            </ul>
        </section>
    </#if>
</#macro>