<#ftl encoding="utf-8" output_format="HTML" />

<#-- Display the search form required to query this search implementation -->
<#macro SearchForm>
    <@base.SearchForm />
</#macro>

<#macro Results>                    
    <!-- project.Results -->
    <#-- Display the facets for the program finder -->
    <@project.Facets />

    <#-- SEARCH RESULTS -->
    <section class="search-results">
        <div class="content-wrapper">
            <div class="search-results__tools cleafix">
                <h2 class="search-results__tools-title">Search results</h2>
                
                <#-- Display the facets which have been selected by the user -->
                <@facets.FacetBreadBox/>

                <div class="search-results__tools-right clearfix">
                    <@base.Counts />
                    <#if (response.facetExtras.hasSelectedNonTabFacets)!>
                        <a href="${response.facetExtras.unselectAllFacetsUrl!}"
                        class="search-results__tools-link highlight">Clear all filters</a>
                    </#if>
                    <#-- TODO - Figure out how to style this                     
                    <@base.LimitDropdown />
                    <@base.SortDropdown />  
                    -->
                    <@base.DisplayMode />
                </div>
            </div>

            
            <#-- 
                Curator - We only want to display curator if there are any to avoid
                excessive padding/margins.
            -->
            <@curator.HasCurator position="center">
                <article class="search-results__list--list-view fb-curator">
                    <@curator.Curator "center" />
                </article>
            </@curator.HasCurator>

            <#-- 
                Best Bets - We only want to display best bets if there are any to avoid
                excessive padding/margins. 
            -->
            <@curator.HasBestBets>
                <article class="search-results__list--list-view fb-curator">
                    <@curator.BestBets />
                </article>
            </@curator.HasBestBets>

        </div>                        
        
        <#-- 
            Hide the organic/normal results on the all tab as we only 
            want to display the extra searches.  
        -->
        <@facets.IsNotSelected facetName="Tabs" categoryLabel="All">
            <div class="content-wrapper">
                <@base.NoResults />
                <@base.ResultList />
                <@base.QuickViewTemplates />
                <@base.Paging />
            </div>
        </@facets.IsNotSelected>

        <#-- Programs extra search -->
        <@extra_search.Preview  extraSearchName="programs" documentType=question.getCurrentProfileConfig().get("stencils.I18n.finder_type_primary") + "s" />
        
        <#-- Courses extra search -->
        <@extra_search.Preview  extraSearchName="courses" documentType=question.getCurrentProfileConfig().get("stencils.I18n.finder_type_secondary") + "s" />
    </section>
    <#-- END SEARCH RESULTS -->


    <#-- Curator - Bottom -->
    <@curator.HasCurator position="bottom">
        <div class="content-wrapper">
            <div class="fb-curator">
                <article class="search-results__list--list-view">
                    <@curator.Curator position="bottom" />
                </article>
            </div>
        </div>
    </@curator.HasCurator>

    <#-- Contextual navigation -->
    <@base.ContextualNavigation />
</#macro>


<#-- Display the facets allowing the user to refine the search results -->
<#macro Facets>
    <!-- project.Facets -->
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
            
            <a href="#" class="btn__compare <#if !(session.resultsCart)!?has_content>hidden</#if>">
                <span class="btn__compare-text">${((question.getCurrentProfileConfig().get("stencils.I18n.finder_type_primary"))!"Course")?cap_first} comparison</span>
                <span class="btn__compare-total">0</span>
            </a>
        </div>
    </section>
</#macro> 

<#-- 
    Macro decides how each result should be presented. 

    @param result An individual result fron the data model
    @param view An uppercase string which represents how
        the result should be displayed. Defaults to DETAILED.
-->
<#macro Result result view="LIST">
    <#switch view?upper_case>
        <#case "CARD">
            <@CardView result=result />
            <#break>
        <#case "LIST">
            <@ListView result=result />
            <#break>
        <#default>
            <@ListView result=result />
    </#switch>
</#macro>

<#--
    Stardard view of a result which is to be displayed in the 
    main section of the search engine result page (SERP)
    @param result An individual result fron the data model
-->
<#macro ListView result>
    <@GenericView result=result cardClass="fb-card--list" />
</#macro>

<#--
    Card view of a result which is to be displayed in the 
    main section of the search engine result page (SERP)
    @param result An individual result fron the data model
-->
<#macro CardView result>
    <@GenericView result=result cardClass="fb-card--fixed" />
</#macro>

<#--
    A generic view used to drive both the the list and card view
    @param result An individual result fron the data model
-->
<#macro GenericView result cardClass="fb-card--fixed">
    <!-- project.GenericView -->
    <article class="search-results__item search-results__item--default">
        <figure class="search-results__bg">
            <#if (result.listMetadata["image"][0])!?has_content>
                <#--  <img class="deferred rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="/stencils/resources/base/v15.8/img/pixel.gif" data-deferred-src="${result.listMetadata["image"][0]}">   -->
                <img alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/random/160x160?${(result.title)!''?url}"> 
            <#else>
                <img alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/random/160x160?${(result.title)!''?url}"> 
            </#if>
        </figure>
        <div class="search-results__content">
            <#if (result.title)!?has_content>
                <h3 class="search-results__title">
                    <#-- Show an icon to represented the file type of the current document -->
                    <#switch result.fileType>
                        <#case "pdf">
                            <i class="far fa-file-pdf" aria-hidden="true"></i>
                            <#break>
                        <#case "doc">
                        <#case "docx">
                        <#case "rtf">
                            <i class="far fa-file-word" aria-hidden="true"></i>
                            <#break>
                        <#case "xls">
                        <#case "xlsx">
                            <i class="far fa-file-excel" aria-hidden="true"></i>
                            <#break>
                        <#case "ppt">
                        <#case "pptx">
                            <i class="far fa-file-powerpoint" aria-hidden="true"></i>
                            <#break>
                    </#switch>

                    <#--  <span class="fas fa-briefcase text-muted pull-right small mr-2" title="Job"></span>  -->
                    <a href="${result.clickTrackingUrl!}" title="${result.title!}" class="search-results__link">
                        <@s.boldicize>
                            <@s.Truncate length=90>
                                ${(result.title)!} 
                            </@s.Truncate>
                        </@s.boldicize>
                    </a>
                </h3>
            </#if>
            
            <#-- Pretty version of the url of the document -->
            <cite>
                <@s.Truncate length=90>
                    ${(result.displayUrl)!}
                </@s.Truncate>
                
            </cite>

            
            <#-- Summary -->
            <p class="search-results__desc">
                <@s.boldicize>
                    ${result.summary!?no_esc}
                </@s.boldicize>
            </p>

            <section class="tags">
                <ul class="tags__list">
                    <li class="tags__item">
                        Lorem
                    </li>
                    <li class="tags__item">
                        Lorem ipsum
                    </li>
                    <li class="tags__item">
                        Lorem
                    </li>
                    <li class="tags__item">
                        Lorem ipsum
                    </li>
                    <li class="tags__item">
                        Lorem
                    </li>
                </ul>
            </section>

            <#-- Display the time which this result has last been visited by the user -->
            <@history_cart.LastVisitedLink result=result/>
        </div>
    </article>
</#macro>



