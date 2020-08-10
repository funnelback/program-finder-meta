<#ftl encoding="utf-8" output_format="HTML" />
<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/web/templates/modernui/funnelback.ftl" as fb />

<#import "history_cart.ftl" as history_cart />
<#import "/share/stencils/libraries/base/client_includes.ftl" as client_includes />
<#import "project.ftl" as project />

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
        <link href="/s/resources/${question.collection.id}/${question.profile}/css/main.css" rel="stylesheet">
        
        <@client_includes.HTMLHeader />
    </head>
    <body>
        <@client_includes.ContentHeader />
        
        <div class="fb-container">
            <#--  
            <section class="assist content-wrapper">
                <div class="assist__wrapper">
                    <nav aria-label="Breadcrumb" class="breadcrumb">
                        <span class="sr-only">You are here</span>
                        <ol class="breadcrumb__list" itemscope itemtype="http://schema.org/BreadcrumbList">
                            <li class="breadcrumb__item" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                                <a class="breadcrumb__link" href="#" itemscope itemtype="http://schema.org/Thing" itemprop="item">
                                    <span class="sr-only" itemprop="name">Home</span>
                                </a>
                                <meta itemprop="position" content="1" />
                            </li>
                            <li class="breadcrumb__item" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                                <a class="breadcrumb__link" href="#" itemscope itemtype="http://schema.org/Thing" itemprop="item">
                                    <span itemprop="name">Finders</span>
                                </a>
                                <meta itemprop="position" content="2" />
                            </li>
                            <li class="breadcrumb__item">
                                <span>Program Finder</span>
                            </li>
                        </ol>
                    </nav>
    
    
                    <section class="tools">
                       <a href="#" class="tools__print">Print</a>
                    </section>
                </div>
            </section>  
            -->
            <main class="main" role="main">
            
                <@s.InitialFormOnly>
                
                <section class="module-intro content-wrapper">
                    <h1 class="module-intro__title">Explore Programs</h1>
                    <p class="module-intro__desc">
                        Use our interactive Program Finder to explore what Funnelback has to offer. Filter your search by subject,
                        delivery method and term. Or type a keyword to get started.
                    </p>
                </section>
                </@s.InitialFormOnly>
                
                <section class="module-search js-module-search content-wrapper">
                    <h2 class="sr-only">Search module</h2>
                    
                    <@project.SearchForm />
                    
                </section>
                
                <@s.AfterSearchOnly>
                
                <@project.Facets/>
        
                <#-- SEARCH RESULTS -->
                <section class="search-results js-search-results">
                
                    
                    <div class="content-wrapper">
                    
                        <div class="search-results__tools">
                            <h2 class="search-results__tools-title">Search results <#if question.query??> for "<@s.QueryClean/>"</#if></h2>
                            
                            <@project.FacetBreadBox/>

                            <div class="search-results__tools-right">
                                <#if response.facetExtras.hasSelectedNonTabFacets>
                                <a href="${response.facetExtras.unselectAllFacetsUrl!}"
                                class="search-results__tools-link highlight">Clear all filters</a>
                                </#if>
                                <a href="#"
                                class="search-results__icon search-results__icon--box active"><span class="sr-only">Grid
                                    view</span></a>
                                <a href="#"
                                class="search-results__icon search-results__icon--list"><span class="sr-only">List view</span></a>
                            </div>
                        </div>
                        
                        <#-- so we only show curator once -->
                        <#global haveshownCurator = false >
                        
                        <#if question.customData.stencilsShowPrograms?? && question.customData.stencilsShowPrograms>
                            <@fb.ExtraResults name="programs">
                                <@project.Results />
                            
                                <@project.Pagination/>
                            </@fb.ExtraResults>
                        </#if>
                    </div>
    
                    <#if question.customData.stencilsShowCourses?? && question.customData.stencilsShowCourses>
                        <@fb.ExtraResults name="courses">
                        <div class="content-wrapper">
                            
                            <@project.Results name="Courses"/>

                            <@project.Pagination/>
                        </div>
                        </@fb.ExtraResults>
                    </#if>
                </section>
                <#-- END SEARCH RESULTS -->
                
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

        <@project.AutoCompleteTemplates />
        <script>
            jQuery(document).ready( function() {
                <@project.AutoComplete />
            });
        </script>
        

        <@client_includes.ContentFooter />
        <script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/js/runtime.js"></script>
        <script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/js/vendors.js"></script>
        <script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/js/main.js"></script>
    
    
        <@project.CartTemplate/>
        <@history_cart.Config />
    </body>
</html>
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
