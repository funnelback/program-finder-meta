<#ftl encoding="utf-8" output_format="HTML" />

<#--
    This file is responsible for determining the overall structure
    of the search implementations. It contains things such as:

    - The HTML for the overall structure such as the header, footer 
        and main content.
    - The references to the client's header and footer
    - Third party libraries
    - References to javascript templates for sessions and concierge
-->

<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/web/templates/modernui/funnelback.ftl" as fb />

<#import "/share/stencils/libraries/base/client_includes.ftl" as client_includes />
<#import "project.ftl" as project />
<#import "base.ftl" as base />
<#import "facets.ftl" as facets />
<#import "results.ftl" as results />
<#import "history_cart.ftl" as history_cart />
<#import "auto_complete.ftl" as auto_complete />
<#import "curator.ftl" as curator />
<#import "extra_search.ftl" as extra_search />

<#--
    Specific result styling imports
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
        
        <title><@s.AfterSearchOnly>${question.query!}<@s.IfDefCGI name="query">,&nbsp;</@s.IfDefCGI></@s.AfterSearchOnly><@s.cfg>service_name</@s.cfg></title>
        
        <#-- Presentation logic shared across all Vertical Product -->
        <link href="https://unpkg.com/normalize.css@8.0.1/normalize.css" rel="stylesheet">
        <link href="/s/resources/${question.collection.id}/${question.profile}/css/main.css" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.10.0/css/all.css">
        
        <#-- Output the implementation specific CSS -->
        <@client_includes.HTMLHeader />
    </head>
    <body>

        <#-- Output the clients global navigation -->
        <@client_includes.ContentHeader />
        
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
  
        <#-- Third parties -->
        <#--  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>	  -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.2/jquery.min.js" integrity="sha512-Znnj7n0C0Xz1tdk6ih39WPm3kSCTZEKnX/7WaNbySW7GFbwSjO5r9/uOAGLMbgv6llI1GdghC7xdaQsFUStM1w==" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha512-hJSZLjaUow3GsiAkjUBMxN4eaFysMaBvg7j6mkBeo219ZGmSe1eVhKaJJAj5GzGoD0j0Gr2/xNDzjeecdg+OCw==" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/typeahead.js/0.11.1/typeahead.bundle.min.js" integrity="sha512-qOBWNAMfkz+vXXgbh0Wz7qYSLZp6c14R0bZeVX2TdQxWpuKr6yHjBIM69fcF8Ve4GUX6B6AKRQJqiiAmwvmUmQ==" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>

        <#-- Stencils specific code -->
        <script src="/s/resources/${question.collection.id}/${question.profile}/js/stencils.js"></script> 
        <script src="/s/resources/${question.collection.id}/${question.profile}/js/handlebars-helpers.js"></script> 

        <!-- Funnelback auto-complete -->
        <script src="/s/resources/${question.collection.id}/${question.profile}/js/funnelback.autocompletion-2.6.0.stencils.js"></script>

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
                <@auto_complete.Configuration />
            });
        </script>
        

        <@client_includes.ContentFooter />

        <#-- 
            Libraries required by the design developed by the Stencils cutup team. 
            Avoid changing these if possible.
        -->
        <#-- The vendor.js file includes all the code from external libraries -->
        <script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/js/vendors.js"></script>
        <#-- 
            Webpacks "runtime" code. Contains everything required to connect the
            modularized application while it’s running in the browser. It contains 
            the loading and resolving logic needed to connect your modules as they 
            interact.
        -->
        <script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/js/runtime.js"></script>
        <#-- Stencil specific code such as the quickview and dropdowns -->
        <script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/js/main.js"></script>

        <@programs.CartTemplate/>
        <@history_cart.Config />
    </body>
</html>
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
