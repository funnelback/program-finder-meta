/*! For license information please see AutocompleteProvider-dea5faaa7e7b5545582f.js.LICENSE.txt */
(self.webpackChunkPlug_and_Play_Template=self.webpackChunkPlug_and_Play_Template||[]).push([[701],{64945:function(e,t,r){"use strict";r.r(t),r.d(t,{default:function(){return h}});r(33948);var o=r(67294),n=r(45697),c=r.n(n),a=r(27354),s=r(98069);class l{constructor(e){if(!e||0===e.length)throw new Error("At least one adapter is required for AutocompleteService");this.autocompleteAdapters=[],Array.from(e).forEach((e=>{if(!e||!e.hasOwnProperty("autocomplete"))throw new Error("".concat(e.constructor.name," is not implemented yet"));this.registerAdapter(e)}))}registerAdapter(e){this.autocompleteAdapters.push(e)}getResults(e,t){return Promise.all(this.autocompleteAdapters.map((r=>r.getResults(e,t)))).then((e=>{const t=[];let r=0,o=0;return e.map(((e,n)=>{let{data:c}=e;return r+=c.length,t[n]=[],c.length&&c.forEach((e=>{t[n][o++]=e})),t})),{results:t,count:r}})).catch((e=>(console.error(e),{results:0,count:0,error:e})))}}var i=r(48131),u=r(6838),m=r(66004);function d(){return d=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var r=arguments[t];for(var o in r)Object.prototype.hasOwnProperty.call(r,o)&&(e[o]=r[o])}return e},d.apply(this,arguments)}const p=e=>{let{fetching:t,onSubmit:r,componentId:n}=e;return t?o.createElement("div",{className:"autocomplete-concierge__loader","aria-hidden":"true"},o.createElement("svg",{className:"svg-icon",role:"img",focusable:!1},o.createElement("use",{href:"#spinner"}))):o.createElement("button",{type:"submit",className:"autocomplete-concierge__submit",onClick:r,"aria-labelledby":"".concat(n,"-submit-label")},o.createElement("svg",{className:"svg-icon",role:"img",focusable:!1},o.createElement("title",{id:"".concat(n,"-submit-label")},"Submit search"),o.createElement("use",{href:"#search"})))};function f(e){const{id:t,templates:n,placeholder:c,debounce:l,action:u,method:f,hiddenFields:h,inputAttributes:v,showSubmit:g,onClose:E,showClear:y,showLoader:b}=e,{setSelectedIndex:C,selectedIndex:_,count:w,fetchResults:S,fetching:k}=(0,i.o)(),[x,P]=(0,o.useState)(null),[T,N]=(0,o.useState)(null),[O,j]=(0,o.useState)(null),[A,I]=(0,o.useState)(""),[L,R]=(0,o.useState)(""),[D,U]=(0,o.useState)(!1),[q,M]=(0,o.useState)("autocomplete-concierge__results"),[F,K]=(0,o.useState)(w),W=(0,o.useRef)(),G=(0,o.useRef)(),Y=(0,o.useRef)(null),B=(0,m.uY)(),[Q,V]=(0,m.S5)(),{keyboardProps:z}=(0,a.v5)({onKeyUp:e=>{let t=-1;if(27===e.keyCode)return j(!1),C(-1),O||E(),void(Y.current&&Y.current.focus());if(40===e.keyCode&&(t=_+1>=w?0:_+1,Q[t]&&Q[t].scrollIntoView({behavior:"smooth",block:"nearest",inline:"start"})),38===e.keyCode&&(t=_-1<0?w-1:_-1,Q[t]&&Q[t].scrollIntoView({behavior:"smooth",block:"nearest",inline:"start"})),13===e.keyCode){if(-1===_)return void N(!0);Q[_].click()}C(t),P(t),j(w>0)},onKeyDown:e=>(40===e.keyCode||38===e.keyCode||13===e.keyCode||27===e.keyCode?e.preventDefault():Y.current.focus(),!1)}),{focusWithinProps:H}=(0,a.L_)({onFocusWithin:()=>{j(w>0),U(!0)},onBlurWithin:()=>{j(!1)}});(0,o.useEffect)((()=>{const e=["autocomplete-concierge__results"];k&&!O&&F<w&&(e.push("autocomplete-concierge__results--expanding"),M(e.join(" "))),!k&&O&&F===w&&(e.push("autocomplete-concierge__results--open"),M(e.join(" "))),k||O||(e.push("autocomplete-concierge__results--open"),e.push("autocomplete-concierge__results--collapsing"),M(e.join(" ")))}),[k,F,w,O]),(0,o.useEffect)((()=>{const e=(0,m.jS)(document.location.href,"query");I(e||"")}),[]),(0,o.useEffect)((()=>{if(j(w>0),!A)return;const e=w>0?"".concat(w," results for ").concat(A):"No results found for ".concat(A);R(e),K(w)}),[w,A]),(0,o.useEffect)((()=>{const e=setTimeout((async()=>{""===A&&Y.current.focus(),await S(A,n)}),l);return()=>clearTimeout(e)}),[A]),(0,o.useEffect)((()=>{if(T&&W.current&&Y.current){if(Y.current.value=A,B){const e={TYPE:"SUBMIT",title:"NEEDS_REFRESH",url:window.location.href,time:Date.now()};return void B.trackedEventWithCb(e,W.current.submit())}W.current.submit()}}),[T]);const J=(e,t,r)=>{if(B){const o={TYPE:"CLICK",url:e,query:A,title:t};B.trackedEventWithCb(o,r)}r&&!B&&r()},X=(0,o.useCallback)(((e,t)=>{e.preventDefault();const{action:r,action_t:o,title:n}=t;if("Q"===o||void 0===o)return I(r||t),void N(!0);J(r,n,(()=>document.location.href=r))}),[]);return o.createElement("div",d({className:"autocomplete-concierge no-wysiwyg",role:"search"},H),o.createElement("form",{ref:W,action:u,method:f,className:"autocomplete-concierge__form"},o.createElement("label",{className:"sr-only","aria-live":"polite",id:"".concat(t,"-label")},L),b&&o.createElement(p,{fetching:k,onSubmit:()=>N(!0),componentId:t}),o.createElement("input",d({id:"".concat(t,"-inputField"),ref:Y,type:"text",autoComplete:"off",role:"combobox","aria-expanded":D&&O,"aria-haspopup":"grid","aria-labelledby":"".concat(t,"-label"),"aria-autocomplete":"list","aria-controls":"".concat(t,"-grid"),"aria-activedescendant":-1===x?void 0:x,onChange:e=>{let{currentTarget:{value:t}}=e;I(t)},onClick:()=>j(w>0),value:A,placeholder:c,className:"autocomplete-concierge__input",name:"query",onKeyDown:e=>{40===e.keyCode&&G.current.focus()}},v)),h&&h.map((e=>o.createElement("input",{key:e.id,type:"hidden",name:e.name,value:e.value}))),o.createElement("button",{type:"button",className:["autocomplete-concierge__submit",!y||y&&0===A.length?"hidden":""].join(" "),onClick:()=>I(""),onKeyUp:e=>{e.preventDefault(),13===e.keyCode&&I("")}},o.createElement("svg",{className:"svg-icon",role:"img",focusable:!1},o.createElement("title",null,"Clear search"),o.createElement("use",{href:"#close"})),"Clear"),g&&!b&&o.createElement("button",{type:"submit",className:"autocomplete-concierge__submit",onClick:()=>N(!0),"aria-labelledby":"".concat(t,"-submit-label")},o.createElement("svg",{className:"svg-icon",role:"img",focusable:!1},o.createElement("title",{id:"".concat(t,"-submit-label")},"Submit search"),o.createElement("use",{href:"#search"})))),o.createElement("div",d({ref:G,role:"grid","aria-labelledby":"".concat(t,"-label"),"aria-hidden":!O,id:"".concat(t,"-grid"),className:q,tabIndex:-1},z),n&&n.map(((e,t)=>(e=>{const{template:t}=e,n=t.toLowerCase(),c=(0,o.useMemo)((()=>(0,o.lazy)((()=>r(42276)("./".concat(n))))),[]);return o.createElement(o.Suspense,{key:"component-".concat(n),fallback:o.createElement("span",{className:"sr-only"},"Loading template...")},o.createElement(c,e))})({...e,templateId:t,handleClick:X,trackedClick:J,childRefs:V})))),o.createElement(s.U4,{onDismiss:()=>j(!1)}))}function h(e){const{adapters:t}=e,r=new l(t);return o.createElement(i.g,{initialState:u.E3,reducer:u.fG,autocompleteService:r},o.createElement(f,e))}const{string:v,arrayOf:g,shape:E,number:y,bool:b,func:C}=c();f.propTypes={id:v,templates:g(E({id:v,label:v,template:v,serviceUrl:v,params:v})).isRequired,placeholder:v,debounce:y,action:v,method:v,showSubmit:b,isOpen:b,onClose:C,showClear:b,showLoader:b},f.defaultProps={id:"autocomplete-search",placeholder:"Start your search here...",debounce:500,action:"search.html",method:"GET",showSubmit:!0,isOpen:!1,onClose:()=>{},showClear:!1,showLoader:!1}},6838:function(e,t,r){"use strict";r.d(t,{E3:function(){return l},Ix:function(){return u},fG:function(){return i}});const o="PNP/AUTOCOMPLETE/UPDATE_RESULTS",n="PNP/AUTOCOMPLETE/SET_SELECTED",c="PNP/AUTOCOMPLETE/LOAD_REQUEST",a="PNP/AUTOCOMPLETE/LOAD_FAILED",s="PNP/AUTOCOMPLETE/LOAD_SUCCESS",l={results:[],count:0,query:"",selectedIndex:-1,fetching:!1,error:""},i=function(){let e=arguments.length>0&&void 0!==arguments[0]?arguments[0]:l,t=arguments.length>1?arguments[1]:void 0;switch(t.type){case c:return{...e,fetching:!0};case a:return{...e,error:t.error,fetching:!1};case s:return{...e,fetching:!1};case o:return{...e,results:t.results,count:t.count,query:t.query,selectedIndex:-1};case n:return{...e,selectedIndex:t.selectedIndex};default:return{...e}}},u=(e,t)=>({updateResults:(t,r)=>{e({type:o,results:t,count:r})},setSelectedIndex:t=>{e({type:n,selectedIndex:t})},fetchResults:async r=>{if(!r)return void e({type:o,results:[],count:0});e({type:c});const{results:n,count:l,error:i}=await t.getResults(r);if(i)return console.error("There was an error fetching results from the service."),console.info(i.message),e({type:o,results:[],count:0}),void e({type:a,error:i.message});e({type:o,results:n,count:l,query:r}),e({type:s})}})},48131:function(e,t,r){"use strict";r.d(t,{g:function(){return s},o:function(){return a}});r(33948);var o=r(67294),n=r(6838);const c=(0,o.createContext)();c.displayName="PNP-STORE";const a=()=>(0,o.useContext)(c),s=e=>{let{children:t,initialState:r,reducer:a,autocompleteService:s}=e;const[l,i]=(0,o.useReducer)(a,r),u=(0,o.useMemo)((()=>(0,n.Ix)(i,s)),[]);return o.createElement(c.Provider,{value:{...u,dispatch:i,...l}},t)}},42276:function(e,t,r){var o={"./cemetery--v15":[98938,938],"./cemetery--v15.jsx":[98938,938],"./cemetery--v16":[97841,841],"./cemetery--v16.jsx":[97841,841],"./faqs--v15":[81524,524],"./faqs--v15.jsx":[81524,524],"./faqs--v16":[20080,80],"./faqs--v16.jsx":[20080,80],"./organic":[44113,113],"./organic.jsx":[44113,113],"./people--v15":[62140,140],"./people--v15.jsx":[62140,140],"./people--v16":[12507,507],"./people--v16.jsx":[12507,507],"./planning_applications--v15":[53298,298],"./planning_applications--v15.jsx":[53298,298],"./planning_applications--v16":[38504,504],"./planning_applications--v16.jsx":[38504,504],"./programs--v15":[86588,588],"./programs--v15.jsx":[86588,588],"./programs--v16":[32723,723],"./programs--v16.jsx":[32723,723],"./roadworks--v15":[75554,554],"./roadworks--v15.jsx":[75554,554],"./roadworks--v16":[54563,563],"./roadworks--v16.jsx":[54563,563],"./services--v15":[91362,362],"./services--v15.jsx":[91362,362],"./services--v16 ":[45542,542],"./services--v16 .jsx":[45542,542]};function n(e){if(!r.o(o,e))return Promise.resolve().then((function(){var t=new Error("Cannot find module '"+e+"'");throw t.code="MODULE_NOT_FOUND",t}));var t=o[e],n=t[0];return r.e(t[1]).then((function(){return r(n)}))}n.keys=function(){return Object.keys(o)},n.id=42276,e.exports=n}}]);
//# sourceMappingURL=AutocompleteProvider-dea5faaa7e7b5545582f.js.map