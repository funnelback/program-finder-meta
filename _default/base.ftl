<#ftl encoding="utf-8" output_format="HTML" />
<#-- 
    A collections of common elements used in search implementations.

    If a particular feature requires multiple presentations or is made
    up more than one macro, consider refactoring the feature to 
    its own freemarker template.
->

<#---
  Generates a search form for the current collection, passing through the
  relevant parameters like collection, profile, form, scope, ...

  @param class Optional <code>class</code> attribute to use on the &lt;form&gt; tag
-->
<#macro SearchForm class="">
    <!-- base.SearchForm -->
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

<#--
  Display query blending notice
-->
<#macro Blending>
    <#if (response.resultPacket.QSups)!?size &gt; 0>
        <!-- Blending -->
        <blockquote class="search-blending">
        <span class="fas fa-info-circle"></span>
        Your query has been expanded to <strong><#list response.resultPacket.QSups as qsup> ${qsup.query}<#if qsup_has_next>, </#if></#list></strong>.
        &nbsp;Search for <a class="highlight" href="?${QueryString}&amp;qsup=off" title="Turn off query expansion"><em>${question.originalQuery}</em></a> instead.
        </blockquote>
    </#if>
</#macro>

<#--
  Display spelling suggestion notice
-->
<#macro Spelling>
    <#if (response.resultPacket.spell)??>
        <!-- base.Spelling -->
        <blockquote class="search-spelling">
            Did you mean <em><a class="highlight" href="${question.collection.configuration.value("ui.modern.search_link")}?${response.resultPacket.spell.url}" title="Spelling suggestion">${(response.resultPacket.spell.text)!}</a></em>?
        </blockquote>
    </#if>
</#macro>

<#--
  Display result counts
-->
<#macro Counts>
    <!-- base.Counts -->
    <span class="search-results__total">
        <#if response.resultPacket.resultsSummary.totalMatching == 0>        
            <span class="search-counts-total-matching ">0</span> search results for <strong class="highlight"><@s.QueryClean /></strong>
        </#if>
        <#if response.resultPacket.resultsSummary.totalMatching != 0>
            <span class="search-counts-page-start">${response.resultPacket.resultsSummary.currStart}</span> -
            <span class="search-counts-page-end">${response.resultPacket.resultsSummary.currEnd}</span> of
            <span class="search-counts-total-matching">${response.resultPacket.resultsSummary.totalMatching?string.number}</span>
            <#if question.inputParameterMap["s"]?? && question.inputParameterMap["s"]?contains("?:")><em>collapsed</em> </#if>search results for <strong class="highlight"><@s.QueryClean></@s.QueryClean></strong> <#list response.resultPacket.QSups as qsup>or <strong class="highlight">${qsup.query}</strong><#if qsup_has_next>, </#if></#list>
        </#if>

        <#if (response.resultPacket.resultsSummary.partiallyMatching!0) != 0>
            where <span class="search-counts-fully-matching">${response.resultPacket.resultsSummary.fullyMatching?string.number}</span>
            match all words and <span class="search-counts-partially-matching">${response.resultPacket.resultsSummary.partiallyMatching?string.number}</span>
            match some words.
        </#if>
        <#if (response.resultPacket.resultsSummary.collapsed!0) != 0>
            <span class="search-counts-collapsed">${response.resultPacket.resultsSummary.collapsed}</span>
            very similar results included.
        </#if>
    </span>
</#macro>

<#--
  Message to display when there are no results
-->
<#macro NoResults>
    <#if (response.resultPacket.resultsSummary.totalMatching)!?has_content &&
        response.resultPacket.resultsSummary.totalMatching == 0>
        <!-- base.NoResults -->
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

<#-- Obtain the result mode from the CGI paramters; Valid values are LIST and CARD -->
<#function getDisplayMode question>
    <#-- Default the display mode to "list" -->
    <#assign displayMode = ""> 

    <#-- Get the mode that is currently configured -->
    <#if (question.inputParameterMap["displayMode"])!?has_content>
        <#-- Get the value from the user's selection -->
        <#assign displayMode = question.inputParameterMap["displayMode"]!?upper_case>
    <#elseif (question.getCurrentProfileConfig().get("stencils.results.display_mode"))!?has_content>
        <#-- Get the value from profile config -->
        <#assign displayMode = question.getCurrentProfileConfig().get("stencils.results.display_mode")!?upper_case>
    <#else>
        <#-- Default -->
        <#assign displayMode = "LIST"> 
    </#if>

    <#return displayMode>
</#function>

<#macro DisplayMode>
    <!-- base.displayMode -->
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
    
    <!-- base.SortDropdown -->
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
    <!-- base.LimitDropdown -->
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
    <!-- base.Paging -->
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
    Determines if the results are to be displayed normally
    or grouped together by some criteria
-->
<#macro ResultList nestedRank=-1>
    <#assign displayMode = getDisplayMode(question)>

    <#if (response.customData["stencilsGroupingResults"].mode)!?has_content>
        <@GroupedResults view=displayMode/>
    <#else>
        <@StandardResults view=displayMode nestedRank=-1>
            <#nested>    
        </@StandardResults>
    </#if>
</#macro>

<#--
    Iterate over results and choose the right template depending
    on the results type and what is configured in collection.cfg

    Defaults to <code>&lt;@project.Result /&gt;

    @param nestedRank Before which result to insert the nested content of the macro.
        This is used to insert content (usually an extra search) between results.
-->
<#macro StandardResults view="LIST" nestedRank=-1>
    <!-- base.StandardResults -->
    <article class="search-results__list <#if getDisplayMode(question)! == 'LIST'>search-results__list--list-view</#if>">
        <#list (response.resultPacket.resultsWithTierBars)![] as result>
            <#if result.class.simpleName == "TierBar">
                <@TierBar result=result />
            <#else>
                <#if nestedRank gte 0 && result.rank == nestedRank>
                    <#nested>
                </#if>
                
                <#-- Display the result based on the configured template -->
                <@Result result=result view=view/>                
            </#if>
        </#list>
    </article>
</#macro>

<#--
  Display a tier bar
-->
<#macro TierBar result>
    <!-- base.TierBar -->
    <#-- A tier bar -->
    <#if result.matched != result.outOf>
        <h3 class="search-tier text-muted">Results that match ${result.matched} of ${result.outOf} words</h3>
    <#else>
        <h3 class="sr-only search-tier">Fully-matching results</h3>
    </#if>
    <#-- Print event tier bars if they exist -->
    <#if result.eventDate??>
        <h3 class="text-muted search-tier">Events on ${result.eventDate?date}</h3>
    </#if>
</#macro>

<#--
    Displays a search result using the the right template depending
    on the results type and what is configured in collection.cfg

    Defaults to <code>&lt;@project.Result /&gt;

    @param result The search result to output
-->
<#macro Result result question=question view="LIST">
    <#-- Get result template depending on collection name -->
    <#assign resultDisplayLibrary = question.getCurrentProfileConfig().get("stencils.template.result.${result.collection}")!"" />

    <#-- If not defined, attempt to get it depending on the gscopes the result belong to -->
    <#if !resultDisplayLibrary?has_content>
        <#list (result.gscopesSet)![] as gscope>
            <#assign resultDisplayLibrary = question.getCurrentProfileConfig().get("stencils.template.result.${gscope}")!"" />
            <#if resultDisplayLibrary?has_content>
                <#break>
            </#if>
        </#list>
    </#if>

    <#if .main[resultDisplayLibrary]??>
        <@.main[resultDisplayLibrary].Result result=result view=view />
    <#elseif .main["project"]??>
        <#-- Default Result macro in current namespace -->
        <@.main["project"].Result result=result view=view />
    <#else>
        <div class="alert alert-danger" role="alert">
            <strong>Result template not found</strong>: Template <code>&lt;@<#if resultDisplayLibrary?has_content>${resultDisplayLibrary}<#else>(default namespace)</#if>.Result /&gt;</code>
            not found for result from collection <em>${result.collection}</em>.
        </div>
    </#if>
</#macro>

<#macro GroupedResults view="LIST">
    <!-- base.GroupResults -->
    <#-- Loop through each grouped result tier -->
    <#if (response.resultPacket.results)!?has_content>
        <#list (response.customData["stencilsGroupingResults"].groups)![] as group>
            <div class="mb-3">
                <#-- Create facet link to be used in the title and "see more" -->
                <#assign searchLink = question.getCurrentProfileConfig().get("ui.modern.search_link")!>
                <#assign facetLink = (group.url)!"">

                <span>
                    <h3>
                        <a class="text-muted" href="${searchLink + facetLink}">           
                            ${group.label}
                        </a>
                    </h3>
                </span>
        
                <ol class="list-unstyled fb-result-set fb-display-mode--${view?lower_case}">
                    <#list response.resultPacket.results as result>                        
                        <#-- Display the result based on the configured template -->
                        <#switch ((response.customData["stencilsGroupingResults"].mode)!"")?upper_case>
                            <#case "METADATA">
                                <#if (result.metaData[group.field])!?has_content>
                                    <@Result result=result view=view />
                                </#if>
                                <#break> 
                            <#case "COLLECTION">
                                <#if result.collection == (group.field)!"">
                                    <@Result result=result view=view />
                                </#if>
                                <#break>
                            <#default>                
                                <#break>
                        </#switch>         
                    </#list>
                </ol>

                <#-- See more link -->
                <span class="clearfix">        
                    <a href="${searchLink + facetLink}"> 
                        <i class="fas fa-arrow-right mr-1"></i>
                        See more ${group.label} 
                    </a>
                </span>
            </div>
        </#list>    
    </#if>
</#macro>


<#--
    Iterate over results and choose the right quick view template depending
    on the results type and what is configured in collection.cfg

    Defaults to <code>&lt;@project.Result /&gt;

    @param nestedRank Before which result to insert the nested content of the macro.
        This is used to insert content (usually an extra search) between results.
-->
<#macro QuickViewTemplates>
    <!-- base.StandardResults -->
    <#list (response.resultPacket.resultsWithTierBars)![] as result>
        <#if result.class.simpleName == "TierBar">
            <#-- Ignore tier bars -->
        <#else>            
            <#-- Display the result based on the configured template -->
            <@QuickViewTemplate result=result />                
        </#if>
    </#list>
</#macro>

<#--
    Displays a search result using the the right quick view template depending
    on the results type and what is configured in collection.cfg

    Defaults to <code>&lt;@project.Result /&gt;

    @param result The search result to output
-->
<#macro QuickViewTemplate result question=question>
    <#-- Get result template depending on collection name -->
    <#assign resultDisplayLibrary = question.getCurrentProfileConfig().get("stencils.template.result.${result.collection}")!"" />

    <#-- If not defined, attempt to get it depending on the gscopes the result belong to -->
    <#if !resultDisplayLibrary?has_content>
        <#list (result.gscopesSet)![] as gscope>
            <#assign resultDisplayLibrary = question.getCurrentProfileConfig().get("stencils.template.result.${gscope}")!"" />
            <#if resultDisplayLibrary?has_content>
                <#break>
            </#if>
        </#list>
    </#if>

    <#if .main[resultDisplayLibrary]??>
        <@.main[resultDisplayLibrary].QuickView result=result />
    <#--  
    TODO: Add a default template in case one has not been defined
    <#elseif .main["project"]??>
        <#-- Default Result macro in current namespace 
        <@.main["project"].QuickView result=result/>
    -->
    <#else>
        <div class="alert alert-danger" role="alert">
            <strong>Result template not found</strong>: Template <code>&lt;@<#if resultDisplayLibrary?has_content>${resultDisplayLibrary}<#else>(default namespace)</#if>.Result /&gt;</code>
            not found for result from collection <em>${result.collection}</em>.
        </div>
    </#if>
</#macro>


<#--
  Display the contextual navigation panel only if there are valid values
-->
<#macro ContextualNavigation>
    <#if (response.resultPacket.contextualNavigation.categories)!?has_content &&
        response.resultPacket.contextualNavigation.categories?filter(category -> category.clusters?size gt 0)?size gt 0>
        <!-- base.ContextualNavigation -->
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

<#-- 
    Creates a valid CSS ID by replacing all special characters (except for hypens)
    with underscores (_). Note mulitple underscores will be replace by 1 underscore.

    @param input A string which is to be converted to a valid CSS ID.
-->
<#function getCssID input="">
    <#return (input)!?replace('[^A-Za-z0-9-]+', '_', 'r')>
</#function>
