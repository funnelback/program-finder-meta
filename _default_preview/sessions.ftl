<#ftl encoding="utf-8" output_format="HTML" />

<#import "sessions.click_history.ftl" as click_history />
<#import "sessions.query_history.ftl" as query_history />
<#import "sessions.shortlist.ftl" as shortlist />


<#--
	Display a "Last visited X time ago" link for a result

	@param result Result to display the link for
-->
<#macro LastVisitedLink result>
	<#if question.collection.configuration.valueAsBoolean("ui.modern.session") && session?? && session.getClickHistory(result.indexUrl)??>
		<p class="search-last-visited session-history-link"> 
			<small>
				<span class="far fa-clock"></span>
				Last visited ${prettyTime(session.getClickHistory(result.indexUrl).clickDate)}
			</small>
		</p>
	</#if>
</#macro>

<#macro SearchHistoryAndShortlist>
    <section class="content-wrapper search-history" id="search-history">
        <button href="#" class="search-history__hide session-history-hide" type="button">
            <svg class="svg-icon svg-icon--small">
                <use href="#arrow"></use>
            </svg>
            Back to results
        </button>
        <h2 class="search-history__title">Search History</h2>
        <div class="search-history__items">
            <@click_history.ClickHistory />
            <@query_history.QueryHistory />
        </div>
    </section>

    <@shortlist.Shortlist />
</#macro>

<#macro Configuration>
	<!-- history_cart.Configurations -->
	<#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
	  	<#local host=httpRequest.getHeader('host')>

		<script type="text/javascript">
			window.addEventListener('DOMContentLoaded', function() {	
				new Funnelback.SessionCart({
        			apiBase: '${question.getCurrentProfileConfig().get("stencils.sessions.cart.api_base")!"https://${host}/s/cart.json"}',
					collection: '${question.collection.id}',
					iconPrefix: '',
					cartCount: {
						template: '{{>icon-block}} {{>label-block}} ({{count}})',
						icon: 'fas fa-star',
						label: 'Shortlist',
						isLabel: true
					},
					cart: {
						icon: '',
						label: 'Shortlist',
						backIcon: 'fas fa-arrow-left',
						backLabel: 'Back to results',
						clearIcon: 'fas fa-times',
						clearClasses: "btn btn-xs btn-light",                    
						emptyMessage: '<span id="flb-cart-empty-message">No items in your shortlist</span>',
					    pageSelector: ['#funnelbach-search-body', '#funnelbach-search-facets', '#search-history'], // list of CSS selectors to parts of page to hide it when history is displayed
					},
					item: {
						icon: 'fas fa-star',          
						templates: {
							<@shortlist.ShortlistTemplatesConfig />
						},
						class: ''
					},
					resultItemTrigger: {
						selector: '.enable-cart-on-result',
                        class: 'testing',
						labelAdd: 'ADD TO SHORTLIST',
						iconAdd: 'far fa-star',
						labelDelete: 'REMOVE FROM SHORTLIST',
						iconDelete: 'fas fa-star',
						isLabel: true,
						<#-- 
							Labels are required as they are used as the title of the add/remove buttons
							which is needed for WCAG 2.1. 
						-->
						template: '{{>icon-block}} {{>label-block}}',
						position: 'afterbegin'
					},
					/* Trigger to delete an item from the cart */
					cartItemTrigger: {
						selector: ".fb-cart__remove",
						iconDelete: "fas",
						template: '{{>icon-block}}{{>label-block}}',
						position: 'afterbegin',
						isLabel: true,
						labelDelete: "REMOVE FROM SHORTLIST"
					}        
				});

				new Funnelback.SessionHistory({
					searchApiBase: '${question.getCurrentProfileConfig().get("stencils.sessions.history.search.api_base")!"https://${host}/s/search-history.json"}',
					clickApiBase: '${question.getCurrentProfileConfig().get("stencils.sessions.history.click.api_base")!"https://${host}/s/click-history.json"}',
					collection: '${question.collection.id}',
                    
                    // Selectors to DOM elements displaying content; each CSS selector should return not more than one element
                    historySelector: '#search-history', // CSS selector to element where content of history should be displayed
                    clickEmptySelector: '.session-history-click-empty', // CSS selector to element displaying message about no click history data
                    clickResultsSelector: '.session-history-click-results', // CSS selector to element displaying click history data
                    searchEmptySelector: '.session-history-search-empty', // CSS selector to element displaying message about no search history data
                    searchResultsSelector: '.session-history-search-results', // CSS selector to element displaying search history data
					pageSelector: ['#funnelbach-search-body', '#funnelbach-search-facets', '#search-cart'], // list of CSS selectors to parts of page to hide it when history is displayed

                    // Selectors to DOM elements triggering events; each CSS selector can return zero or more elements    
                    clearClickSelector: '.session-history-clear-click', // CSS selector to element on clicking which click history data will be cleared
                    clearSearchSelector: '.session-history-clear-search', // CSS selector to element on clicking which search history data will be cleared
                    hideSelector: '.session-history-hide', // CSS selector to element on clicking which history box will be hidden
                    showSelector: '.session-history-show', // CSS selector to element on clicking which history box will be shown
                    currentSearchHistorySelectors: ['.session-history-breadcrumb'], // list of CSS selectors to elements which should be hidden when the search history data is cleared.
                    currentClickHistorySelectors: ['.session-history-link'], // list of CSS selectors to elements which should be hidden when the click history data is cleared.
                    
                    toggleSelector: '.session-history-toggle', // CSS selector to element on clicking which history box will be toggled

				});
			});
		</script>
	</#if>
</#macro>

<#-- 
	Displays the controls used to toggle the cart and history and 
	query history functionality.
-->
<#macro Controls>
	<#if question.collection.configuration.valueAsBoolean("ui.modern.session")>		
		<!-- sessions::Controls -->
		<div class="result-sessions__controls">
			<span class="flb-cart-count"></span>
				<a class="session-history-toggle" tabindex="0">
				<span class="fas fa-history"></span>
				History
			</a>
		</div>
	</#if>    
</#macro>

<#macro Templates>
    <#-- Specifies how each cart item should be presented -->
    <@shortlist.ShortlistTemplate />

    <#-- 
        Automatically include the cart template for all document types defined
        across available namespaces. i.e. You won't need to explicitly 
        do calls like <@courses.CartTemplate> to include the Handlebars templates 
        as this macro will automatically be include it for you.   
    -->
    <@shortlist.ShortlistTemplatesForResults />    
</#macro>
