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

<#-- Core Funnelback imports -->
<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/web/templates/modernui/funnelback.ftl" as fb />

<#-- 
	Global Stencils imports
	The namespace will be available in all templates which are imported 
-->
<#import "base.ftl" as base />
<#import "hero_banner.ftl" as hero_banner />
<#import "search_tools.ftl" as search_tools />
<#import "counts.ftl" as counts />
<#import "query_blending.ftl" as query_blending />
<#import "spelling_suggestions.ftl" as spelling_suggestions />
<#import "curator.ftl" as curator />
<#import "tabs.ftl" as tabs />
<#import "facets.breadcrumbs.ftl" as facets_breadcrumbs />
<#import "facets.ftl" as facets />
<#import "tier_bars.ftl" as tier_bars />
<#import "pagination.ftl" as pagination />
<#import "browse_mode.ftl" as browse_mode />
<#import "contextual_navigation.ftl" as contextual_navigation />
<#import "auto_complete.ftl" as auto_complete />
<#import "auto_complete.concierge.ftl" as concierge />
<#import "curator.ftl" as curator />
<#import "result_list.ftl" as result_list />
<#import "no_results.ftl" as no_results />
<#import "extra_search.ftl" as extra_search />
<#import "results.ftl" as results />
<#import "client_includes.ftl" as client_includes />

<#import "sessions.ftl" as sessions />


<#-- Specific result styling imports
	These imports are required for the automatic template selection to work
	The various namespaces (e.g. 'video', 'facebook') need to be on the main scope 
-->
<#import "results.courses.ftl" as courses />
<#import "results.programs.ftl" as programs />
<#import "results.people.ftl" as people />
<#import "results.video.ftl" as video />
<#import "results.facebook.ftl" as facebook />
<#import "results.events.ftl" as events />
<#import "results.twitter.ftl" as twitter />
<#import "results.instagram.ftl" as instagram />

<!DOCTYPE html>
<html lang="en" class="stencils">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="robots" content="nofollow,noindex">

	<@client_includes.HTMLHeader />
	
	<#if (question.query)!?has_content>
		<title>${question.query!},&nbsp;<@s.cfg>service_name</@s.cfg></title>
	<#else>
		<title><@s.cfg>service_name</@s.cfg></title>
	</#if> 

</head>
<body class="sb-show-main sb-main-padded vsc-initialized">
	<#-- Import the icons so that they are available using the <use> directive. -->
	<div style="display:none">
		<#include "utilities.icons.ftl" />
	</div>

	<a href="#search-results" class="sr-only" title="Skip to search results">
		Skip to search results asdsa
	</a>
	
	<#--  <@client_includes.ContentHeader />  -->

	<div class="stencils__main program-finder">
				
		<@hero_banner.SearchForm />
		<#--  <@tabs.Tabs />  -->

		<div class="navbar">
			<button
				type="button"
				aria-controls="funnelback-search-shortlist-drawer"
				data-component="activate-drawer"
				class="navbar__item"
			>
				<@sessions.ShortlistControl />  
			</button>

			<@sessions.SearchHistoryControls />

			<button
				type="button"
				aria-controls="funnelback-search-facets-drawer"
				data-component="activate-drawer"
				class="funnelback-search__filters-button navbar__item"
			>
				<svg class="svg-icon navbar__icon" role="img">
					<title>Toggle show all filters</title>
					<use href="#funnel"></use>
				</svg>
				<span class="navbar__label">Filters</span>				
			</button>			
		</div>

		<div class="funnelback-search no-wysiwyg">			
			<div class="funnelback-search__body" id="funnelbach-search-body">
				<h2 class="funnelback-search__title">Results</h2>
				
				<@search_tools.SearchTools />
				
				<@query_blending.QueryBlending />
				<@spelling_suggestions.SpellingSuggestions />
				<@facets_breadcrumbs.Breadcrumb />

				<@s.AfterSearchOnly>						
					<@curator.HasCuratorOrBestBet position="top">
						<@curator.Curator position="top" />
					</@curator.HasCuratorOrBestBet>

					<#-- 
						Hide the organic/normal results on the all tab as we only 
						want to display the extra searches.  
					-->
					<@facets.IsNotSelected facetName="Tabs" categoryLabel="All">
						<@no_results.NoResults />
						<@result_list.ResultList />
						<@pagination.Pagination />
					</@facets.IsNotSelected>

					<#-- Programs extra search -->
					<@extra_search.Preview  extraSearchName="programs" documentType=question.getCurrentProfileConfig().get("stencils.I18n.finder_type_primary") + "s">
						<@no_results.NoResults />
						<@result_list.ResultList />
					</@extra_search.Preview>
					
					<#-- Courses extra search -->
					<@extra_search.Preview  extraSearchName="courses" documentType=question.getCurrentProfileConfig().get("stencils.I18n.finder_type_secondary") + "s">
						<@no_results.NoResults />
						<@result_list.ResultList />
					</@extra_search.Preview>

					<@curator.HasCuratorOrBestBet position="bottom">
						<@curator.Curator position="bottom" />
					</@curator.HasCuratorOrBestBet>

				</@s.AfterSearchOnly>

				<@contextual_navigation.ContextualNavigation />
			</div>

			<#--  <div class="funnelback-search__side" id="funnelbach-search-facets">					  -->
				<#-- Get facets for the current selected tab -->
				<#--  <#assign tabFacets = question.getCurrentProfileConfig().get("stencils.tabs.facets.${(response.customData.stencils.tabs.selected)!}")!>

				<@facets.HasFacets facets=tabFacets>
					<@facets.Facets 
						facets=tabFacets 
						maxCategories=question.getCurrentProfileConfig().get("stencils.faceted_navigation.max_displayed_categories")!
					/>
				</@facets.HasFacets>

				<@curator.HasCuratorOrBestBet position="left">
					<@curator.Curator position="left" />
				</@curator.HasCuratorOrBestBet>

			</div>  -->
			
				
		</div>				
	</div>

	<div class="facet-drawer">
		<div
			data-component="drawer"
			data-drawer-width="25"
			data-drawer-height="100"
			data-drawer-transition-speed="0.5"
			class="drawer drawer--open-right"
			id="funnelback-search-facets-drawer"
		>
			<div
				class="drawer__content"
				role="alertdialog"
				aria-labelledby="drawer-title-1"
			>
				<div class="drawer__controllers">
					<h2 id="drawer-title-1">Filters</h2>
					<button
						type="button"
						aria-expanded="true"
						class="drawer__close"
					>
						<svg
							class="svg-icon svg-icon--xlarge"
							role="img"
						>
							<title>Close</title>
							<use href="#close" />
						</svg>
					</button>
				</div>
				<div class="drawer__body">
					<#-- Get facets for the current selected tab -->
					<#assign tabFacets = question.getCurrentProfileConfig().get("stencils.tabs.facets.${(response.customData.stencils.tabs.selected)!}")!>

					<@facets.HasFacets facets=tabFacets>
						<@facets.Facets 
							facets=tabFacets 
							maxCategories=question.getCurrentProfileConfig().get("stencils.faceted_navigation.max_displayed_categories")!
						/>
					</@facets.HasFacets>						
				</div>
			</div>
		</div>
	</div>

	<div class="shortlist-drawer">
		<div
			data-component="drawer"
			data-drawer-width="100"
			data-drawer-height="100"
			data-drawer-transition-speed="0.3"
			class="drawer drawer--open-bottom"
			id="funnelback-search-shortlist-drawer"
		>
			<div
				class="drawer__content"
				role="alertdialog"
				aria-labelledby="shortlist-drawer-title"
			>
				<div class="drawer__controllers">
					<h2 id="shortlist-drawer-title">Shortlist</h2>
					<button
						type="button"
						aria-expanded="true"
						class="drawer__close"
					>
						<svg
							class="svg-icon svg-icon--xlarge"
							role="img"
						>
							<title>Close</title>
							<use href="#close" />
						</svg>
					</button>
				</div>
				<div class="drawer__body">
					<@sessions.Shortlist />
				</div>
			</div>
		</div>
	</div>				

	<@sessions.SearchHistory />


	<#-- Third parties -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha512-hJSZLjaUow3GsiAkjUBMxN4eaFysMaBvg7j6mkBeo219ZGmSe1eVhKaJJAj5GzGoD0j0Gr2/xNDzjeecdg+OCw==" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/typeahead.js/0.11.1/typeahead.bundle.min.js" integrity="sha512-qOBWNAMfkz+vXXgbh0Wz7qYSLZp6c14R0bZeVX2TdQxWpuKr6yHjBIM69fcF8Ve4GUX6B6AKRQJqiiAmwvmUmQ==" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>

	<#-- 
		Libraries required by the design developed by the Stencils cutup team. 
		Avoid changing these if possible.
	-->
	<#-- Stencil specific code such as the quickview and dropdowns -->
	<script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/themes/stencils/js/main.js"></script>

	
	<#-- Stencils specific code -->
	<script src="/s/resources/${question.collection.id}/${question.profile}/js/stencils.js"></script> 
	<script src="/s/resources/${question.collection.id}/${question.profile}/js/handlebars-helpers.js"></script> 
				
	<script>
		window.addEventListener('DOMContentLoaded', function() {			
			setupDeferredImages();
			
			// Make the history button accessible via the keyboard for WCAG 2.1
			var historyElement = document.querySelectorAll('.session-history-toggle');

			// Add a href which does not reference any valid anchor so that 
			// hitting enter while the element is in focus will activate
			// the onclick event
			historyElement.forEach((element) => {
				element.setAttribute("href", "#fb-history-placeholder");
			});
		});
	</script>

	<#-- 
		Enable session functonality which includes cart and click 
		and query history 
	-->
	<#if question.collection.configuration.valueAsBoolean("ui.modern.session")>		
		<@sessions.Templates />					
		
		
		<script nomodule src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
		
		<#-- We have replaced the products session code with an extended version for Stencils -->
		<#if question.profile?contains("_preview")>
			<#-- 
				Use the non-minified version for the preview so that 
				it is easier to step through and investigate bugs 
			-->
			<script defer src="/s/resources/${question.collection.id}/${question.profile}/js/funnelback.session-cart-0.2.js"></script>
			<script defer src="/s/resources/${question.collection.id}/${question.profile}/js/funnelback.session-history-0.1.js"></script>
		<#else>
			<script type="module" defer src="/s/resources/${question.collection.id}/${question.profile}/js/funnelback.session-cart-0.1.module.min.js"></script>
      		<script nomodule defer src="/s/resources/${question.collection.id}/${question.profile}/js/funnelback.session-cart-0.1.legacy.min.js"></script>
			<script defer src="/s/resources/${question.collection.id}/${question.profile}/js/funnelback.session-history-0.1.min.js"></script>
		</#if>
		<@sessions.Configuration />
	</#if>
</body>
</html>
