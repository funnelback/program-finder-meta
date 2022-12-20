<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
    Presentation and logic for display the navigation bar.
-->

<#macro Navbar>
    <#--  navbar::Navbar  -->
    <div class="navbar">
        <button
            type="button"
            aria-controls="funnelback-search-shortlist-drawer"
            data-component="activate-drawer"
            class="navbar__item"
        >
            <@sessions.ShortlistControl />  
        </button>

		<#--  Search History  -->
		<button 
			class="session-history-toggle navbar__item" 
			aria-controls="funnelback-search-history-drawer"
			data-component="activate-drawer"
		>
			<span class="fas fa-history"></span>
			History
		</button>

        <@tabs.TabsAsRadio facets="Tabs" />
        
        <i class="navbar__seperator fa-solid fa-grip-lines-vertical"  role="presentation"></i>

        <#--  Filter button which provides access to all the facets configured for the implementation -->
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

	<div class="facet-drawer" tabindex="-1" style="visibility: hidden;">
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
							class="svg-icon drawer__icon"
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
</#macro>


