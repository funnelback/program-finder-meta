<#ftl encoding="utf-8" output_format="HTML" />

<#macro Config>
    <#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
        <#local host=httpRequest.getHeader('host')>
        <!-- history_cart.Config -->
        <script type="text/javascript">

        /* 
            Handlesbars is required for the compare functionality. This is
            is usually loaded by Funnelback auto-complete library or the 
            product's cart library. However, to be defensive we are adding a 
            check and loading a version of it. 
        */
        if (!window.Funnelback) window.Funnelback = {}; // create namespace

        if (!Handlebars) {
            throw new Error('Handlebars must be included (https://handlebarsjs.com/)');
        }

        if (!window.Funnelback.Handlebars) {
        window.Funnelback.Handlebars = Handlebars.create();
        }

        var cartJS = {
            config: {
                apiUrl: '//${host}/s/cart.json',
                collectionName: '${(question.collection.id)!}',
                loadOnInit: true,
                itemTemplates: {
                    <@CartTemplatesConfig />
                }
            },
            selectors: {
                pinboardWrapper: '.js-module-compare',
                pinboard: '.module-compare__wrapper',
                pinboardList: '.module-compare__list',
                pinboardView: '.btn__compare',
                pinboardCounter: '.btn__compare-total',
                pinboardToggle: '.js-pinboard-toggle',
                pinBtn: '.compare-button',
                clearBtn: '.module-compare__clear',
                removeBtn: '.module-compare__remove',
                searchResults: '.search-results',
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

                // Pre-compile the handlebars templates  
                self.itemTemplates = Object.entries(self.config.itemTemplates).reduce(
                    function(templates, [collection, template]) {
                        templates[collection] = window.Funnelback.Handlebars.compile(template);
                        return templates;
                }, {});

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
                        document.querySelector(".module-compare__close").click();
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

            setItemHTML: function (data) {
                'use strict';
                var self = this;

                // Grab the template
                const template = self.itemTemplates[data.collection] ? self.itemTemplates[data.collection] : self.itemTemplates.default;

                // Generate the HTML by parsing the template with the data
                return template(data);
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
                
                // Allow requests from cross domains to set and use cookies
                xmlHttp.withCredentials = true;                
                
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
    <!-- history_cart.VanillaConfig -->
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

<#--
	Display a "Last visited X time ago" link for a result

	@param result Result to display the link for
-->
<#macro LastVisitedLink result>
	<#if question.collection.configuration.valueAsBoolean("ui.modern.session") && session?? && session.getClickHistory(result.indexUrl)??>
		<!-- history_cart.LastVisitedLink -->
        <p class="search-last-visited session-history-link"> 
			<small>
				<span class="far fa-clock"></span>
				Last visited ${prettyTime(session.getClickHistory(result.indexUrl).clickDate)}
			</small>
		</p>
	</#if>
</#macro>

<#macro CartTemplate>
    <!-- history_card.CartTemplate -->
    <section class="module-compare js-module-compare">
        <h2 class="sr-only">Compare elements</h2>
        <div class="module-compare__bar content-wrapper">
            <a href="#" class="module-compare__close">Close</a>
            <a href="#" class="module-compare__clear hidden">Clear</a>
            
        </div>
        <div class="module-compare__wrapper content-wrapper">
            <table class="module-compare__list">
                <tbody>
                    <tr>
                        <th scope="row"></th>
                        <#-- actual compare items go here -->
                    </tr>
                </tbody>
            </table>
        </div>
    </section>
</#macro>

<#-- Output the config required to configure the cart templates -->
<#macro CartTemplatesConfig >
	<#-- 
		Output the default template which is used when no cart template 
		is explicitly defined.
	-->
	'default': document.getElementById('cart-template-default').text
	<#if (question.getCurrentProfileConfig().getRawKeys())!?has_content>		
		,
		<#-- 
			Output the custom cart templates config based on the 
			user's configurations 
		-->
		<#list question.getCurrentProfileConfig().getRawKeys()?filter(key -> key?lower_case?starts_with("stencils.template.shortlist.")) as key>
			<#local collection = key?keep_after_last(".")>
			<#local templateName = question.getCurrentProfileConfig().get(key)>
			'${collection}': document.getElementById('cart-template-${templateName}').text
			<#if key_has_next>,</#if>
		</#list> 
	</#if>
</#macro>

<#-- 
	Attempts to find and output all cart templates across all available
	namespaces. It is assummed that cart templates are macros defined with 
	the name <#macro CartTemplate> </#macro>.
-->
<#macro CartTemplatesForResults>
	<!-- history_cart.CartTemplatesForResults -->
	<#list .main as key, namespace >
		<#if (namespace)!?is_hash && (namespace.CartTemplate)!?is_directive && key != "history_cart">
			<@namespace.CartTemplate />
		</#if>
	</#list>
</#macro>