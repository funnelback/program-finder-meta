<#ftl encoding="utf-8" output_format="HTML" />

<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/web/templates/modernui/funnelback.ftl" as fb />

<#import "/share/stencils/libraries/base/client_includes.ftl" as client_includes />
<#import "history_cart.ftl" as history_cart />
<#import "project.ftl" as project />
<#import "base.ftl" as base />
<#import "facets.ftl" as facets />
<#import "results.ftl" as results />
<#import "auto-complete.ftl" as auto_complete />
<#import "curator.ftl" as curator />


<#-- Specific result styling imports
	These imports are required for the automatic template selection to work
	The various namespaces (e.g. 'video', 'facebook') need to be on the main scope 
-->
<#import "programs.ftl" as programs />
<#import "courses.ftl" as courses />

<!DOCTYPE html>
<html lang="en"> 
    <head>
        <!-- htmlcs-disable -->
        <!-- Metadata -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="referrer" content="always">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        
        <!-- Imports -->
        <link href="https://unpkg.com/normalize.css@8.0.1/normalize.css" rel="stylesheet">
         <script src="/stencils/resources/thirdparty/jquery/v3.2.1/jquery-3.2.1.min.js"></script>
          
        <title><@s.AfterSearchOnly>${question.query!}<@s.IfDefCGI name="query">,&nbsp;</@s.IfDefCGI></@s.AfterSearchOnly><@s.cfg>service_name</@s.cfg></title>
        
        <#-- Presentation logic shared across all Vertical Product -->
        <link href="/s/resources/${question.collection.id}/${question.profile}/css/main.css" rel="stylesheet">
        
        <#-- Output the implementation specific CSS -->
        <@client_includes.HTMLHeader />
    </head>
    <body>

        <#-- Output the clients global navigation -->
        <@client_includes.ContentHeader />
        
        <div class="fb-container">
            <main class="main" role="main">

                <#-- Display the initial -->
                <@s.InitialFormOnly>
                
                <section class="module-intro content-wrapper">
                    <h1 class="module-intro__title">Explore ${question.collection.configuration.value("stencils.I18n.finder_type_primary", "Course")}s</h1>
                    <p class="module-intro__desc">
                        Use our interactive ${question.collection.configuration.value("stencils.I18n.finder_type_primary", "Course")} Finder to explore what Funnelback has to offer. Filter your search by subject,
                        delivery method and term. Or type a keyword to get started.
                    </p>
                </section>
                </@s.InitialFormOnly>
                
                <section class="module-search js-module-search content-wrapper">
                    <h2 class="sr-only">Search module</h2>
                    
                    <@project.SearchForm />
                    
                </section>
                
                <@s.AfterSearchOnly>
                
                <#-- Display the facets for the program finder -->
                <@project.Facets />
        
                <#-- SEARCH RESULTS -->
                <section class="search-results js-search-results">
                    <div class="content-wrapper">
                        <div class="search-results__tools">
                            <h2 class="search-results__tools-title">Search results <#if question.query??> for "<@s.QueryClean/>"</#if></h2>
                            
                            <#-- Display the facets which have been selected by the user -->
                            <@facets.FacetBreadBox/>

                            <div class="search-results__tools-right">
                                <#if (response.facetExtras.hasSelectedNonTabFacets)!>
                                    <a href="${response.facetExtras.unselectAllFacetsUrl!}"
                                    class="search-results__tools-link highlight">Clear all filters</a>
                                </#if>
                                <a href="#"
                                    class="search-results__icon search-results__icon--box active">
                                    <span class="sr-only">
                                        Grid view
                                    </span>
                                </a>
                                <a href="#"
                                    class="search-results__icon search-results__icon--list">
                                    <span class="sr-only">
                                        List view
                                    </span>
                                </a>
                            </div>
                        </div>
                        
                        <#-- 
                            Curator - We only want to display curator if there are any to avoid
                            excessive padding/margins.
                        -->
                        <@curator.HasCurator position="center">
                            <div class="fb-curator">
                                <article class="search-results__list--list-view">
                                    <@curator.Curator "center" />
                                </article>
                            </div>
                        </@curator.HasCurator>

                        <#-- 
                            Best Bets - We only want to display best bets if there are any to avoid
                            excessive padding/margins. 
                        -->
                        <@curator.HasBestBets>
                            <div class="fb-curator">
                                <article class="search-results__list--list-view">
                                    <@curator.BestBets />
                                </article>
                            </div>
                        </@curator.HasBestBets>

                    </div>
                    
                    
                    <#-- Programs -->
                    <#if question.customData.stencilsShowPrograms?? && question.customData.stencilsShowPrograms>
                        <@fb.ExtraResults name="programs">
                            <div class="content-wrapper">
                                <@project.ResultList name=question.collection.configuration.value("stencils.I18n.finder_type_primary", "Course")?cap_first + "s" />
                            
                                <@base.Paging/>
                            </div>
                        </@fb.ExtraResults>
                    </#if>

                    <#-- Courses -->
                    <#if question.customData.stencilsShowCourses?? && question.customData.stencilsShowCourses>
                        <@fb.ExtraResults name="courses">
                            <div class="content-wrapper">

                                <@project.ResultList name=question.collection.configuration.value("stencils.I18n.finder_type_secondary", "Course")?cap_first + "s" />

                                <@base.Paging/>
                            </div>
                        </@fb.ExtraResults>
                    </#if>
                </section>
                <#-- END SEARCH RESULTS -->
                

                <#-- Curator - Bottom -->
                <@curator.HasCurator position="center">
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

                <#-- testing custom code -->
                <section class="module-compare js-module-compare">
                    <h2 class="sr-only">Compare elements</h2>
                    <div class="module-compare__bar content-wrapper">
                        <a href="#" class="module-compare__close">Close</a>
                        <a href="#" class="module-compare__clear hidden">Clear</a>
                         
                    </div>
                    <div class="module-compare__wrapper content-wrapper">
                        <table class="module-compare__list">
                            <tbody>
                                <tr>
                                    <th scope="row"></th>
                                    <#-- actual compare items go here -->
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </section>
               
                </@s.AfterSearchOnly>
            </main><!-- /.main -->
        </div>
  
        <#-- Concierge includes -->  
        <script src="/stencils/resources/thirdparty/jquery/v3.2.1/jquery-3.2.1.min.js"></script>
        <script src="/stencils/resources/thirdparty/popper/v1.12.3/umd/popper.min.js"></script>
        <script src="/stencils/resources/thirdparty/bootstrap/v4.0.0/js/bootstrap.min.js"></script>
        
        <#-- Radio button changes -->
        <script type="text/javascript">
            $(document).ready(function () {
                $('.program-finder-display').click(function() {
                    var url = $(this).attr('data-url');
                    window.location.href = url;
                });
            });
        </script>

        <script src="/stencils/resources/autocompletion/js/typeahead.bundle-0.11.1.min.js"></script>
        <script type="text/javascript" src="${GlobalResourcesPrefix}thirdparty/handlebars-4.0.12/handlebars.min.js"></script>
        <script src="/s/resources/${question.collection.id}/${question.profile}/js/typeahead.fb-2.6.js"></script>
        

        <#-- 
            Include all the auto complete templates which determines 
            how items in concierge are to be displayed.
        -->
        <@programs.AutoCompleteTemplate />

        <script>
            jQuery(document).ready( function() {
                <@auto_complete.AutoComplete />
            });
        </script>
        

        <@client_includes.ContentFooter />

        <#-- Javascript (application) logic shared across all Vertical Product -->
        <script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/js/runtime.js"></script>
        <script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/js/vendors.js"></script>
        <script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/js/main.js"></script>
    
        <@project.CartTemplate/>
        <@history_cart.Config />
    </body>
</html>
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
