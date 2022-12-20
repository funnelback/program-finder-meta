<#ftl encoding="utf-8" output_format="HTML" />

<#import "sessions.search_history.ftl" as search_history />
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
	<@search_history.Drawer />
    <@shortlist.Drawer />
</#macro>

<#--  	
	This output the configurations required to setup the shortlist
	which comes shipped with Funnelback.
-->
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
						isLabel: true,
						classes: "",
						enableClick: false,
						elementType: "span",
						tabIndex: "-1",
					},
					cart: {
						icon: '',
						label: '',
						backIcon: 'fas fa-arrow-left',
						backLabel: 'Back to results',
						clearIcon: 'fas fa-times',
						clearClasses: "btn btn-xs btn-light",                    
						emptyMessage: '<span id="flb-cart-empty-message">No items in your shortlist</span>',
					},
					item: {
						icon: 'fas fa-star',          
						templates: {
							<@shortlist.TemplatesConfig />
						},
						class: ''
					},
					resultItemTrigger: {
						selector: '.enable-cart-on-result',
                        class: '',
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
			});
		</script>
	</#if>
</#macro>

<#-- 
	Displays the controls used to toggle the shortlist and search history 
	functionality.
-->
<#macro Controls>
	<#if question.collection.configuration.valueAsBoolean("ui.modern.session")>		
		<!-- sessions::Controls -->
		<div class="result-sessions__controls">
			<#--  Shortlist  -->
			<button
				type="button"
				aria-controls="funnelback-search-shortlist-drawer"
				data-component="activate-drawer"
			>
				<@sessions.ShortlistControl />  
			</button>

			<#--  Search History  -->
			<button 
				class="session-history-toggle" 
				aria-controls="funnelback-search-history-drawer"
				data-component="activate-drawer"
				tabindex="0"
			>
				<span class="fas fa-history"></span>
				History
			</button>
		</div>
	</#if>    
</#macro>

<#-- Outputs the placeholder used to determine where the shortlist button should rendern -->
<#macro ShortlistControl>
	<!-- sessions::ShortlistControl -->
	<@shortlist.Control />
</#macro>

<#macro Templates>
    <#-- Specifies how each cart item should be presented -->
    <@shortlist.Template />

    <#-- 
        Automatically include the cart template for all document types defined
        across available namespaces. i.e. You won't need to explicitly 
        do calls like <@courses.CartTemplate> to include the Handlebars templates 
        as this macro will automatically be include it for you.   
    -->
    <@shortlist.TemplatesForResults />    
</#macro>

<#macro ShortlistDrawer>
	<@shortlist.Drawer />
</#macro>