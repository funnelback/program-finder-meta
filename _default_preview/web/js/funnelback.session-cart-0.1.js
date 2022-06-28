/*
 * Funnelback Cart Widget
 * version 0.1.0
 *
 * author: Liliana Nowak
 * Copyright Funnelback, 2019
 *
 * @requires Handlebars http://handlebarsjs.com@4.1.2
 * 
 * @usage 
 * initiation: var myCart = new Funnelback.SessionCart({ collection: 'my-collection-name' });
 * open cart: myCart.show();
 * hide cart: myCart.hide();
 * toggle visibility of cart: myCart.toggle();
 * get all settings of cart: myCart.getOption();
 * clear all cart data: myCart.clear();
 * add new item to cart: myCart.addItem('http://someurl.com');
 * remove item from cart: myCart.deleteItem('http://example.com');
 */
if (!window.Funnelback) window.Funnelback = {}; // create namespace

if (!Handlebars) {
  throw new Error('Handlebars must be included (https://handlebarsjs.com/)');
}
if (!window.Funnelback.Handlebars) {
  window.Funnelback.Handlebars = Handlebars.create();
}


// While best practice is to normally include polyfills as an external dependency,
// for these two functions, its more convenient to include them with this file
// than to force users to manually spent a few seconds adding polyfills as an upgrade
// or integration step. If people want to over ride these, they can just import 
// external polyfills manually _before_ importing this script.
// ======== Polyfills for IE9+. =========
// From https://developer.mozilla.org/en-US/docs/Web/API/Element/closest
if (!Element.prototype.matches) {
  Element.prototype.matches = Element.prototype.msMatchesSelector || 
                              Element.prototype.webkitMatchesSelector;
}

if (!Element.prototype.closest) {
  Element.prototype.closest = function(s) {
    var el = this;

    do {
      if (el.matches(s)) return el;
      el = el.parentElement || el.parentNode;
    } while (el !== null && el.nodeType === 1);
    return null;
  };
}

// From https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/entries#Polyfill
if (!Object.entries) {
  Object.entries = function( obj ){
    var ownProps = Object.keys( obj ),
        i = ownProps.length,
        resArray = new Array(i); // preallocate the Array
    while (i--)
      resArray[i] = [ownProps[i], obj[ownProps[i]]];
    
    return resArray;
  };
}

// ======= End Polyfills ========


window.Funnelback.SessionCart = (function() {
  'use strict'

  var Constructor = function(options) {
    return this.init(options);
  }

  // Default options
  Constructor.defaults = {
    apiBase: '/s/cart.json', // web service URL to get cart data from
    collection: null, // collection name; required parameter
    iconPrefix: 'glyphicon glyphicon-', // CSS class(es) prefix used to display icons
    cart: {
      selector: '#search-cart', // CSS selector to element where content of cart should be displayed
      pageSelector: ['#search-results-content', '#search-history'], // set of CSS selectors to parts of page to hide then when cart is displayed
      icon: 'pushpin', // icon to display for cart header; will be prefixed with `iconPrefix`; if null/undefined, no icon will be displayed
      label: 'Saved', // label to display as cart header
      backIcon: 'arrow-left', // icon to display in cart for link to return to result page; will be prefixed with `iconPrefix`; if null/undefined, no icon will be displayed
      backLabel: 'Back to results', // label to display in cart for link to return to result page
      clearClasses: 'btn btn-xs btn-danger', // CSS classes added to link element displayed in cart to clear all cart data
      clearIcon: 'remove', // icon to display for link element in cart to clear all cart data
      clearLabel: 'Clear', // label to display for link element in cart to clear all cart data
      templateSelector: '#cart-template', // ID of element of Handlebars template to render the cart
      emptyMessage: '<span id="flb-cart-empty-message">No items</span>',
    },
    cartCount: {
      selector: '.flb-cart-count', // CSS selector to element where cart count should be displayed
      icon: 'shopping-cart', // icon to display for cart count; will be prefixed with `iconPrefix`; if null/undefined, no icon will be displayed
      isLabel: false, // [true|false]; if true label will be displayed as text of element else it won't be displayed, but will be used in the title attribute.
      label: 'cart', // label add to attribute `title` of cart count to inform about number of items; if `isLabel: true`, this label will be displayed as element text
      template: '{{>icon-block}} {{>label-block}} {{>badge-block}}'
    },
    item: {
      selector: '#search-results', // CSS selector to list of item; if item should be toggled into cart, item requires to have attribute 'data-fb-result' that has index URL value of item
      templates: {
        default: '<h4><a href="{{indexUrl}}">{{#truncate 70}}{{title}}{{/truncate}}</a></h4><cite class="text-success">{{#cut "https://"}}{{indexUrl}}{{/cut}}</cite><p>{{#truncate 255}}{{summary}}{{/truncate}}</p>',
      },
      class: '' // CSS class to apply to the <li> element which is the outer-most element in each cart item. For example: 'card'
    },
    itemTrigger: {
      // Where item trigger should be displayed within search/cart result
      selector: 'h4', // CSS selector of element where item trigger will be inserted in relative position to it
      position: 'afterbegin', // [beforebegin|afterbegin|beforeend|afterend] relative position to `selector` element where item trigger will be inserted
      /*
        beforebegin: before `selector` element itself
        afterbegin: just inside the `selector` element, before its first child
        beforeend: just inside the `selector` element, after its last child
        afterend: after the `selector` element itself
      */
      // Set display of item trigger to add to / delete from cart
      class: '',
      iconAdd: 'pushpin', // icon to display for trigger to add item to cart; will be prefixed with `iconPrefix`; if null/undefined, no icon will be displayed
      iconDelete: 'remove', // icon to display for trigger to delete item from cart; will be prefixed with `iconPrefix`; if null/undefined, no icon will be displayed
      isLabel: false, // [true|false]; if false `labelAdd`\`labelDelete` will be displayed as `title` attribute of element else will be displayed as text of element
      labelAdd: 'Add to cart', // label to display for trigger to add item to cart
      labelDelete: 'Remove from cart', // label to display for trigger to delete item from cart
      template: '{{>icon-block}} {{>label-block}}',
    },
    cartItemTrigger: {}, // Will default to settings of `itemTrigger` but each key can be optionally customised
    resultItemTrigger: {} // Will default to settings of `itemTrigger` but each key can be optionally customised
  };

  /**
   * Create isolated Handlebars environment
   */
  Constructor.prototype.Handlebars = window.Funnelback.Handlebars;

  /**
   * Initialise cart widget with provided options
   * - initiliase cart views and triggers
   * - fetch cart data
   */
  Constructor.prototype.init = function(options) {
    if (!options.collection) {
      console.error('Missing "collection" parameter');
      return null;
    }

    Constructor.options = Utils.extend(Constructor.defaults, options || {});
    if (!Constructor.options.cart.pageSelector) Constructor.options.cart.pageSelector = [];
    Constructor.options.cartItemTrigger = Utils.extend(Utils.extend({}, Constructor.options.itemTrigger), Constructor.options.cartItemTrigger);
    Constructor.options.resultItemTrigger = Utils.extend(Utils.extend({}, Constructor.options.itemTrigger), Constructor.options.resultItemTrigger);

    CartBox.init(Constructor.options);
    CartCount.init(Constructor.options);
    Item.init(Constructor.options);
    ItemTrigger.init(Constructor.options);
    Items.set(Constructor.options);

    Api.get(Constructor.options).then(function(response) {
      Items.update(Constructor.options, response.data);
      CartCount.set(response.data.length);
      CartBox.toggleClearElement(response.data);
    }).catch(function(error) {
      console.error('Something went wrong and no data was fetched. Try again later..', error);
    });
    return this;
  };

  /**
   * Clear all items from cart
   */
  Constructor.prototype.clear = function() {
    if (confirm('Your selection will be cleared') === true) {
      const options = this.getOption();
      Api.delete(options).then(function(response) {
        Items.clear(options);
        CartCount.set(response.data.length);
        CartBox.toggleClearElement(response.data);
        Constructor.prototype.hide();
      }).catch(function(error) {
        console.error('Something went wrong and cart was not cleared. Try again later..', error);
      });
    }
    return this;
  };

  /**
   * Destroy cart widget, erase options
   */
  Constructor.prototype.destroy = function() {
    Constructor.options = {};
    return null;
  };

  /**
   * Open cart
   */
  Constructor.prototype.show = function() {
    CartBox.element.style.display = 'block';
    CartBox.togglePageElements('none');
    CartBox.isHidden = false;
    return this;
  };

  /**
   * Close cart
   */
  Constructor.prototype.hide = function() {
    CartBox.element.style.display = 'none';
    CartBox.togglePageElements('block');
    CartBox.isHidden = true;
    return this;
  };

  /**
   * Toggle cart
   */
  Constructor.prototype.toggle = function() {
    return CartBox.isHidden ? Constructor.prototype.show() : Constructor.prototype.hide();
  };

  /**
   * Get/set cart settings
   * - no arguments - get all settings
   * - one argument `key` - get value of specific setting for that argument
   */
  Constructor.prototype.getOption = function(key) {
    if (arguments.length === 0) {
      return Constructor.options; // get all options
    }

    if (typeof key === 'string') {
      return Constructor.options[key]; // get value of specific option
    }
  };

  /**
   * Add new item to cart
   * - url of item to be added to cart
   */
  Constructor.prototype.addItem = function(url) {
    const options = this.getOption();
    Api.post(options, {url: url}).then(function(response) {
      Item.update(options, response.data.filter(function(it) { return it.indexUrl === url; })[0], 'del');
      CartCount.set(response.data.length);
      CartBox.toggleClearElement(response.data);
    }).catch(function(error) {
      console.error('Something went wrong and item was not saved in a cart. Try again later..', error);
    });
  };

  /**
   * Remove item from cart
   * - url of item to be removed from cart
   */
  Constructor.prototype.deleteItem = function(url) {
    const options = this.getOption();
    Api.delete(options, {url: url}).then(function(response) {
      Item.update(options, {indexUrl: url}, 'add');
      CartCount.set(response.data.length);
      CartBox.toggleClearElement(response.data);
    }).catch(function(error) {
      console.error('Something went wrong and result was not removed from a cart. Try again later..', error);
    });
  };

  // Handle API request
  const Api = {

    delete: function(options, params) {
      return Api.request('delete', options, params);
    },

    get: function(options, params) {
      return Api.request('get', options, params);
    },

    post: function(options, params) {
      return Api.request('post', options, params);
    },

    request: function(method, options, params) {
      return new Promise(function(resolve, reject) {
        const xhr = new XMLHttpRequest(), url = Api.getUrl(options, params);
        xhr.withCredentials = true;
        // Setup callbacks
        xhr.onload = function() {
          if (this.status !== 200) { // If the request failed
            reject({url: url, error: this});
          } else { // If the request succeeded
            try {
              const data = JSON.parse(this.responseText);
              resolve({url: url, data: data});
            } catch(error) {
              reject({url: url, error: error});
            }
          }
        }

        xhr.onerror = function() {
          reject({url: url, error: xhr});
        }

        xhr.open(method, url, true);
        xhr.setRequestHeader('Accept', 'application/json');
        xhr.setRequestHeader('Content-Type', 'text/plain');
        xhr.send(JSON.stringify(params || {}));
      });
    },

    getParamsString: function(params) {
      const str = [];
      for (var p in params) {
        if (params.hasOwnProperty(p)) str.push(encodeURIComponent(p) + '=' + encodeURIComponent(params[p]));
      }
      return str.join('&');
    },

    getUrl: function(options, params) {
      if (!params) params = {};
      params['collection'] = options.collection;
      return options.apiBase + '?' + Api.getParamsString(params);
    }
  };

  // Hadnler to access and create cart
  const CartBox = {
    element: null, // DOM element displying cart
    clearElement: null, // DOM element displaying button to clear all cart data inside cart
    listElement: null, // DOM element displaying list of cart items inside cart
    pageElements: [], // DOM elements to hide it when cart is displayed. see also hiddenPageElements
    modifiedPageElements: null, // Some page elements might already have been hidden. If we werent responsible for hiding them, dont unhide them.
    isHidden: true, // state of visibility of cart
    emptyMessage: null, // element to show a message when the cart is empty

    init: function(options) {
      CartBox.element = ElementUtil.findOnce(options.cart.selector);
      if (!CartBox.element) console.warn(`No element was found with provided selector "${options.cart.selector}"`);
      CartBox.element.style.display = 'none';
      CartBox.emptyMessage = options.cart.emptyMessage;
      for (var i = 0, len = options.cart.pageSelector.length; i < len; i++) {
        const el = ElementUtil.findOnce(options.cart.pageSelector[i]);
        if (el) CartBox.pageElements.push(el);
      }
      if (!CartBox.pageElements.length) console.warn(`No element was found with provided page selector "${options.cart.pageSelector}"`);
      // Get configuration for icons and labels
      const backIcon = options.cart.backIcon ? options.iconPrefix + options.cart.backIcon : null;
      const headerIcon = options.cart.icon ? options.iconPrefix + options.cart.icon : null;
      const clearIcon = options.cart.clearIcon ? options.iconPrefix + options.cart.clearIcon : null;
      if (!document.querySelector(options.cart.templateSelector)) {
        console.warn(`No element was found with the provided selector "${options.cart.templateSelector}"`)
      }
      // Generate the cart skeleton from the Handlebars template
      const template = HandlebarsUtil.compile(document.querySelector(options.cart.templateSelector).text)
      document.getElementById('search-cart').innerHTML = template({ 
        backIcon: backIcon, headerIcon: headerIcon, clearIcon: clearIcon, 
        backLabel: options.cart.backLabel, label: options.cart.label, clearLabel: options.cart.clearLabel
      })
      // Save references to elements and assign event listeners
      CartBox.clearElement = document.getElementById('flb-cart-box-clear')
      CartBox.clearElement.addEventListener('click', function() { Constructor.prototype.clear(options) })
      document.getElementById('flb-cart-box-back').addEventListener('click', Constructor.prototype.hide)
      CartBox.listElement = document.getElementById('flb-cart-box-list')
    },

    /**
     * Show or hide clear button
     * - list of cart data 
     */
    toggleClearElement: function(data) {
      if (data.length > 0) {
        CartBox.clearElement.style.display = 'inline-block'
      } else {
        CartBox.listElement.innerHTML = CartBox.emptyMessage;
        CartBox.clearElement.style.display = 'none'
      }
    },

    /**
     * Show or hide DOM elements in the page
     * - value of CSS property 'display'
     */
    togglePageElements: function(display) {
      // initialise modifiedPageElements the first time. 
      // Also, if we're ever hiding things; otherwise you get wierd interactions between this and session history.
      if (!CartBox.modifiedPageElements || display === 'none') { CartBox.modifiedPageElements = CartBox.pageElements; }
      const newlyModifiedElements = [];            
      for (var i = 0, len = CartBox.pageElements.length; i < len; i++) {
        const elToConsider = CartBox.pageElements[i];
        // Skip elements we have not toggled in the past.
        if (CartBox.modifiedPageElements.indexOf(elToConsider) !== -1){          
          // Skip elements already in that state.
          if (elToConsider.style.display !== display) {
            elToConsider.style.display = display;
            newlyModifiedElements.push(elToConsider)
          }
        }
      }
      CartBox.modifiedPageElements = newlyModifiedElements;
    }
  };

  // Handler to access and create element displaying cart count on page
  const CartCount = {
    selector: 'flb-cart-count-trigger', // CSS class assigned to cart count element
    element: null, // DOM element displaying cart count
    icon: null, // prefixed with `iconPrefix` icon to display for cart count; if null no icon is displayed
    label: null, // label to display for cart count if label is enabled `isLabel: true`, will always be used in the title text if set.
    partialTitle: ' items', // partial title used to create content of title attribute "<count> items"; if label is set "<count> item in your <label>"
    template: null, // compiled Handlebars template to display cart count

    init: function(options) {
      if (options.cartCount.icon) CartCount.icon = options.iconPrefix + options.cartCount.icon;
      if (options.cartCount.isLabel) CartCount.label = options.cartCount.label;
      if (options.cartCount.label) CartCount.partialTitle += ' in your ' + options.cartCount.label.toLowerCase();
      CartCount.template = HandlebarsUtil.compile(options.cartCount.template);
      CartCount.element = ElementUtil.create(CartCount.selector, ElementUtil.findOnce(options.cartCount.selector), 'button', CartCount.template(CartCount.data(0)), {class: 'btn-link', type: 'button', tabindex: '0', title: CartCount.title(0)});
      ElementUtil.addEvent(CartCount.element, 'click', Constructor.prototype.toggle);
    },

    // Data model for Handlebars template
    data: function(count) {
      return {count: count, icon: CartCount.icon, label: CartCount.label};
    },

    // Update count and title of cart count
    set: function(count) {
      ElementUtil.setContent(CartCount.element, CartCount.template(CartCount.data(count)));
      CartCount.element.setAttribute('title', CartCount.title(count));
      if (count === 0) {
        CartCount.element.closest('button').disabled = true;
      } else {
        CartCount.element.closest('button').disabled = false;
      }
    },

    // Get title attribute content of cart count
    title: function(count) {
      return count + CartCount.partialTitle;
    },
  };

  // Handler to access and update search result/cart item
  const Item = {
    selectorAttr: 'data-fb-result', // name of attribute holding index URL of search result that should be toggled into cart
    listElement: null, // DOM element with list of search results
    templates: null, // compiled Handlebars templates to display single item in cart

    init: function(options) {
      // Compile all available templates
      Item.templates = Object.entries(options.item.templates).reduce(function(templates, [collection, template]) {
        templates[collection] = HandlebarsUtil.compile(template)
        return templates
      }, {});
      Item.listElement = ElementUtil.findOnce(options.item.selector);
      if (!Item.listElement) console.warn('No element was found with provided selector "' + options.item.selector + '"');
    },

    /**
     * Get CSS selector to search result with provided index URL
     * if no `url` is passed get CSS selector to all search results
     * - url of item based on which item is added to cart
     */
    selector: function(url) {
      return url ? '[' + Item.selectorAttr + '="' + url + '"]' : '[' + Item.selectorAttr + ']';
    },

    /**
     * Toggle display of cart trigger for search result and of item in cart
     * - widget options 
     * - item data returned by API
     * - action to be performed on item: 'add' or 'del'
     */
    update: function(options, data, action) {
      // Find cart trigger within search result
      const itemTrigger = ElementUtil.findOnce(Item.selector(data.indexUrl), Item.listElement);
      // Toggle display of cart trigger
      if (itemTrigger) ItemTrigger.update('result', itemTrigger, action);

      if (action === 'add') {
        // Find cart item to be removed from cart display
        const cartItem = ElementUtil.findOnce(Item.selector(data.indexUrl), CartBox.listElement);
        // Remove cart item from cart
        ElementUtil.remove(cartItem);
      } else {
        // Create new item to be displayed in cart
        const attributes = {};
        if (options.item.class) attributes.class = options.item.class;
        attributes[Item.selectorAttr] = data.indexUrl;
        const template = Item.templates[data.collection] ? Item.templates[data.collection] : Item.templates.default;
        const cartItem = ElementUtil.create('flb-cart-box-item', null, 'li', template(data), attributes);
        // Create cart trigger for new item in cart
        ItemTrigger.set('cart', options.cartItemTrigger, cartItem);
        // Set trigger to be delete trigger for new item in cart
        ItemTrigger.update('cart', cartItem);
        // Remove the empty message when an item is added
        const emptyMessage = document.getElementById('flb-cart-empty-message')
        if (emptyMessage) {
          emptyMessage.parentNode.removeChild(emptyMessage)
        }
        // Add new item at the beginning of list of items in cart
        CartBox.listElement.insertAdjacentElement('afterbegin', cartItem);
      }
    }
  };

  const Items = {
    // On clearing cart data, update display of item in cart and cart triggers within search results
    clear: function(options) {
      // Remove items from cart
      CartBox.listElement.innerHTML = CartBox.emptyMessage;
      // Find all search results
      const items = ElementUtil.find(Item.selector(), Item.listElement);
      // Remove items from cart and set cart tirggers within search results to be added
      for (var i = 0, len = items.length; i < len; i++) ItemTrigger.update('result', items[i], 'add');
    },

    // Initialise cart triggers for search results
    set: function(options) {
      // Find all search results
      const items = ElementUtil.find(Item.selector(), Item.listElement);
      // Set cart triggers withing search results to be added
      for (var i = items.length - 1; i >= 0; i--) ItemTrigger.set('result', options.resultItemTrigger, items[i]);
    },

    /**
     * Update display of items in cart and cart triggers within search results based on fetched cart data
     * - widget options 
     * - list of data items from API
     * - action to be performed on data item: 'add' or 'del'
     */
    update: function(options, data, action) {
      for (var i = 0, len = data.length; i < len; i++) Item.update(options, data[i], action);
      if (!data.length) CartBox.listElement.innerHTML = CartBox.emptyMessage;
    }
  }

  // Handler to access and create cart triggers
  const ItemTrigger = {
    selector: 'flb-cart-item-trigger', // CSS class name assigned to each trigger
    addEvent: null, // click event assigned to trigger to add item to cart
    delEvent: null, // click event assigned to trigger to remove item from cart
    cartAddTemplate: null, // compiled Handlebars template of trigger in cart to display add to cart
    cartAddTitle: null, // title used to create content of title attribute of trigger in cart to display for add to cart
    cartDelTemplate: null, // compiled Handlebars template of trigger in cart to display remove from cart
    cartDelTitle: null, // title used to create content of title attribute of trigger in cart to display for remove from cart
    resultAddTemplate: null, // compiled Handlebars template of trigger in result list to display add to cart
    resultAddTitle: null, // title used to create content of title attribute of trigger in result list to display for add to cart
    resultDelTemplate: null, // compiled Handlebars template of trigger in result list to display remove from cart
    resultDelTitle: null, // title used to create content of title attribute of trigger in result list to display for remove from cart

    init: function(options) {
      setTrigger('cart', options.cartItemTrigger); // Set settings for trigger displayed within cart item
      setTrigger('result', options.resultItemTrigger); // Set settings for trigger displayed within result item

      ItemTrigger.addEvent = function(e) { // Define event triggered on adding item to cart
        e.preventDefault();
        const item = e.currentTarget.closest(Item.selector()), url = item.getAttribute(Item.selectorAttr);
        if (url) return Constructor.prototype.addItem(url);
        else console.warn('No URL found to save item in a cart');
      };
      ItemTrigger.delEvent = function(e) { // Define event triggered on deleting item from cart
        e.preventDefault();
        const item = e.currentTarget.closest(Item.selector()), url = item.getAttribute(Item.selectorAttr);
        if (url) return Constructor.prototype.deleteItem(url);
        else console.warn('No URL found to remove result from a cart');
      };

      function setTrigger(type, trigger) {
        const template = HandlebarsUtil.compile(trigger.template);
        ItemTrigger[type + 'AddTemplate'] = template({icon: options.iconPrefix + trigger.iconAdd, label: trigger.isLabel ? trigger.labelAdd: null});
        ItemTrigger[type + 'DelTemplate'] = template({icon: options.iconPrefix + trigger.iconDelete, label: trigger.isLabel ? trigger.labelDelete : null});
        ItemTrigger[type + 'AddTitle'] = trigger.labelAdd;
        ItemTrigger[type + 'DelTitle'] = trigger.labelDelete;
      }
    },

    /**
     * Create cart trigger for provided cart item or search result
     * - type of trigger: 'cart' or 'result'
     * - trigger settings
     * - DOM element to which trigger should be added
     */
    set: function(type, trigger, item) {
      const el = ElementUtil.findOnce(trigger.selector, item);
      const triggerEl = ElementUtil.create(ItemTrigger.selector, null, 'button', ItemTrigger[type + 'AddTemplate'], {class: trigger.class, title: ItemTrigger[type + 'AddTitle'], type: 'button', tabindex: '0'});
      ElementUtil.addEvent(triggerEl, 'click', ItemTrigger.addEvent);
      if (el) el.insertAdjacentElement(trigger.position, triggerEl);
      else console.info('No element was found with provided selector "' + trigger.selector + '"');
    },

    /**
     * Toggle display of cart trigger
     * - type of trigger: 'cart' or 'result'
     * - DOM element to which trigger is assigned
     * - action to be performed on trigger: 'add' or 'del'
     */
    update: function(type, item, action) {
      const el = ElementUtil.findOnce('.' + ItemTrigger.selector, item);
      if (action === 'add') {
        ElementUtil.setContent(el, ItemTrigger[type + 'AddTemplate']);
        ElementUtil.removeEvent(el, 'click', ItemTrigger.delEvent);
        ElementUtil.addEvent(el, 'click', ItemTrigger.addEvent);
        el.setAttribute('title', ItemTrigger[type + 'AddTitle']);
      } else {
        ElementUtil.setContent(el, ItemTrigger[type + 'DelTemplate']);
        ElementUtil.removeEvent(el, 'click', ItemTrigger.addEvent);
        ElementUtil.addEvent(el, 'click', ItemTrigger.delEvent);
        el.setAttribute('title', ItemTrigger[type + 'DelTitle']);
      }
    }

  };

  const Templates = {
    // List of partial templates registered with Handlebars
    // Usage ie. {{>icon-block}}, {{>badge-block}}
    partial: {
      badge: '<span class="badge">{{count}}</span>',
      icon: '{{#if icon}}<span class="{{icon}} {{classes}} flb-cart-icon"></span>{{/if}}',
      label: '{{#if label}}{{label}}{{/if}}',
    },
    once: {
      iconLabel: '{{>icon-block}} {{>label-block}}',
    }
  };

  /** Helpers */

  // Helpers to work with DOM elements
  const ElementUtil = {
    // Create DOM element
    create: function(id, context, tag, content, attrs) {
      const el = document.createElement(tag ? tag : 'div');
      if (content) ElementUtil.setContent(el, content);
      if (!attrs) attrs = {};
      if (attrs['class']) attrs['class'] += ' ' + id;
      else attrs['class'] = id;
      ElementUtil.setAttr(el, attrs);
      if (context) context.appendChild(el);
      return el;
    },

    // Remove DOM element
    remove: function(element) {
      // If api calls are called directly, maybe the result does not appear on the screen to remove.
      if (!element) { console.warn("Remove called on element which could not be found"); return; }
      element.parentNode.removeChild(element);
    },

    // Find all DOM elements with provided CSS selector
    find: function(selector, context) {
      if (!context) context = document;
      return context.querySelectorAll(selector);
    },

    // Find first DOM element with provided CSS selector
    findOnce: function(selector, context) {
      return ElementUtil.find(selector, context)[0];
    },

    // Set attribute of DOM element
    setAttr: function(element, attrs) {
      const attrsArr = Object.entries(attrs);
      for (var i = 0, len = attrsArr.length; i < len; i++) element.setAttribute(attrsArr[i][0], attrsArr[i][1]);
    },

    // Set content of DOM element
    setContent: function(element, content) {
      element.innerHTML = content;
    },

    // Assign event to DOM element
    addEvent: function(element, type, handler) {
      element.addEventListener(type, handler);
    },
    
    // Remove event from DOM element
    removeEvent: function(element, type, handler) {
      element.removeEventListener(type, handler);
    },
  };

  // Misc
  const Utils = {
    // Deep extend of one object with properites of other object
    extend: function(obj, src) {
      for (var key in src) {
        if (src.hasOwnProperty(key)) obj[key] = typeof src[key] === 'object' ? Utils.extend(obj[key] || {}, src[key]) : src[key];
      }
      return obj;
    }
  };

  // Handlebars
  const HandlebarsUtil = {
    // Compile Handlebars template
    compile: function(template) {
      return Constructor.prototype.Handlebars.compile(template);
    },

    // Register with Handlebars partial templates
    registerPartial: function(templates) {
      const templatesArr = Object.entries(templates);
      for (var i = 0, len = templatesArr.length; i < len; i++) Constructor.prototype.Handlebars.registerPartial(templatesArr[i][0] + '-block', templatesArr[i][1]);
    },
  };

  HandlebarsUtil.registerPartial(Templates.partial);

  return Constructor;
}());
