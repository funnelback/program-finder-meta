<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
  This template outputs only the HTML component of the Higher Education Vertical Product 
  (excluding the header and footer). This is required in the scenario where the target CMS 
  want to be responsible for displaying the header and footer and serve up all the css
  and javascript. 

  e.g. Squiz Matrix Neo Templates: https://marketplace-dev.squiz.systems/hugo/fb-search-esi 
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

<#-- Output the auto complete templates for concierge -->
<#-- 
    TODO - Ensure that the relevant templates are included for auto-complete.
-->
<@courses.AutoCompleteTemplate />
<@people.AutoCompleteTemplate />

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
</#if>
 
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
