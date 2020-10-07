<#ftl encoding="utf-8" output_format="HTML" />
<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/web/templates/modernui/funnelback.ftl" as fb />

<#import "history_cart.ftl" as history_cart />
<#import "/share/stencils/libraries/base/client_includes.ftl" as client_includes />

<#-- These imports are required for the automatic template selection to work
  The various namespaces (e.g. 'video', 'facebook') need to be on the main scope -->
<#import "project.ftl" as project />
<#import "courses.ftl" as courses />
<#import "people.ftl" as people />
<#import "video.ftl" as video />
<#import "facebook.ftl" as facebook />
<#import "events.ftl" as events />

<#-- Used to send absolute URLs for resources -->
<#assign httpHost=httpRequest.getHeader('host')>

<main class="funnelback">
  <h1 class="sr-only">Search</h1>

    <@project.SearchForm />

    <@s.AfterSearchOnly>
      <@project.Tabs />
      <@project.Results />
    </@s.AfterSearchOnly>
    <@history_cart.SearchHistory />
    <@history_cart.Cart />

  <#-- The following common scripts are commented in case they are already loaded in the CMS template  -->
  <#-- It is recommended to load these from a CDN rather than the Funnelback server if possible -->
  <#--
  <script defer src="https://${httpHost}/stencils/resources/thirdparty/jquery/v3.2.1/jquery-3.2.1.min.js"></script>
  <script defer src="https://${httpHost}/stencils/resources/thirdparty/popper/v1.12.3/umd/popper.min.js"></script>
  <script defer src="https://${httpHost}/stencils/resources/thirdparty/bootstrap/v4.0.0/js/bootstrap.min.js"></script>
  -->

  <#-- Provides the setDeferredImages and setupFacetLessMoreButtons functions -->
  <#if question.profile?contains("_preview")>
    <#-- Non-minified version provided in preview profiles for debugging -->
    <script src="https://${httpHost}/stencils/resources/base/v15.24/js/base.js"></script>
  <#else>
    <script src="https://${httpHost}/stencils/resources/base/v15.24/js/base.min.js"></script>
  </#if>

  <script>
    document.addEventListener("DOMContentLoaded", function() {
      setupDeferredImages();
      setupFacetLessMoreButtons(${question.getCurrentProfileConfig().get("stencils.faceted_navigation.max_displayed_categories")!"undefined"}, '.search-facet');

      <@project.AutoComplete />
    });
  </script>

  <#-- Recommended to load third-party libraries from a CDN if possible -->
  <script defer src="https://${httpHost}/stencils/resources/autocompletion/js/typeahead.bundle-0.11.1.min.js"></script>
  <script defer src="https://${httpHost}/stencils/resources/autocompletion/js/handlebars.min-v4.0.5.js"></script>

  <#-- Funnelback plugin to Typeahead for autocomplete -->
  <script defer src="https://${httpHost}/s/resources/${question.collection.id}/${question.profile}/js/typeahead.fb-2.6.js"></script>

  <@courses.AutoCompleteTemplate />
  <@people.AutoCompleteTemplate />

  <#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
    <@history_cart.CartTemplate />
    <@courses.CartTemplate />

    <#-- Promise polyfill for Internet Explorer -->
    <script nomodule src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>

    <#-- Non-minified version provided in preview profiles for debugging -->
    <#if question.profile?contains("_preview")>
      <#-- Non-minified version provided in preview profiles for debugging -->
      <script defer src="https://${httpHost}/s/resources/${question.collection.id}/${question.profile}/js/funnelback.session-cart-0.1.js"></script>
      <script defer src="https://${httpHost}/s/resources/${question.collection.id}/${question.profile}/js/funnelback.session-history-0.1.js"></script>
    <#else>
      <script defer src="https://${httpHost}/s/resources/${question.collection.id}/${question.profile}/js/funnelback.session-cart-0.1.min.js"></script>
      <script defer src="https://${httpHost}/s/resources/${question.collection.id}/${question.profile}/js/funnelback.session-history-0.1.min.js"></script>
    </#if>
    <@history_cart.Configuration />
  </#if>

</main>

<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
