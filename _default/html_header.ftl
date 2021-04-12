<#ftl encoding="utf-8" output_format="HTML" />

<link rel="stylesheet" href="/s/resources/${question.collection.id}/${question.profile}/css/customer.css">
<link rel="stylesheet" href="/s/resources/${question.collection.id}/${question.profile}/css/customer-typeahead.css">

<#-- 
    Polyfills for Internet Explorer 11 can go below 

    Ensure that these have the `nomodule` attribute so that
    modern browsers ignore them and don't incur the parsing
    and loading cost.
-->

<#-- 
    NodeList.prototype.forEach
    https://developer.mozilla.org/en-US/docs/Web/API/NodeList/forEach

    Object.entries
    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/entries
 -->
<script nomodule>
if (window.NodeList && !NodeList.prototype.forEach) {
    NodeList.prototype.forEach = function (callback, thisArg) {
        thisArg = thisArg || window;
        for (var i = 0; i < this.length; i++) {
            callback.call(thisArg, this[i], i, this);
        }
    };
}
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
</script>
