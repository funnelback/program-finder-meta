<#ftl encoding="utf-8" output_format="HTML" />

<#macro Config>
 <#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
    <script type="text/javascript" src="${GlobalResourcesPrefix}thirdparty/es6-promise-4.2.5/es6-promise.auto.min.js"></script>
    <script type="text/javascript" src="${GlobalResourcesPrefix}js/funnelback.session-cart-0.1.js"></script>
    <script type="text/javascript" src="${GlobalResourcesPrefix}js/funnelback.session-history-0.1.min.js"></script>

  <script type="text/javascript">
    window.addEventListener('DOMContentLoaded', function() {

      new Funnelback.SessionCart({
        collection: '${question.collection.id}',
        iconPrefix: '',
        cartCount: {
          template: '{{>icon-block}} {{>label-block}} ({{count}})',
          icon: 'fas fa-star',
          label: 'Shortlist',
          isLabel: true
        },
        cart: {
          icon: 'fas fa-star',
          label: ' Shortlist ',
          backIcon: 'fas fa-arrow-left',
          backLabel: 'Back to results',
          clearIcon: 'fas fa-times',
          clearClasses: "btn btn-xs btn-light",                    
          emptyMessage: '<span id="flb-cart-empty-message">No items in your shortlist</span>',
          pageSelector: ['#search-results-content', '#search-history', '#fb-session__side-navigation']
        },
        item: {
          icon: 'fas fa-star',          
          template: document.getElementById('cart-template-membership-association-events-web').text
        },
        resultItemTrigger: {
          selector: '.enable-cart-on-result',
          labelAdd: '',
          iconAdd: 'far fa-star',
          labelDelete: '',
          iconDelete: 'fas fa-star',
          isLabel: false,
          template: '<span class="text-info float-right">{{>icon-block}} {{>label-block}}</span>',
          position: 'afterbegin'
        },
        cartItemTrigger: {
          selector: ".fb-cart__remove",
          iconDelete: "fas",
          template: '{{>icon-block}} {{>label-block}}',
          position: 'afterbegin',
          isLabel: true,
          labelDelete: "REMOVE FROM SHORTLIST"
        }        
      });
      
      /*new Funnelback.SessionHistory({
        collection: '${question.collection.id}',
        currentSearchHistorySelectors: ['.session-history-search-results'],
        currentClickHistorySelectors: ['.session-history-click-results'],
        pageSelector: ['#search-results-content', '#search-cart','#fb-session__side-navigation']
      });*/
    });
  </script>

  </#if>
</#macro>