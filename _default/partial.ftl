<#ftl encoding="utf-8" output_format="HTML" />

<#--
    This file is responsible for determining the overall structure
    of the search implementations without the header. Unlike the simple.ftl
    it only provides the search specific elements and does not include things
    like the css or headers and footers. 
    
    - The HTML for the overall structure of the main content.
    - Third party libraries
    - References to javascript templates for sessions and concierge

    The intended purpose of this template is to allow for partial integration
    into an Content Management System (CMS). 
-->

<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/web/templates/modernui/funnelback.ftl" as fb />

<#import "/share/stencils/libraries/base/client_includes.ftl" as client_includes />
<#import "project.ftl" as project />
<#import "base.ftl" as base />
<#import "facets.ftl" as facets />
<#import "results.ftl" as results />
<#import "history_cart.ftl" as history_cart />
<#import "auto-complete.ftl" as auto_complete />
<#import "curator.ftl" as curator />
<#import "extra_search.ftl" as extra_search />

<#--
    Specific result styling imports
	These imports are required for the automatic template selection to work
	The various namespaces (e.g. 'video', 'facebook') need to be on the main scope 
-->
<#import "programs.ftl" as programs />
<#import "courses.ftl" as courses />

<#-- Used to send absolute URLs for resources -->
<#assign httpHost=httpRequest.getHeader('host')>
        
    <div class="fb-container">
        <main class="main" role="main">
            <#-- 
                Display the initial search page which is shown to the user
                when there is no query.
            -->
            <@s.InitialFormOnly>                
                <section class="module-intro content-wrapper">
                    <h1 class="module-intro__title">Explore ${question.getCurrentProfileConfig().get("stencils.I18n.finder_type_primary")?cap_first}s</h1>
                    <p class="module-intro__desc">
                        Use our interactive ${question.getCurrentProfileConfig().get("stencils.I18n.finder_type_primary")?cap_first} Finder to explore what Funnelback has to offer. Filter your search by subject,
                        delivery method and term. Or type a keyword to get started.
                    </p>
                </section>
            </@s.InitialFormOnly>
            
            <#-- Display the search form which accepts the user's query -->
            <section class="module-search js-module-search content-wrapper">
                <h2 class="sr-only">Search module</h2>                    
                <@project.SearchForm />
                <@base.Blending />
                <@base.Spelling />                   
            </section>
            
            <#-- Display the full search page after the user has entered a query -->
            <@s.AfterSearchOnly>

                <#-- The bulk of the search implementation will be found here -->                                    
                <@project.Results />

                <#-- 
                    Display the cart template which describes how the cart should be 
                    presented. 
                -->
                <@history_cart.CartTemplate />

            </@s.AfterSearchOnly>         
        </main><!-- /.main -->
    </div>

    <#-- Concierge includes -->  
    <script type="text/javascript" src="https://${httpHost}/stencils/resources/thirdparty/jquery/v3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="https://${httpHost}/stencils/resources/thirdparty/popper/v1.12.3/umd/popper.min.js"></script>
    <script type="text/javascript" src="https://${httpHost}/stencils/resources/autocompletion/js/typeahead.bundle-0.11.1.min.js"></script>
    <script type="text/javascript" src="https://${httpHost}/s/resources/${question.collection.id}/${question.profile}/js/typeahead.fb-2.6.js"></script>
    <script type="text/javascript" src="${GlobalResourcesPrefix}thirdparty/handlebars-4.0.12/handlebars.min.js"></script>

    <#-- Provides the setDeferredImages and setupFacetLessMoreButtons functions -->
    <#if question.profile?contains("_preview")>
        <#-- Non-minified version provided in preview profiles for debugging -->
        <script src="https://${httpHost}/stencils/resources/base/v15.24/js/base.js"></script>
    <#else>
        <script src="https://${httpHost}/stencils/resources/base/v15.24/js/base.min.js"></script>
    </#if>

    <#-- Radio button changes -->
    <script type="text/javascript">
        jQuery(function () {
            $('.program-finder-display').click(function() {
                var url = $(this).attr('data-url');
                window.location.href = url;
            });
        });
    </script>

    <#-- 
        Include all the auto complete templates which determines 
        how items in concierge are to be displayed.
    -->
    <@programs.AutoCompleteTemplate />

    <script>
        jQuery(function() {
            <@auto_complete.AutoComplete />
        });
    </script>
    
    <#-- Javascript (application) logic shared across all Vertical Product -->
    <script type="text/javascript" src="https://${httpHost}/s/resources/${question.collection.id}/${question.profile}/js/runtime.js"></script>
    <script type="text/javascript" src="https://${httpHost}/s/resources/${question.collection.id}/${question.profile}/js/vendors.js"></script>
    <script type="text/javascript" src="https://${httpHost}/s/resources/${question.collection.id}/${question.profile}/js/main.js"></script>

    <@programs.CartTemplate/>
    <@history_cart.Config />

<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->