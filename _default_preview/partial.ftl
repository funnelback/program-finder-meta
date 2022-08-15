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

<#-- Core Funnelback imports -->
<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/web/templates/modernui/funnelback.ftl" as fb />

<#-- 
    Global Stencils imports
    The namespace will be available in all templates which are imported 
-->
<#import "project.ftl" as project />
<#import "base.ftl" as base />
<#import "curator.ftl" as curator />
<#import "tabs.ftl" as tabs />
<#import "facets.ftl" as facets />
<#import "browse_mode.ftl" as browse_mode />
<#import "contextual_navigation.ftl" as contextual_navigation />
<#import "history_cart.ftl" as history_cart />
<#import "auto_complete.ftl" as auto_complete />
<#import "curator.ftl" as curator />
<#import "extra_search.ftl" as extra_search />
<#import "results.ftl" as results />

<#import "/share/stencils/libraries/base/client_includes.ftl" as client_includes />

<#-- Specific result styling imports
    These imports are required for the automatic template selection to work
    The various namespaces (e.g. 'video', 'facebook') need to be on the main scope 
-->
<#import "project.ftl" as project />
<#import "courses.ftl" as courses />
<#import "people.ftl" as people />
<#import "video.ftl" as video />
<#import "facebook.ftl" as facebook />
<#import "events.ftl" as events />
<#import "twitter.ftl" as twitter />

<#-- Used to send absolute URLs for resources -->
<#assign httpHost=httpRequest.getHeader('host')>

<div class="fb-container">
    <main class="main <@s.InitialFormOnly>initial-search-form</@s.InitialFormOnly>" role="main">
        <@project.SearchForm />
        <@s.AfterSearchOnly>
            <@project.Tabs />
            <#-- 
                Would normally merge the span with the section element but due to the way 
                sessions hide/show functionalty works, we need to separate this into it own element. 
            -->
            <span id="search-facets-and-results" >
                <section class="content-wrapper content-wrapper--col search-facets-and-results">
                    <@project.SideNavigation />
                    <@project.Results />
                </section>
            </span>
        </@s.AfterSearchOnly>
        <section class="content-wrapper search-sessions">
            <@history_cart.SearchHistory />
            <@history_cart.Cart />
        </section>
    </main>
</div>    

<#-- 
    Third party libraries 
 
    TODO: Review the following libraries and see if they need they are already
    included by the CMS. If they are, simply comment out the relevant library.
-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>	
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha512-hJSZLjaUow3GsiAkjUBMxN4eaFysMaBvg7j6mkBeo219ZGmSe1eVhKaJJAj5GzGoD0j0Gr2/xNDzjeecdg+OCw==" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/typeahead.js/0.11.1/typeahead.bundle.min.js" integrity="sha512-qOBWNAMfkz+vXXgbh0Wz7qYSLZp6c14R0bZeVX2TdQxWpuKr6yHjBIM69fcF8Ve4GUX6B6AKRQJqiiAmwvmUmQ==" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>

<#-- 
    Libraries required by the design developed by the Stencils cutup team. 
    Avoid changing these if possible.
-->
<#-- The vendor.js file includes all the code from external libraries -->
<script type="text/javascript" src="https://${httpHost!}/s/resources/${question.collection.id}/${question.profile}/js/vendors.js"></script>
<#-- 
    Webpacks "runtime" code. Contains everything required to connect the
    modularized application while it’s running in the browser. It contains 
    the loading and resolving logic needed to connect your modules as they 
    interact.
-->
<script type="text/javascript" src="https://${httpHost!}/s/resources/${question.collection.id}/${question.profile}/js/runtime.js"></script>
<#-- Stencil specific code such as the quickview and dropdowns -->
<script type="text/javascript" src="https://${httpHost!}/s/resources/${question.collection.id}/${question.profile}/js/main.js"></script>

<#-- Stencils specific code -->
<script src="https://${httpHost!}/s/resources/${question.collection.id}/${question.profile}/js/stencils.js"></script>
<script src="https://${httpHost!}/s/resources/${question.collection.id}/${question.profile}/js/handlebars-helpers.js"></script>  

<#-- Funnelback auto-complete -->
<script src="https://${httpHost!}/s/resources/${question.collection.id}/${question.profile}/js/funnelback.autocompletion-2.6.0.stencils.js"></script>

<#-- Output the auto complete templates for concierge -->
<#-- 
    TODO - Ensure that the relevant templates are included for auto-complete.
-->
<@courses.AutoCompleteTemplate />
<@people.AutoCompleteTemplate />
    
<script>
    jQuery(document).ready( function() {
        setupDeferredImages();
        setupFacetLessMoreButtons(${question.collection.configuration.value("stencils.faceted_navigation.max_displayed_categories", "8")}, '.fb-sidebar__nav');
        <@auto_complete.Configuration />
    });
</script>

<#-- 
    Enable session functonality which includes cart and click 
    and query history 
-->
<#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
    <#-- 
        Automatically includ the cart template for all document types defined
        across available namespaces. i.e. You won't need to explicitly 
        do calls like <@courses.CartTemplate> to include the Handlebars templates 
        as this macro will automatically be include it for you.   
    -->
    <@history_cart.CartTemplatesForResults />
    
    <#-- Specifies how each cart item should be presented -->
    <@history_cart.CartTemplate />
    <#-- Specifies the presentation of a cart item if a custom one is not specified -->
    <@history_cart.CartItemTemplate />

    <script nomodule src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
    
    <#-- We have replaced the products session code with an extended version for Stencils -->
    <#if question.profile?contains("_preview")>
        <#-- 
            Use the non-minified version for the preview so that 
            it is easier to step through and investigate bugs 
        -->
        <script defer src="https://${httpHost!}/s/resources/${question.collection.id}/${question.profile}/js/funnelback.session-cart-0.1.js"></script>
        <script defer src="https://${httpHost!}/s/resources/${question.collection.id}/${question.profile}/js/funnelback.session-history-0.1.js"></script>
    <#else>
        <script type="module" defer src="https://${httpHost!}/s/resources/${question.collection.id}/${question.profile}/js/funnelback.session-cart-0.1.module.min.js"></script>
        <script nomodule defer src="https://${httpHost!}/s/resources/${question.collection.id}/${question.profile}/js/funnelback.session-cart-0.1.legacy.min.js"></script>
        <script defer src="https://${httpHost!}/s/resources/${question.collection.id}/${question.profile}/js/funnelback.session-history-0.1.min.js"></script>
    </#if>
    <@history_cart.Configuration />
</#if>

