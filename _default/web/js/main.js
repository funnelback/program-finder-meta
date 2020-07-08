(window["webpackJsonp"] = window["webpackJsonp"] || []).push([[0],{

/***/ 165:
/***/ (function(module, exports, __webpack_require__) {

__webpack_require__(166);
__webpack_require__(368);
__webpack_require__(370);
__webpack_require__(387);
__webpack_require__(401);
__webpack_require__(402);
__webpack_require__(403);
__webpack_require__(404);
module.exports = __webpack_require__(405);


/***/ }),

/***/ 368:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _styles_global_scss__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(369);
/* harmony import */ var _styles_global_scss__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_styles_global_scss__WEBPACK_IMPORTED_MODULE_0__);
// CSS


/***/ }),

/***/ 369:
/***/ (function(module, exports, __webpack_require__) {

// extracted by mini-css-extract-plugin

/***/ }),

/***/ 370:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var core_js_modules_es_parse_int__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(371);
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

/***/ 387:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(108);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(2);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_1__);


var section = '.js-module-compare',
    selectorBar = '.module-compare__close';

function init() {
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).on('click', selectorBar, function (e) {
    e.preventDefault();
    jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).closest(section).slideUp('slow');
  });
  jquery__WEBPACK_IMPORTED_MODULE_1___default()('table.module-compare__list').each(function (i, table) {
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

/***/ 401:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(108);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(2);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_1__);


var section = '.js-module-filter',
    btnFilter = '.module-filter__title',
    btnMenu = '.module-filter__item-title',
    item = '.module-filter__item',
    activeClass = 'active',
    selectorCompare = '.js-module-compare',
    btnCompare = '.btn__compare';

function init() {
  window.fb.fn.checkMobileListener(window.fb.vars.mobileBreakpoint, mobileFilter, desktopFilter);
  bind();
}

function bind() {
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).on('click', btnMenu, function (e) {
    e.preventDefault(); // for mobile only

    window.fb.fn.checkMobile(window.fb.vars.mobileBreakpoint) && jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).toggleClass(activeClass).attr('aria-expanded', jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).hasClass(activeClass)).next().slideToggle();
  });
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).on('click', btnFilter, function (e) {
    e.preventDefault(); // for mobile only

    jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).hasClass(activeClass) && jquery__WEBPACK_IMPORTED_MODULE_1___default()(btnMenu).removeClass(activeClass).next().hide();
    window.fb.fn.checkMobile(window.fb.vars.mobileBreakpoint) && jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).toggleClass(activeClass).attr('aria-expanded', jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).hasClass(activeClass)).next().slideToggle();
  });
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).on('mouseenter focusin', item, function () {
    jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).find(btnMenu).attr('aria-expanded', true);
  });
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).on('mouseleave focusout', item, function () {
    jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).find(btnMenu).attr('aria-expanded', false);
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
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(btnMenu).removeClass(activeClass).removeAttr('role').parent().blur().end().next().removeAttr('style');
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(btnFilter).removeClass(activeClass).removeAttr('role aria-haspopup aria-expanded').next().removeAttr('style');
}

init();

/***/ }),

/***/ 402:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(2);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);

var section = '.js-module-search',
    searchInput = '.module-search__query';

function init() {
  bind();
}

function bind() {
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

/***/ 403:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(108);
/* harmony import */ var core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_array_find__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(2);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_1__);


var section = '.js-search-results',
    btn = '.search-results__icon',
    activeClass = 'active',
    viewList = "search-results__list--list-view",
    targetSelector = '.search-results__list';

function changeView() {
  jquery__WEBPACK_IMPORTED_MODULE_1___default()(section).on('click', btn, function (e) {
    e.preventDefault();

    if (jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).hasClass(activeClass)) {
      return 0;
    }

    var listResults = jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).closest(section).find(targetSelector);
    jquery__WEBPACK_IMPORTED_MODULE_1___default()(this).addClass(activeClass).siblings().removeClass(activeClass);
    listResults.hasClass(viewList) ? listResults.removeClass(viewList) : listResults.addClass(viewList);
  });
}

changeView();

/***/ }),

/***/ 404:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(2);
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

/***/ 405:
/***/ (function(module, exports) {



/***/ })

},[[165,1,2]]]);
//# sourceMappingURL=main.js.map