<#ftl encoding="utf-8" output_format="XML" />

<#--
    A whitelist of fields/keys which are allowed to appear in the
    XML. Edit this to include or exclude fields from the resulting XML.

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
    <#-- 
      Metadata values - Add the list of metadata which should be exposed
      in the json.
    -->
    "author"
    "keyword"
    "yourMetadata"
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

<#-- Process a node (object in the datamodel) and prints the XML equivalent -->
<#macro ProcessNode fields node>
    <#if node!?is_method>
        <#-- Ignore methods -->
    <#elseif node!?is_sequence || node!?is_enumerable>
        <#-- Arrays -->
        <@SequenceToXML fields node />
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
            <@EnumToXML node />
        <#else>
            <@HashToXML fields node />
        </#if>
    <#elseif node!?is_number>
        <@NumberToXML node />
    <#elseif node!?is_string>
        <@StringToXML node />
    <#elseif node!?is_boolean>
        <@BooleanToXML node />
    <#elseif node!?is_date>
        <@DateToXML node />
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
    Print out a hash as XML
-->
<#macro HashToXML whitelist hash>
    <#--
        Loop through hash and only output the fields which are
        found in the whitelist
    -->
    <#list hash?keys?sort as key>
        <#if whitelist?seq_contains(key)>
            <#-- Cater for the scenario that the key is found but has the value of "null" -->
            <#if hash[key]?? == false>
                <${key!}></${key!}>
            <#else>
                <${key!}><@ProcessNode whitelist hash[key] /></${key!}>
            </#if>
        </#if>
    </#list>
</#macro>

<#--
    Print out a squence/array as JSON
-->
<#macro SequenceToXML whitelist sequence >
    <#list sequence as item>
        <#if item!?has_content>
            <element><@ProcessNode whitelist item /></element>
        </#if>
    </#list>
</#macro>

<#--
    Print out a number as XML
-->
<#macro NumberToXML value>${value!?c}</#macro>

<#--
    Print out a string as XML
-->
<#macro StringToXML value>${value!}</#macro>

<#--
    Print out a boolean as XML
-->
<#macro BooleanToXML value>${value!?c}</#macro>

<#--
    Print out a date as XML
-->
<#macro DateToXML value>${value!?string('yyyy-MM-dd')}</#macro>

<#--
    Print out a enum as XML
-->
<#macro EnumToXML value>${value!}</#macro>

<#--
    Output the required nodes as XML
    This can be customised to print out the question and extra searches
-->
<@compress single_line=true>
    <?xml version="1.0" encoding="UTF-8" standalone="no" ?>
    <data> 
        <@ProcessNode WHITELIST response.resultPacket.results />
    </data>
</@compress>