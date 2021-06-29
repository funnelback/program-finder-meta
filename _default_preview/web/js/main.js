/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 2);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports) {

module.exports = jQuery;

/***/ }),
/* 1 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "moveHtmlEl", function() { return moveHtmlEl; });
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(0);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);

const section = '.js-contact',
      moveEl = '.contact__item--event-time',
      viewList = '.search-results__list--list-view',
      targetEL = '.search-results__item--event',
      descEl = '.search-results__desc',
      titleEl = '.search-results__title',
      subTitleEl = '.search-results__sub-title';

function init() {
  moveHtmlEl();
}

function moveHtmlEl() {
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(targetEL).each(function () {
    let desc = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find(descEl),
        title = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find(titleEl),
        subTitle = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find(subTitleEl),
        move = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find(moveEl);

    if (jquery__WEBPACK_IMPORTED_MODULE_0___default()(viewList).length) {
      jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find(section).prepend(jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find(move));
    } else {
      switch (true) {
        case desc.length:
          desc.before(move);
          break;

        case subTitle.length:
          subTitle.after(move);
          break;

        default:
          title.after(move);
      }
    }
  });
}
init();

/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

__webpack_require__(3);
__webpack_require__(5);
__webpack_require__(16);
__webpack_require__(6);
__webpack_require__(1);
__webpack_require__(7);
__webpack_require__(8);
__webpack_require__(9);
__webpack_require__(10);
__webpack_require__(11);
__webpack_require__(12);
__webpack_require__(13);
__webpack_require__(14);
module.exports = __webpack_require__(15);


/***/ }),
/* 3 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _styles_global_scss__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(4);
/* harmony import */ var _styles_global_scss__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_styles_global_scss__WEBPACK_IMPORTED_MODULE_0__);
// CSS


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

// extracted by mini-css-extract-plugin

/***/ }),
/* 5 */
/***/ (function(module, exports) {

(function () {
  'use strict'; // Global variables

  var fb = {
    'fn': {},
    'vars': {
      mobileBreakpoint: 1024
    }
  }; // Functions

  fb.fn.sampleFunction = function () {};

  fb.fn.checkMobile = function (size) {
    let viewport = window.matchMedia('screen and (max-width:768px)');

    if (size !== undefined && parseInt(size) !== 'NaN') {
      viewport = window.matchMedia('screen and (max-width:' + size + 'px)');
    }

    if (viewport.matches) {
      return true;
    }

    return false;
  };

  fb.fn.checkMobileListener = function (size, callback, callback2) {
    let viewport = window.matchMedia('screen and (max-width:768px)');

    if (size !== undefined && parseInt(size) !== 'NaN') {
      viewport = window.matchMedia('screen and (max-width:' + size + 'px)');
    }

    if (typeof callback === 'function' && typeof callback2 === 'function') {
      if (viewport.matches) {
        callback();
      } else {
        callback2();
      }
    } else {
      console.log('callback is not a function');
    }

    viewport.addListener(function (mq) {
      if (typeof callback === 'function' && typeof callback2 === 'function') {
        if (mq.matches) {
          callback();
        } else {
          callback2();
        }
      } else {
        console.log('callback is not a function');
      }
    });
  }; // Make fb variable available to the console for debugging


  window.fb = fb;
})();

/***/ }),
/* 6 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(0);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);

const toggleBtn = '.btn-toggle';

function init() {
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(toggleBtn).each(function () {
    toggleElements(jquery__WEBPACK_IMPORTED_MODULE_0___default()(this));
  });
  bind();
}

function bind() {
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(toggleBtn).on('click', function () {
    toggleElements(jquery__WEBPACK_IMPORTED_MODULE_0___default()(this));
  });
}

function toggleElements(btn) {
  let showEl = typeof btn.attr('data-show') !== 'undefined' ? parseInt(btn.attr('data-show')) : 3,
      moreText = typeof btn.attr('data-more') !== 'undefined' ? btn.attr('data-more') : 'More',
      lessText = typeof btn.attr('data-less') !== 'undefined' ? btn.attr('data-less') : 'Less',
      listEl = btn.prev('ul'),
      listLength = listEl.find('li').length;
  btn.blur();

  if (listEl.length) {
    switch (true) {
      case listLength <= showEl:
        btn.hide();
        break;

      case listEl.find('li').not(':hidden').length === showEl:
        listEl.find('li').slideDown();
        btn.children().first().text(lessText).end().last().text('');
        break;

      default:
        listEl.find('li').slice(showEl, listEl.find('li').length).slideUp();
        btn.children().first().text(moreText).end().last().text('(' + (listLength - showEl) + ')');
    }
  }
}

init();

/***/ }),
/* 7 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(0);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);

const dropdownClass = '.js-dropdown-list__link',
      dropdownList = '.dropdown-list__list';

function init() {
  bind();
}

function bind() {
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(dropdownClass).on('click.dropdown', function () {
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).attr('aria-expanded', jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).next().is(':hidden'));

    if (jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).hasClass('opened')) {
      jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).removeClass('opened').next().slideUp();
    } else {
      jquery__WEBPACK_IMPORTED_MODULE_0___default()(dropdownClass).removeClass('opened').next().slideUp();
      jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).addClass('opened').next().slideDown();
    }
  });
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(dropdownClass).on('focus', function () {
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(dropdownClass).next().slideUp().end().removeClass('opened');
  });
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(document).on('click.dropdown', function (ev) {
    if (!jquery__WEBPACK_IMPORTED_MODULE_0___default()(ev.target).is('.dropdown-list') && !jquery__WEBPACK_IMPORTED_MODULE_0___default()(ev.target).is('.dropdown-list ' + ' *')) {
      jquery__WEBPACK_IMPORTED_MODULE_0___default()(dropdownList).slideUp();
      jquery__WEBPACK_IMPORTED_MODULE_0___default()(dropdownClass).attr('aria-expanded', 'false').removeClass('opened');
    }
  });
}

init();

/***/ }),
/* 8 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(0);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);

const section = '.js-module-compare',
      selectorCompare = '.js-module-compare',
      btnCompare = '.btn__compare',
      selectorBar = '.module-compare__close';

function init() {
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(section).on('click', selectorBar, function (e) {
    e.preventDefault();
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).closest(section).slideUp('slow');
  });
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(section).on('click', btnCompare, function (e) {
    e.preventDefault(); // open compare section

    jquery__WEBPACK_IMPORTED_MODULE_0___default()(selectorCompare).slideDown('slow');
  });
  jquery__WEBPACK_IMPORTED_MODULE_0___default()('table.module-compare__list,.search-results__table').each(function (i, table) {
    var self = jquery__WEBPACK_IMPORTED_MODULE_0___default()(table),
        arrTh = [],
        attr = '',
        thVertical = 0,
        index;
    self.find('th').each(function (j, th) {
      arrTh.push(th.innerText + attr);
    });
    self.find('tr').each(function (k, tr) {
      thVertical = jquery__WEBPACK_IMPORTED_MODULE_0___default()(tr).find('th').length ? 1 : 0;
      jquery__WEBPACK_IMPORTED_MODULE_0___default()(tr).find('td').each(function (z, td) {
        index = thVertical ? k : z;

        if (arrTh[index]) {
          jquery__WEBPACK_IMPORTED_MODULE_0___default()(td).addClass('datath');
          jquery__WEBPACK_IMPORTED_MODULE_0___default()(td).attr('data-th', arrTh[index]);
        }
      });
    });
  });
}

init();

/***/ }),
/* 9 */
/***/ (function(module, exports) {

const expandButtonSelector = "button.module-filter__button";
const detailsToggleSelector = "details.module-filter__item";
const summarySelector = "summary.module-filter__item-title";
/**
 * Adds the event listener for the button on mobile that
 * expands to show the facet(s) underneath of it.
 *
 * This is accomplished by setting aria-expanded on the
 * parent <div>, which controls the display of the facet items.
 */

document.querySelectorAll(expandButtonSelector).forEach(function (button) {
  button.addEventListener("click", function (_event) {
    // toggle aria-expanded value of the parent element
    const oldValue = button.parentElement.getAttribute("aria-expanded");
    button.parentElement.setAttribute("aria-expanded", oldValue === "true" ? "false" : "true");
  });
});
/**
 * Adds event listeners to the <details> elements which control
 * the toggling of showing the facet values to click.
 *
 * 1. Close other <details> elements when one is toggled open.
 *
 * 2. Close all <details> elements when focus is tabbed out of its contents.
 */

document.querySelectorAll(detailsToggleSelector).forEach(function (details) {
  // 1. Close other <details> elements when one is toggled open.
  details.addEventListener("toggle", function (_event) {
    if (details.open) {
      // The element was just toggled open
      document.querySelectorAll(detailsToggleSelector).forEach(function (otherDetails) {
        // If the other details isn't this one, close it
        if (otherDetails !== details) {
          otherDetails.removeAttribute("open");
        }
      });
    }
  });
}); // 2. Close all <details> elements when focus is tabbed out of its contents.

document.querySelectorAll(summarySelector).forEach(function (summary) {
  summary.addEventListener("focus", function (_event) {
    document.querySelectorAll(detailsToggleSelector).forEach(function (details) {
      details.removeAttribute("open");
    });
  });
}); // 2. Close all <details> elements when focus is tabbed out of its contents.
//
// TODO: Make this more robust by detecting focusout of the
// details/summary or its contents, instead of requiring
// coupling to the compare module 

const compareButton = document.querySelector('.btn__compare');

if (compareButton) {
  compareButton.addEventListener('focus', function (_event) {
    document.querySelectorAll(detailsToggleSelector).forEach(function (details) {
      details.removeAttribute("open");
    });
  });
}

/***/ }),
/* 10 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(0);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);

const section = '.js-module-search',
      searchInput = '.module-search__query',
      targetMuationEl = '.tt-menu',
      observeClass = 'tt-open',
      overlayClass = 'overlay';

function init() {
  bind();
}

function overlayMask() {
  let targetMutation = document.querySelectorAll(targetMuationEl);

  for (var i = 0; i < targetMutation.length; i++) {
    // create an observer instance
    var observer = new MutationObserver(function (mutations) {
      mutations.forEach(function (mutation) {
        if (mutation.attributeName === 'class') {
          var value = jquery__WEBPACK_IMPORTED_MODULE_0___default()(mutation.target).hasClass(observeClass),
              parent = jquery__WEBPACK_IMPORTED_MODULE_0___default()(mutation.target).closest(section);
          value ? parent.addClass(overlayClass) : parent.removeClass(overlayClass);
        }
      });
    }); // configuration of the observer

    const config = {
      attributes: true
    }; // pass in the target node, as well as the observer options

    observer.observe(targetMutation[i], config);
  }
}

function bind() {
  overlayMask();
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(section).on('focus', searchInput, function (e) {
    e.preventDefault(); // for mobile only

    window.fb.fn.checkMobile(window.fb.vars.mobileBreakpoint) && jquery__WEBPACK_IMPORTED_MODULE_0___default()('html, body').animate({
      scrollTop: jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).offset().top - 10
    }, '500');
    return false;
  });
}

init();

/***/ }),
/* 11 */
/***/ (function(module, exports) {

/**
 * The QuickView uses the native HTML `<dialog>` element
 * to display a dialog with additional information about
 * the search result which can be read by the user before
 * they go to the result URL itself.
 * 
 * Browser support for the `<dialog>` element:
 * https://caniuse.com/dialog
 * 
 * A custom overlay is used for browsers that do not
 * support the `<dialog>` element. This element should
 * be a `<div>` with the class specified below as the
 * overlaySelector which appears as the first element
 * in the `<body>`.
 */
const dialogSelector = '.js-quick-view',
      linkQuickViewSelector = '.js-quick-link',
      buttonCloseSelector = '.quick-view__close',
      overlaySelector = '.overlay',
      invisibleClass = 'invisible',
      // prevents keyboard focus of child elements
bodyClass = 'opened-view',
      // activates overlay for browsers not supporting dialog
noscrollClass = 'noscroll'; // adds `overflow: hidden`

function init() {
  addEventListeners();
}
/**
 * Shows the QuickView modal dialog that corresponds
 * to the targetSelector argument.
 * @param {*} targetSelector Selector for the QuickView to show
 */


function showQuickView(targetSelector) {
  if (document.querySelectorAll(dialogSelector).length > 0) {
    const dialog = document.querySelector(targetSelector);

    if (dialog) {
      dialog.classList.remove(invisibleClass);
      /**
       * Currently, Safari and Firefox do not support `<dialog>`
       * elements natively.
       */

      if (typeof dialog.showModal === 'function') {
        dialog.showModal(); // Prevents scrolling of the rest of the page

        document.body.classList.add(noscrollClass);
      } else {
        dialog.setAttribute('open', ''); // show custom overlay on browsers not supporting dialog
        // this also prevents scrolling

        document.body.classList.add(bodyClass);
      } // Move focus to the button that closes the quickview


      const closeButton = dialog.querySelector(buttonCloseSelector);

      if (closeButton) {
        closeButton.focus();
      } else {
        console.error('Expected a button with class "' + buttonCloseSelector + '" to exist within the quickview.');
      }
    } else {
      console.error('Expected a quickview section with selector "' + targetSelector + '" to exist.');
    }
  }
}
/**
 * Hides all currently open QuickView modal dialogs.
 */


function hideQuickView() {
  const openDialogs = document.querySelectorAll(dialogSelector + '[open]');
  openDialogs.forEach(function (dialog) {
    /**
     * Currently, Safari and Firefox do not support `<dialog>`
     * elements natively.
     */
    if (typeof dialog.close === 'function') {
      dialog.close(); // Prevents scrolling of the rest of the page

      document.body.classList.remove(noscrollClass);
    } else {
      dialog.removeAttribute('open'); // hide custom overlay on browsers not supporting dialog

      document.body.classList.remove(bodyClass);
    }
    /**
     * This is necessary to add the CSS `invisible` property 
     * with JS instead of using CSS transition for a smooth 
     * "slide out" because the `invisible` property is a 
     * multiple choice, not a value that can be transitioned.
     */


    window.setTimeout(function () {
      dialog.classList.add(invisibleClass);
    }, 400);
  });
}
/**
 * Attaches event listeners to elements related to the 
 * QuickView feature.
 */


function addEventListeners() {
  /**
   * Attach event listeners to the buttons to open the
   * dialogs.
   * 
   * These first close the open dialog (if any), although
   * that should not be a situation that occurs because of
   * the dialog overlay.
   */
  const openButtons = document.querySelectorAll(linkQuickViewSelector);
  openButtons.forEach(function (button) {
    button.addEventListener('click', function (_event) {
      const target = this.dataset.target;
      hideQuickView();
      showQuickView(target);
    });
  });
  /**
   * Each dialog will contain a button that closes that dialog.
   * 
   * This is the button that should generally receive first focus
   * when the dialog is opened.
   */

  const closeButtons = document.querySelectorAll(buttonCloseSelector);
  closeButtons.forEach(function (button) {
    button.addEventListener('click', function (_event) {
      hideQuickView();
    });
  });
  const dialogs = document.querySelectorAll(dialogSelector);
  dialogs.forEach(function (dialog) {
    /**
     * Browsers that currently support the native `<dialog>`
     * element provide a native overlay (and therefore 
     * `<dialog>` receives the click event).
     * 
     * This listener checks if the click was outside the visible bounds
     * of the <dialog> and should therefore close the dialog.
     * 
     * Further information:
     * https://stackoverflow.com/questions/25864259/how-to-close-the-new-html-dialog-tag-by-clicking-on-its-backdrop
     * 
     * Browsers may support a better way natively in the future.     
    */
    dialog.addEventListener('click', function (event) {
      const rect = event.target.getBoundingClientRect();
      const clickedInDialog = rect.top <= event.clientY && event.clientY <= rect.top + rect.height && rect.left <= event.clientX && event.clientX <= rect.left + rect.width;

      if (!clickedInDialog) {
        hideQuickView();
      }
    });
  });
  /**
   * For browsers that do not support the native `<dialog>` element,
   * we use a custom overlay element. When this element receives a click,
   * then the open dialog should be closed.
   * 
   * The overlay can be removed when all target browsers support 
   * the native `<dialog>` element.
   */

  const overlay = document.querySelector(overlaySelector);

  if (overlay) {
    overlay.addEventListener('click', function (_event) {
      hideQuickView();
    });
  } else {
    console.error('Expected an overlay element with class "' + overlaySelector + '"');
  }
}

init();

/***/ }),
/* 12 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(0);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _content_contact_js_global__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(1);


const section = '.js-search-results',
      btn = '.search-results__icon',
      activeClass = 'active',
      viewList = "search-results__list--list-view",
      targetSelector = '.search-results__list';

function changeView() {
  //   $('.module-az').length && $(section).off('click.view');
  !jquery__WEBPACK_IMPORTED_MODULE_0___default()('.module-az').length && jquery__WEBPACK_IMPORTED_MODULE_0___default()(section).on('click.view', btn, function (e) {
    e.preventDefault();

    if (jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).hasClass(activeClass)) {
      return 0;
    }

    let listResults = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).closest(section).find(targetSelector);
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).addClass(activeClass).siblings().removeClass(activeClass);
    listResults.hasClass(viewList) ? listResults.removeClass(viewList) : listResults.addClass(viewList);
    Object(_content_contact_js_global__WEBPACK_IMPORTED_MODULE_1__["moveHtmlEl"])();
  });
}

changeView();

/***/ }),
/* 13 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(0);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);

const section = '.js-tabs',
      buttonTabMenu = '.tabs__menu-btn',
      buttonTabMenuTemplate = `<button class="tabs__menu-btn" aria-haspopup="true" aria-expanded="false">
                                <span class="sr-only">Show/hide menu</span>
                               </button>`;

function init() {
  // for resize window / mobile / desktop
  window.fb.fn.checkMobileListener(window.fb.vars.mobileBreakpoint, mobileTabs, desktopTabs);
  bind();
}

function mobileTabs() {
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(section).each(function () {
    let listTab = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find('ul');
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).removeClass('open');
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find('.active').parent().css('order', '-1');
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(buttonTabMenuTemplate).prependTo(this); // accessibility

    listTab.attr('role', 'menu').find('a').attr('role', 'menuitem').attr('tabindex', '-1');
  });
}

function desktopTabs() {
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(section).each(function () {
    let listTab = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find('ul'); // accessibility

    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find('.active').parent().css('order', '');
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find(buttonTabMenu).remove();
    listTab.find('a').removeAttr('role').removeAttr('tabindex');
  });
}

function bind() {
  // event for clicked button tab menu
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(section).on('click', buttonTabMenu, function (e) {
    e.preventDefault();

    if (window.fb.fn.checkMobile(window.fb.vars.mobileBreakpoint)) {
      let sectionTab = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).closest(section),
          listTab = sectionTab.find('ul');
      sectionTab.toggleClass('open');
      sectionTab.hasClass('open') ? listTab.find('a').not('.active').attr('tabindex', '0') : listTab.find('a').attr('tabindex', '-1'); // accessibility

      sectionTab.find(buttonTabMenu).attr('aria-expanded', sectionTab.hasClass('open'));
    }
  });
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(document).on('click focus keyup', function (ev) {
    if (!jquery__WEBPACK_IMPORTED_MODULE_0___default()(ev.target).is(section + " *") && window.fb.fn.checkMobile(window.fb.vars.mobileBreakpoint)) {
      // accessibility
      jquery__WEBPACK_IMPORTED_MODULE_0___default()(section).removeClass('open').find('a').attr('tabindex', '-1');
      jquery__WEBPACK_IMPORTED_MODULE_0___default()(buttonTabMenu).attr('aria-expanded', 'false');
    }
  });
}

init();

/***/ }),
/* 14 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(0);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);

/**
 * functions for management hamburger button and mobile menu
 */

let hamburger = {
  targetButton: '.header-hamburger__button',
  init: function () {
    let self = this;
    self.bind();
  },
  bind: function () {
    let self = this;
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(self.targetButton).on('click', function (e) {
      e.preventDefault();
      jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).toggleClass('is-active');
    });
  }
};
hamburger.init();

/***/ }),
/* 15 */
/***/ (function(module, exports) {



/***/ }),
/* 16 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// EXTERNAL MODULE: external "jQuery"
var external_jQuery_ = __webpack_require__(0);
var external_jQuery_default = /*#__PURE__*/__webpack_require__.n(external_jQuery_);

// CONCATENATED MODULE: ./src/modules/content/sqPlugins/sqAccordion/js/jquery-sqAccordion.js

/**
 * Created by Mateusz Chuchro [Squiz Poland] on 05/07/16.
 */

function sqAccordion(params) {
  var settings = external_jQuery_default.a.extend({
    //##Core
    container: ".accordion",
    item: ".accordion__item",
    itemHead: ".accordion__item__head",
    itemLink: ".accordion__item__link",
    itemContent: ".accordion__item__content",
    active: ".active",
    activeAll: false
  }, params);
  /**
   *  @name generateStruct
   *  @params none
   *  @desc Find each element with class $itemHead and wrap text with anchor
   */

  function generateStruct() {
    external_jQuery_default.a.each(external_jQuery_default()(settings.container), function (keyCont) {
      let $this = external_jQuery_default()(this);
      $this.find(settings.item).each(function (key) {
        $this = external_jQuery_default()(this);
        $this.find(settings.itemHead).each(function () {
          let $this = external_jQuery_default()(this),
              insideText = $this.text();
          $this.html("<a class=" + settings.itemLink.split(".").join("") + " aria-controls=collapsible-" + keyCont + key + ' aria-expanded="false" href="#"><span>' + insideText + "</span></a>");
        });
        $this.find(settings.itemContent).each(function () {
          let $this = external_jQuery_default()(this);
          $this.attr("aria-hidden", "true");
          $this.attr("id", "collapsible-" + keyCont + key);
        }); // $this.find(settings.itemContent).find('a').each(function() {
        //     $(this).attr('tabindex', '-1');
        // });
      });
    });
  }
  /**
   * @name clickHandler
   * @params none
   * @desc Detect click event on the accordion and show content
   */


  function clickHandler() {
    external_jQuery_default()(settings.item + " " + settings.itemHead + " a").on("click", function (e) {
      e.preventDefault();
      let $this = external_jQuery_default()(this),
          parent = $this.parents(settings.container),
          active = settings.active.split(".").join(""); //  parent.siblings().find(settings.item).removeClass(active);

      parent.siblings().find(settings.itemLink).attr("aria-expanded", "false");
      parent.siblings().find(settings.itemContent).attr("aria-hidden", "true");

      if (typeof $this.closest(settings.container).attr("data-active-all") !== "undefined") {
        settings.activeAll = /true/i.test($this.closest(settings.container).attr("data-active-all"));
      }

      if (settings.activeAll === false) {
        $this.closest(settings.item).siblings().removeClass(active);
        $this.closest(settings.item).siblings().find(settings.itemLink).attr("aria-expanded", "false");
        $this.closest(settings.item).siblings().find(settings.itemContent).attr("aria-hidden", "true");
      }

      $this.closest(settings.item).hasClass(active) ? $this.attr("aria-expanded", "false") : $this.attr("aria-expanded", "true");
      $this.closest(settings.item).hasClass(active) ? $this.closest(settings.item).find(settings.itemContent).attr("aria-hidden", "true") : $this.closest(settings.item).find(settings.itemContent).attr("aria-hidden", "false"); // $this.closest(settings.item).hasClass(active)
      //     ? $this
      //         .closest(settings.item)
      //         .find(settings.itemContent)
      //         .attr('tabindex', "-1")
      //         .find('a')
      //         .each(function() {
      //             $(this).attr('tabindex', "-1");
      //         })
      //     : $this
      //         .closest(settings.item)
      //         .find(settings.itemContent)
      //         .attr('tabindex', "0")
      //         .find('a')
      //         .each(function() {
      //             $(this).attr('tabindex', "0");
      //         });

      $this.closest(settings.item).hasClass(active) ? $this.closest(settings.item).removeClass(active) : $this.closest(settings.item).addClass(active);
    });
    external_jQuery_default()(document).on("click focus keyup", function (ev) {
      if (!external_jQuery_default()(ev.target).is(settings.container + " *")) {
        external_jQuery_default()(settings.container).find(settings.active).removeClass("active");
        external_jQuery_default()(settings.container).find(settings.itemLink).attr("aria-expanded", "false");
        external_jQuery_default()(settings.container).find(settings.itemContent).attr("aria-hidden", "true"); // $(settings.container)
        //     .find(settings.itemContent)
        //     .attr("tabindex", "-1")
        //     .find("a")
        //     .each(function () {
        //         $(this).attr("tabindex", "-1");
        //     });
      }
    });
  } //#Init


  generateStruct();
  clickHandler();
}
// CONCATENATED MODULE: ./src/modules/content/accordion/js/global.js

sqAccordion({
  //##Core
  container: '.module-accordion__list',
  item: '.module-accordion__item',
  itemHead: '.module-accordion__head',
  itemLink: '.module-accordion__link',
  itemContent: '.module-accordion__content',
  active: '.active',
  activeAll: false,
  activeAllData: 'data-active-all',
  speed: 500
});

/***/ })
/******/ ]);
//# sourceMappingURL=main.js.map