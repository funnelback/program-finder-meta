<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
    Presentation and configuration logic for the query and click history.
-->

<#--  Output the sliding drawer for the shortlist.  -->
<#macro Drawer>
	<#--  sessions.search_history::sessions.Drawer -->
	<div class="search-history-drawer" tabindex="-1">
		<div
			data-component="drawer"
			data-drawer-width="100"
			data-drawer-height="100"
			data-drawer-transition-speed="0.3"
			class="drawer drawer--open-bottom"
			id="funnelback-search-history-drawer"
		>
			<div
				class="drawer__content"
				role="alertdialog"
				aria-labelledby="search-history-drawer-title"
			>
				<div class="drawer__controllers">
					<h2 id="search-history-drawer-title">Search History</h2>
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
					<#--  Search history placeholder -->
					<div
						data-component="search-history"
						data-search-history-configuration="{}"
					> </div>

					<@Configuration />
				</div>
			</div>
		</div>
	</div>	
</#macro>

<#macro Configuration>
    <#--  sessions.search_history::sessions.Configuration -->
    <span
        class="visuallyhidden"
        data-pnp-component="link-tracker"
        data-search-form=".autocomplete-concierge__form-wrapper"
        data-link-query=".listing-item__title-link,.quickview__action"
        data-search-term="${question.originalQuery!}"
        data-results-count="${response.resultPacket.resultsSummary.totalMatching!}"
        data-history-size="20"
        data-delay="500"
    ></span>
</#macro>