<#ftl encoding="utf-8" output_format="HTML" />

<#macro Config>
 <#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
 <script type="text/javascript">
 var cartJS = {
    config: {
        apiUrl: 'https://stage-stencil-search.clients.funnelback.com/s/cart.json',
        collectionName: 'program-finder-meta',
        loadOnInit: true,
        itemTemplate: document.getElementById('cart-template-program-finder').innerHTML,
        itemTemplateMap: {  // map between template and FB results
            url: 'indexUrl',
            id: 'metaData.stencilsProgramID',
            credential: 'metaData.stencilsProgramCredentialName',
            desc: 'metaData.c',
            name: 'title'
        }
    },
    selectors: {
        pinboardWrapper: '.js-module-compare',
        pinboard: '.module-compare__wrapper',
        pinboardList: '.module-compare__list',
        pinboardView: '.module-compare__compare',
        pinboardCounter: '.module-compare__number',
        pinboardToggle: '.js-pinboard-toggle',
        pinBtn: '.compare-button',
        clearBtn: '.module-compare__clear',
        removeBtn: '.module-compare__remove',
        searchResults: '.js-search-results',
    },
    activePinClass: 'active',
    activePinboardClass: 'pinboard--active',
    searchResultsClass: 'hide',
    hiddenAsideClass: 'hide-aside',

    cart: [],

    // Core function: do not modify
    init: function () {
        'use strict';
        var self = this;

        if (!document.querySelector(self.selectors.pinboard)) {
            return false;
        }

        // bind events
        self.bind();

        // check cart on init
        if (self.config.loadOnInit) {
            self.getItems();
        }

        return true;
    },

    // Core function: do not modify
    bind: function () {
        'use strict';
        var self = this;

        // bind toggler
        var pinboard = document.querySelector(self.selectors.pinboard);
        var pinboardToggler = pinboard.querySelector(self.selectors.pinboardToggle);
        if (pinboardToggler) {
            pinboardToggler.addEventListener("click", function (e) {
                e.preventDefault();
                pinboard.classList.toggle(self.activePinboardClass);
            });
        }

        // bind view pinboard
        var pinboardView = document.querySelector(self.selectors.pinboardView);
        var searchResults = document.querySelector(self.selectors.searchResults);
        var pinboardWrapper = document.querySelector(self.selectors.pinboardWrapper);

        if (pinboardView && searchResults) {
            pinboardView.addEventListener("click", function (e) {
                e.preventDefault();
                // hide serach results
                searchResults.classList.toggle(self.searchResultsClass);
                // hide aside and set full width
                pinboardWrapper.classList.toggle(self.hiddenAsideClass);
                if (!pinboard.classList.contains(self.activePinboardClass)) {
                    // open pinboard if closed
                    pinboard.classList.add(self.activePinboardClass);
                }
            });
        }
        // Bind clear button
        var clearButton = document.querySelector(self.selectors.clearBtn);
        clearButton.addEventListener("click", function (e) {
                e.preventDefault();

                self.deleteAllItems();
            });
        

        // bind pin click
        var buttons = document.querySelectorAll(self.selectors.pinBtn)
        self.bindButtons(buttons);
    },

    // Core function: do not modify
    bindButtons: function (buttons) {
        'use strict';
        var self = this;

        if (buttons.length) {
            for (var i = 0; i < buttons.length; i++) {
                // bind each button
                buttons[i].addEventListener("click", function (e) {
                    e.preventDefault();
                    var href = e.target.dataset.url;
                    if (href && href.length) {
                        // toggle btn
                        this.classList.toggle(self.activePinClass);
                        var active = false;
                        for (var j = 0; j < this.classList.length; j++) {
                            if (this.classList[j].match(self.activePinClass)) {
                                active = true;
                            }
                        }
                        if (active) {
                            // add item
                            self.addItem(href);
                           
                        } else {
                            // remove item
                            self.deleteItem(href);
                        }
                    }
                });
            }
        }
    },

    // Core function: do not modify
    reloadCart: function () {
        'use strict';
        var self = this;

        // Reloads the cart items themselves (HTML, etc)
        self.reloadCartList();
        // Binds any and all remove buttons inside the cart
        self.reloadCartRemoveButtons();
        // Update the counter view
        self.reloadCartCounter();
        // Update the clear button (should it show?)
        self.reloadClearButton();
        // Update all checkboxes on the current result page
        self.reloadCheckboxes();
    },
    
    reloadCartRemoveButtons: function () {
        'use strict';
        var self = this;
        var buttons = document.querySelectorAll(self.selectors.removeBtn);
        if (buttons.length) {
            for (var i = 0; i < buttons.length; i++) {
                buttons[i].addEventListener("click", function (e) {
                    e.preventDefault();
                    var href = e.target.dataset.url;
                    if (href && href.length) {
                        self.deleteItem(href);
                    }
                });
            }
        }
    },
    
    reloadCheckboxes: function () {
        'use strict';
        var self = this;
        var buttons = document.querySelectorAll(self.selectors.pinBtn);
        if (buttons.length) {
            for (var i = 0; i < buttons.length; i++) {
                var href = buttons[i].dataset.url;
                var checkbox = document.getElementById(buttons[i].htmlFor);
                var outcome = false;
                for (var j = 0; j < self.cart.length; j++) {
                    if ( self.cart[j].indexUrl == href ) {
                        outcome = true;
                    }
                }
                checkbox.checked = outcome;
            }
        }
    },
    
    reloadClearButton: function () {
        'use strict';
        var self = this;
        var clearButton = document.querySelector(self.selectors.clearBtn);
        var toggleButton = document.querySelector(self.selectors.pinboardView);
        if ( self.cart.length != 0 ) {
            if ( clearButton.classList.contains('hidden') ) {
                clearButton.classList.remove('hidden');
            }
            if ( toggleButton.classList.contains('hidden') ) {
                toggleButton.classList.remove('hidden');
            }
        } else {
            if ( !clearButton.classList.contains('hidden') ) {
                clearButton.classList.add('hidden');
            }
            if ( !toggleButton.classList.contains('hidden') ) {
                toggleButton.classList.add('hidden');
            }
        }
    },

    reloadCartList: function () {
        'use strict';
        var self = this;

        var HTML = '';
        for (var i = 0; i < self.cart.length; i++) {
            HTML += self.setItemHTML(self.cart[i]);
        }

        var pinboardList = document.querySelector(self.selectors.pinboardList)
        // set html
        pinboardList.innerHTML = HTML;

        // bind buttons on list
        var buttons = pinboardList.querySelectorAll(self.selectors.pinBtn);
        self.bindButtons(buttons);
    },

    reloadCartCounter: function () {
        'use strict';
        var self = this;

        // reload cart counter
        document.querySelector(self.selectors.pinboardCounter).textContent = self.cart.length;
    },

    setItemHTML: function (item) {
        'use strict';
        var self = this;

        var value, itemHTML = self.config.itemTemplate;

        // replace values from template
        for (var key in self.config.itemTemplateMap) {
            // simple map
            // value = item[self.config.itemTemplateMap[key]];
            // "object" nap
            var value = '';
            var valueKeys = self.config.itemTemplateMap[key].split('.');
            if (valueKeys.length) {
                value = item[valueKeys[0]];
                if (valueKeys.length > 1) {
                    var tmp = value;
                    for (var i = 1; i < valueKeys.length; i++) {
                        tmp = tmp[valueKeys[i]];
                    }
                    value = tmp;
                }
            }
            var regExp = new RegExp('\\{\\{' + key + '\\}\\}', 'gi');
            itemHTML = itemHTML.replace(regExp, value || '');
        }
        var ifElseRegexGlobal = new RegExp('\\{\\{#if (.*?)\\}\\}(.*?)\\{\\{else\\}\\}(.*?)\\{\\{\\/if\\}\\}', 'imsg');
        var ifElseRegex = new RegExp('\\{\\{#if (.*?)\\}\\}(.*?)\\{\\{else\\}\\}(.*?)\\{\\{\\/if\\}\\}', 'ims');
        var results = itemHTML.matchAll(ifElseRegexGlobal);
        for(var j = 0; j < results.length; j++) {
            let result = results[j];
            let cond = result[1];
            let tbranch = result[2];
            let fbranch = result[3];

            if ( cond in self.config.itemTemplateMap ) {
                itemHTML = itemHTML.replace(ifElseRegex, tbranch);  
            } else {
                itemHTML = itemHTML.replace(ifElseRegex, fbranch); 
            }
        }
        
        var ifRegexGlobal = new RegExp('\\{\\{#if (.*?)\\}\\}(.*?)\\{\\{\\/if\\}\\}', 'imsg');
        var ifRegex = new RegExp('\\{\\{#if (.*?)\\}\\}(.*?)\\{\\{\\/if\\}\\}', 'ims');
        results = itemHTML.matchAll(ifRegexGlobal);
        for(var k = 0; k < results.length; k++) {
            let result = results[k];
            let cond = result[1];
            let tbranch = result[2];
            if ( cond in self.config.itemTemplateMap ) {
                itemHTML = itemHTML.replace(ifRegex, tbranch);  
            } 
        }
        return itemHTML;
    },

    getItems: function () {
        'use strict';
        var self = this;

        self.requestToApi('', 'GET');
    },

    addItem: function (url) {
        'use strict';
        var self = this;

        self.requestToApi(url, 'POST');
    },

    deleteItem: function (url) {
        'use strict';
        var self = this;

        self.requestToApi(url, 'DELETE');
        self.removeItemFromResults(url);
    },
    
    deleteAllItems: function() {
        'use strict';
        var self = this;
        self.requestToApi('', 'DELETE');
        self.cart = [];  
    },

    removeItemFromResults: function (url) {
        'use strict';
        var self = this;

        var seearchResults = document.querySelector(self.selectors.searchResults);
        var pins = seearchResults.querySelectorAll(self.selectors.pinBtn);
        // search results pins
        if (pins.length) {
            for (var i = 0; i < pins.length; i++) {
                var href = pins[i].dataset.url;
                if (href && href == url) {
                    pins[i].classList.remove('active');
                }
            }
        }
    },

    requestToApi: function (url, method) {
        'use strict';
        var self = this;

        if (typeof self.config.apiUrl != 'string') {
            return false;
        }

        if (typeof self.config.collectionName != 'string') {
            return false;
        }

        var requestUrl = self.config.apiUrl + '?collection=' + self.config.collectionName
        
        if ( url != '' ) {
            requestUrl += '&url=' + url;
        }

        var xmlHttp = new XMLHttpRequest();
        xmlHttp.open(method || "GET", requestUrl);
        xmlHttp.onload = function (e) {
            if (this.status == 200) {
                var data;
                try {
                    data = JSON.parse(xmlHttp.responseText);
                } catch (e) {
                    data = [];
                }
                self.cart = data;
                self.reloadCart();
            }
        };
        xmlHttp.send(null);
    }
};

(function () {
    cartJS.init();
})();

 </script>
 </#if>
</#macro>

<#-- This is the new vanilla code -->
<#macro VanillaConfig>
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
          template: '{{>label-block}} ({{count}})',
          icon: '',
          label: 'Compare',
          isLabel: true
        },
        cart: {
          icon: '',
          label: 'Compare ',
          backIcon: '',
          backLabel: 'Close',
          clearIcon: '',
          clearClasses: "btn btn-xs btn-light",                    
          emptyMessage: '<span id="flb-cart-empty-message">No items in your shortlist</span>',
          pageSelector: ['#search-results-content', '#search-history', '#fb-session__side-navigation']
        },
        item: {
          icon: '',          
          template: document.getElementById('cart-template-program-finder').text
        },
        resultItemTrigger: {
          selector: '.search-results__compare',
          labelAdd: 'Compare Program',
          iconAdd: '',
          labelDelete: '',
          iconDelete: '',
          isLabel: true,
          template: ' {{>label-block}}',
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