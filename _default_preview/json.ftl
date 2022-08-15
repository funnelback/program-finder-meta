<#ftl encoding="utf-8" />

<#--
  A whitelist of fields/keys which are allowed to appear in the
  JSON. Edit this to include or exclude fields from the resulting JSON.

  Please note that the current version of this script has very basic logic
  and does not support the no concept of heirarchy.

  i.e. Adding "name" will cause ALL occurences of "name" to appear (provided
  that their parent fields/keys are also included).

  ToDo:
    - Add the ability to whitelist based on location in the data model
-->
<#assign WHITELIST =[
    "resultPacket"
    <#-- Query -->
    "query"
    "queryAsProcessed"
    "queryRaw"
    "queryCleaned"
    <#-- Result summary -->
    "resultsSummary"
    "fullyMatching"
    "collapsed"
    "partiallyMatching"
    "totalMatching"
    "estimatedCounts"
    "carriedOverFtd"
    "totalDistinctMatchingUrls"
    "numRanks"
    "currStart"
    "currEnd"
    "prevStart"
    "nextStart"
    "totalSecurityObscuredUrls"
    "anyUrlsPromoted"
    "resultDiversificationApplied"
    <#-- Results -->
    "results"
    "rank"
    "score"
    "title"
    "collection"
    "component"
    "liveUrl"
    "summary"
    "cacheUrl"
    "date"
    "fileSize"
    "fileType"
    "tier"
    "listMetadata"
    "customData"
    "docNum"
    "exploreLink"
    "kmFromOrigin"
    "quickLinks"
    "displayUrl"
    "clickTrackingUrl"
    "explain"
    "indexUrl"
    "documentVisibleToUser"    
    <#-- Metadata values -->
    "listMetadata"
    "image"
    <#-- Spelling suggestions -->
    "spell"
    <#-- Best bets -->
    "bestBets"
    <#-- Contextual navigation -->
    "contextualNavigation"
    <#-- Faceted navigation - Facet -->
    "facets"
    "name"
    "unselectAllUrl"
    "selectionType"
    "constraintJoin"
    "order"
    "facetValues"
    "guessedDisplayType"
    <#-- Faceted navigation - Facet categories -->
    "categories"
    "label"
    "queryStringParam"
    "values"
    "data"
    "count"
    "queryStringParam"
    "selected"
    "toggleUrl"
    "selectUrl"
    "constraint"
    "facetExtras"
    "unselectAllFacetsUrl"
    "hasSelectedNonTabFacets"
    "hasNonTabFacets"
    "allValues"
    <#-- Curator -->
    "curator"
    "exhibits"
    "titleHtml"
    "displayUrl"
    "linkUrl"
    "descriptionHtml"
    "additionalProperties"
    "category"
    "messageHtml"
  ]>

<#-- Append the callback variable if it exists -->
<#macro Callback>
   <#if (question.inputParameters["callback"]?first)!?has_content>
      ${question.inputParameters["callback"]?first?json_string} (<#nested>)
   <#else>
      <#nested>
   </#if>
</#macro>

<#-- Process a node (object in the datamodel) and prints the JSON equivalent -->
<#macro ProcessNode fields node>
  <#if node!?is_method>
    <#-- ignore -->
  <#elseif node!?is_sequence || node!?is_enumerable>
    <#-- Arrays -->
    <@SequenceToJSON fields node />
  <#elseif node!?is_hash || node!?is_hash_ex>
    <#--
      Note: Need to ensure that this test appears above the test for strings
      as hashes are also treated as strings.
    -->
    <#if (node)!?has_content && node.getClass?is_method && node.getClass().isEnum?is_method && node.getClass().isEnum()>
      <#--
        Unfortuantely, enumerations are also considered hashes which when
        processed normally, looks like:

        selectionType : {
          name: "SINGLE"
          value: "SINGLE"
        }

        Custom code has been added to print enumations the following instead:

        selectionType : "SINGLE"
      -->
      <@EnumToJSON node />
    <#else>
      <@HashToJSON fields node />
    </#if>
  <#elseif node!?is_number>
    <@NumberToJSON node />
  <#elseif node!?is_string>
    <@StringToJSON node />
  <#elseif node!?is_boolean>
    <@BooleanToJSON node />
  <#elseif node!?is_date>
    <@DateToJSON node />
  <#else>
    <#-- Do nothing for everything else -->
    <#--
      is_collection
      is_method
      is_macro
      is_function
    -->
  </#if>
</#macro>

<#--
  Print out a hash as JSON
-->
<#macro HashToJSON whitelist hash>
  {
    <#assign result>
    <#--
      Loop through hash and only output the fields which are
      found in the whitelist
    -->
    <#list hash?keys?sort as key>
      <#if whitelist?seq_contains(key)>
        <#-- Cater for the scenario that the key is found but has the value of "null" -->
        <#if hash[key]?? == false>
          "${key?json_string}" : null,
        <#else>
          "${key?json_string}" : <@ProcessNode whitelist hash[key] />,
        </#if>
      </#if>
    </#list>
    </#assign>
    <#-- remove the trailing/last comma to ensure the json is valid -->
    ${result?keep_before_last(",")}
  }
</#macro>

<#--
  Print out a squence/array as JSON
-->
<#macro SequenceToJSON whitelist sequence>
  [
    <#list sequence as item>
      <#if item!?has_content>
         <@ProcessNode whitelist item /><#if item?has_next>,</#if>
      </#if>
    </#list>
  ]
</#macro>

<#--
  Print out a number as JSON
-->
<#macro NumberToJSON value>
  ${value!?c}
</#macro>

<#--
  Print out a string as JSON
-->
<#macro StringToJSON value>
  "${value!?json_string}"
</#macro>

<#--
  Print out a boolean as JSON
-->
<#macro BooleanToJSON value>
  ${value?c}
</#macro>

<#--
  Print out a date as JSON
-->
<#macro DateToJSON value>
  "${value?string('yyyy-MM-dd')}"
</#macro>

<#--
  Print out a enum as JSON
-->
<#macro EnumToJSON value>
  "${value}"
</#macro>

<#--
  Output the required nodes as JSON.
  This can be customised to print out the question, extra searches or facets.
-->
<@compress single_line=true>
  <@Callback>
    { "response" : <@ProcessNode WHITELIST response.resultPacket /> }
  </@Callback>
</@compress>