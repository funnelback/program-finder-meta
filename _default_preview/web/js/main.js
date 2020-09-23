(window["webpackJsonp"] = window["webpackJsonp"] || []).push([[0],{

/***/ 120:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "moveHtmlEl", function() { return moveHtmlEl; });
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(49);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(1);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_1__);


var section = '.js-contact',
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
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(targetEL).each(function () {
    var desc = jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).find(descEl),
        title = jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).find(titleEl),
        subTitle = jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).find(subTitleEl),
        move = jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).find(moveEl);

    if (jquery__WEBPACK_IMPORTED_MODULE_1___default()(viewList).length) {
      jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).find(section).prepend(jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).find(move));
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

/***/ 177:
/***/ (function(module, exports, __webpack_require__) {

__webpack_require__(178);
__webpack_require__(380);
__webpack_require__(382);
__webpack_require__(433);
__webpack_require__(415);
__webpack_require__(120);
__webpack_require__(421);
__webpack_require__(422);
__webpack_require__(423);
__webpack_require__(424);
__webpack_require__(428);
__webpack_require__(429);
__webpack_require__(430);
__webpack_require__(431);
module.exports = __webpack_require__(432);


/***/ }),

/***/ 380:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _styles_global_scss__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(381);
/* harmony import */ var _styles_global_scss__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_styles_global_scss__WEBPACK_IMPORTED_MODULE_0__);
// CSS


/***/ }),

/***/ 381:
/***/ (function(module, exports, __webpack_require__) {

// extracted by mini-css-extract-plugin

/***/ }),

/***/ 382:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var core_js_modules_es_parse_int__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(157);
/* harmony import */ var core_js_modules_es_parse_int__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_parse_int__WEBPACK_IMPORTED_MODULE_0__);


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
    var viewport = window.matchMedia('screen and (max-width:768px)');

    if (size !== undefined && parseInt(size) !== 'NaN') {
      viewport = window.matchMedia('screen and (max-width:' + size + 'px)');
    }

    if (viewport.matches) {
      return true;
    }

    return false;
  };

  fb.fn.checkMobileListener = function (size, callback, callback2) {
    var viewport = window.matchMedia('screen and (max-width:768px)');

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

/***/ 415:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(49);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var core_js_modules_es_array_slice__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(416);
/* harmony import */ var core_js_modules_es_array_slice__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_array_slice__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var core_js_modules_es_parse_int__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(157);
/* harmony import */ var core_js_modules_es_parse_int__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_parse_int__WEBPACK_IMPORTED_MODULE_2__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(1);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_3__);




var toggleBtn = '.btn-toggle';

function init() {
  jquery__WEBPACK_IMPORTED_MODULE_3___default()(toggleBtn).each(function () {
    toggleElements(jquery__WEBPACK_IMPORTED_MODULE_3___default()(this));
  });
  bind();
}

function bind() {
  jquery__WEBPACK_IMPORTED_MODULE_3___default()(toggleBtn).on('click', function () {
    toggleElements(jquery__WEBPACK_IMPORTED_MODULE_3___default()(this));
  });
}

function toggleElements(btn) {
  var showEl = typeof btn.attr('data-show') !== 'undefined' ? parseInt(btn.attr('data-show')) : 3,
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

/***/ 421:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(1);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);

var dropdownClass = '.js-dropdown-list__link',
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

/***/ 422:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(49);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(1);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_1__);


var section = '.js-module-compare',
    selectorBar = '.module-compare__close';

function init() {
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).on('click', selectorBar, function (e) {
    e.preventDefault();
    jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).closest(section).slideUp('slow');
  });
  jquery__WEBPACK_IMPORTED_MODULE_1___default()('table.module-compare__list,.search-results__table').each(function (i, table) {
    var self = jquery__WEBPACK_IMPORTED_MODULE_1___default()(table),
        arrTh = [],
        attr = '',
        thVertical = 0,
        index;
    self.find('th').each(function (j, th) {
      arrTh.push(th.innerText + attr);
    });
    self.find('tr').each(function (k, tr) {
      thVertical = jquery__WEBPACK_IMPORTED_MODULE_1___default()(tr).find('th').length ? 1 : 0;
      jquery__WEBPACK_IMPORTED_MODULE_1___default()(tr).find('td').each(function (z, td) {
        index = thVertical ? k : z;

        if (arrTh[index]) {
          jquery__WEBPACK_IMPORTED_MODULE_1___default()(td).addClass('datath');
          jquery__WEBPACK_IMPORTED_MODULE_1___default()(td).attr('data-th', arrTh[index]);
        }
      });
    });
  });
}

init();

/***/ }),

/***/ 423:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(49);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(1);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_1__);


var section = '.js-module-filter',
    btnFilter = '.module-filter__title',
    btnMenu = '.module-filter__item-title',
    item = '.module-filter__item',
    activeClass = 'active',
    selectorCompare = '.js-module-compare',
    btnCompare = '.btn__compare',
    twoCol = '.content-wrapper--col';

function init() {
  // check mobile window
  window.fb.fn.checkMobileListener(window.fb.vars.mobileBreakpoint, mobileFilter, desktopFilter);
  bind();
}

function bind() {
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).on('click keypress', btnMenu, function (e) {
    e.preventDefault(); // for mobile only

    window.fb.fn.checkMobile(window.fb.vars.mobileBreakpoint) && jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).toggleClass(activeClass).attr('aria-expanded', jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).hasClass(activeClass)).next().slideToggle(); // for desktop and twoCol class

    !window.fb.fn.checkMobile(window.fb.vars.mobileBreakpoint) && jquery__WEBPACK_IMPORTED_MODULE_1___default()(twoCol).length && jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).toggleClass('open').attr('aria-expanded', jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).hasClass('open')).next().slideToggle();
  }); // open/close mobile filter

  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).on('click', btnFilter, function (e) {
    e.preventDefault();
    jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).hasClass(activeClass) && jquery__WEBPACK_IMPORTED_MODULE_1___default()(btnMenu).removeClass(activeClass).next().hide();
    window.fb.fn.checkMobile(window.fb.vars.mobileBreakpoint) && jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).toggleClass(activeClass).attr('aria-expanded', jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).hasClass(activeClass)).next().slideToggle();
  }); // keypress enter, open/close filter / keyboard accessibility

  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).on('keypress', function (e) {
    e.which === 13 && !window.fb.fn.checkMobile(window.fb.vars.mobileBreakpoint) && jquery__WEBPACK_IMPORTED_MODULE_1___default()(twoCol).length && jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).toggleClass('open').attr('aria-expanded', jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).hasClass('open')).next().slideToggle();
  }); // keyboard accessibility

  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).on('mouseenter focusin', item, function () {
    !jquery__WEBPACK_IMPORTED_MODULE_1___default()(twoCol).length && jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).find(btnMenu).attr('aria-expanded', true);
  }); // keyboard accessibility

  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).on('mouseleave focusout', item, function () {
    !jquery__WEBPACK_IMPORTED_MODULE_1___default()(twoCol).length && jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).find(btnMenu).attr('aria-expanded', false);
  });
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).on('click', btnCompare, function (e) {
    e.preventDefault(); // open compare section

    jquery__WEBPACK_IMPORTED_MODULE_1___default()(selectorCompare).slideDown('slow');
  });
}

function mobileFilter() {
  // add aria attributes
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(btnFilter).attr({
    'role': 'button',
    'aria-haspopup': true,
    'aria-expanded': false
  });
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(btnMenu).attr('role', 'button');
}

function desktopFilter() {
  // remove aria attributes
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(btnMenu).removeClass(activeClass).removeAttr('role').parent().blur().end().next().removeAttr('style');
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(btnFilter).removeClass(activeClass).removeAttr('role aria-haspopup aria-expanded').next().removeAttr('style');
}

init();

/***/ }),

/***/ 424:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var core_js_modules_es_array_for_each__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(425);
/* harmony import */ var core_js_modules_es_array_for_each__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_array_for_each__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var core_js_modules_web_dom_collections_for_each__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(426);
/* harmony import */ var core_js_modules_web_dom_collections_for_each__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_web_dom_collections_for_each__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(1);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_2__);



var section = '.js-module-search',
    searchInput = '.module-search__query',
    targetMuationEl = '.tt-menu',
    observeClass = 'tt-open',
    overlayClass = 'overlay';

function init() {
  bind();
}

function overlayMask() {
  var targetMutation = document.querySelectorAll(targetMuationEl);

  for (var i = 0; i < targetMutation.length; i++) {
    // create an observer instance
    var observer = new MutationObserver(function (mutations) {
      mutations.forEach(function (mutation) {
        if (mutation.attributeName === 'class') {
          var value = jquery__WEBPACK_IMPORTED_MODULE_2___default()(mutation.target).hasClass(observeClass),
              parent = jquery__WEBPACK_IMPORTED_MODULE_2___default()(mutation.target).closest(section);
          value ? parent.addClass(overlayClass) : parent.removeClass(overlayClass);
        }
      });
    }); // configuration of the observer

    var config = {
      attributes: true
    }; // pass in the target node, as well as the observer options

    observer.observe(targetMutation[i], config);
  }
}

function bind() {
  overlayMask();
  jquery__WEBPACK_IMPORTED_MODULE_2___default()(section).on('focus', searchInput, function (e) {
    e.preventDefault(); // for mobile only

    window.fb.fn.checkMobile(window.fb.vars.mobileBreakpoint) && jquery__WEBPACK_IMPORTED_MODULE_2___default()('html, body').animate({
      scrollTop: jquery__WEBPACK_IMPORTED_MODULE_2___default()(this).offset().top - 10
    }, '500');
    return false;
  });
}

init();

/***/ }),

/***/ 428:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(1);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);

var section = '.js-quick-view',
    linkQuickView = '.js-quick-link',
    buttonClose = '.quick-view__close',
    activeClass = 'opened',
    bodyClass = 'opened-view';

function init() {
  bind();
}

function showQuickView() {
  if (jquery__WEBPACK_IMPORTED_MODULE_0___default()(section).length) {
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(section).addClass(activeClass);
    jquery__WEBPACK_IMPORTED_MODULE_0___default()('body').addClass(bodyClass);
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(section).attr('tabindex', '0').focus();
  }
}

function hideQuickView() {
  if (jquery__WEBPACK_IMPORTED_MODULE_0___default()(section).length) {
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(section).removeClass(activeClass);
    jquery__WEBPACK_IMPORTED_MODULE_0___default()('body').removeClass(bodyClass);
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(section).attr('tabindex', '-1');
  }
}

function bind() {
  // event for clicked
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(document).on('click.quickview', linkQuickView, function (e) {
    e.preventDefault();
    showQuickView();
  });
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(document).on('click.quickview', buttonClose, function (e) {
    e.preventDefault();
    hideQuickView();
  });
  jquery__WEBPACK_IMPORTED_MODULE_0___default()(document).on('click.quickview', function (ev) {
    if (!jquery__WEBPACK_IMPORTED_MODULE_0___default()(ev.target).is(linkQuickView) && !jquery__WEBPACK_IMPORTED_MODULE_0___default()(ev.target).is(section + ' *')) {
      hideQuickView();
    }
  });
}

init();

/***/ }),

/***/ 429:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(49);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(1);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var _content_contact_js_global__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(120);



var section = '.js-search-results',
    btn = '.search-results__icon',
    activeClass = 'active',
    viewList = "search-results__list--list-view",
    targetSelector = '.search-results__list';

function changeView() {
  //   $('.module-az').length && $(section).off('click.view');
  !jquery__WEBPACK_IMPORTED_MODULE_1___default()('.module-az').length && jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).on('click.view', btn, function (e) {
    e.preventDefault();

    if (jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).hasClass(activeClass)) {
      return 0;
    }

    var listResults = jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).closest(section).find(targetSelector);
    jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).addClass(activeClass).siblings().removeClass(activeClass);
    listResults.hasClass(viewList) ? listResults.removeClass(viewList) : listResults.addClass(viewList);
    Object(_content_contact_js_global__WEBPACK_IMPORTED_MODULE_2__["moveHtmlEl"])();
  });
}

changeView();

/***/ }),

/***/ 430:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(49);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(1);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_1__);


var section = '.js-tabs',
    buttonTabMenu = '.tabs__menu-btn',
    buttonTabMenuTemplate = "<button class=\"tabs__menu-btn\" aria-haspopup=\"true\" aria-expanded=\"false\">\n                                <span class=\"sr-only\">Show/hide menu</span>\n                               </button>";

function init() {
  // for resize window / mobile / desktop
  window.fb.fn.checkMobileListener(window.fb.vars.mobileBreakpoint, mobileTabs, desktopTabs);
  bind();
}

function mobileTabs() {
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).each(function () {
    var listTab = jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).find('ul');
    jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).removeClass('open');
    jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).find('.active').parent().css('order', '-1');
    jquery__WEBPACK_IMPORTED_MODULE_1___default()(buttonTabMenuTemplate).prependTo(this); // accessibility

    listTab.attr('role', 'menu').find('a').attr('role', 'menuitem').attr('tabindex', '-1');
  });
}

function desktopTabs() {
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).each(function () {
    var listTab = jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).find('ul'); // accessibility

    jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).find('.active').parent().css('order', '');
    jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).find(buttonTabMenu).remove();
    listTab.find('a').removeAttr('role').removeAttr('tabindex');
  });
}

function bind() {
  // event for clicked button tab menu
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).on('click', buttonTabMenu, function (e) {
    e.preventDefault();

    if (window.fb.fn.checkMobile(window.fb.vars.mobileBreakpoint)) {
      var sectionTab = jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).closest(section),
          listTab = sectionTab.find('ul');
      sectionTab.toggleClass('open');
      sectionTab.hasClass('open') ? listTab.find('a').not('.active').attr('tabindex', '0') : listTab.find('a').attr('tabindex', '-1'); // accessibility

      sectionTab.find(buttonTabMenu).attr('aria-expanded', sectionTab.hasClass('open'));
    }
  });
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(document).on('click focus keyup', function (ev) {
    if (!jquery__WEBPACK_IMPORTED_MODULE_1___default()(ev.target).is(section + " *") && window.fb.fn.checkMobile(window.fb.vars.mobileBreakpoint)) {
      // accessibility
      jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).removeClass('open').find('a').attr('tabindex', '-1');
      jquery__WEBPACK_IMPORTED_MODULE_1___default()(buttonTabMenu).attr('aria-expanded', 'false');
    }
  });
}

init();

/***/ }),

/***/ 431:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(1);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);

/**
 * functions for management hamburger button and mobile menu
 */

var hamburger = {
  targetButton: '.header-hamburger__button',
  init: function init() {
    var self = this;
    self.bind();
  },
  bind: function bind() {
    var self = this;
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(self.targetButton).on('click', function (e) {
      e.preventDefault();
      jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).toggleClass('is-active');
    });
  }
};
hamburger.init();

/***/ }),

/***/ 432:
/***/ (function(module, exports) {



/***/ }),

/***/ 433:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);

// EXTERNAL MODULE: ./node_modules/core-js/modules/es.array.find.js
var es_array_find = __webpack_require__(49);

// EXTERNAL MODULE: ./node_modules/core-js/modules/es.array.join.js
var es_array_join = __webpack_require__(405);

// EXTERNAL MODULE: ./node_modules/core-js/modules/es.regexp.exec.js
var es_regexp_exec = __webpack_require__(175);

// EXTERNAL MODULE: ./node_modules/core-js/modules/es.string.split.js
var es_string_split = __webpack_require__(408);

// EXTERNAL MODULE: ./node_modules/jquery/dist/jquery.js
var jquery = __webpack_require__(1);
var jquery_default = /*#__PURE__*/__webpack_require__.n(jquery);

// CONCATENATED MODULE: ./src/modules/content/sqPlugins/sqAccordion/js/jquery-sqAccordion.js





/**
 * Created by Mateusz Chuchro [Squiz Poland] on 05/07/16.
 */

function sqAccordion(params) {
  var settings = jquery_default.a.extend({
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
    jquery_default.a.each(jquery_default()(settings.container), function (keyCont) {
      var $this = jquery_default()(this);
      $this.find(settings.item).each(function (key) {
        $this = jquery_default()(this);
        $this.find(settings.itemHead).each(function () {
          var $this = jquery_default()(this),
              insideText = $this.text();
          $this.html("<a class=" + settings.itemLink.split(".").join("") + " aria-controls=collapsible-" + keyCont + key + ' aria-expanded="false" href="#"><span>' + insideText + "</span></a>");
        });
        $this.find(settings.itemContent).each(function () {
          var $this = jquery_default()(this);
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
    jquery_default()(settings.item + " " + settings.itemHead + " a").on("click", function (e) {
      e.preventDefault();
      var $this = jquery_default()(this),
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
    jquery_default()(document).on("click focus keyup", function (ev) {
      if (!jquery_default()(ev.target).is(settings.container + " *")) {
        jquery_default()(settings.container).find(settings.active).removeClass("active");
        jquery_default()(settings.container).find(settings.itemLink).attr("aria-expanded", "false");
        jquery_default()(settings.container).find(settings.itemContent).attr("aria-hidden", "true"); // $(settings.container)
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

},[[177,1,2]]]);
//# sourceMappingURL=main.js.map