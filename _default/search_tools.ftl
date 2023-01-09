<#-- 
    Generate the HTML for advanced features which control the search results such as 
    sorting and number of results to display
-->
<#macro SearchTools>
    <#-- search_tools::SearchTools-->
    <div class="stencils-summary-and-search-tools">
        <@counts.Counts /> 
        <form
            action="${question.getCurrentProfileConfig().get("ui.modern.search_link")}" 
            method="GET"
            class="search-tools form custom-form custom-form--bg-white custom-form--color-black"
            data-pnp-component="stencils-search-tools"
        >
        <input type="hidden" name="collection" value="${question.collection.id}">

            <@base.inputsForForms allowList= ["enc", "form", "scope", "lang", "profile", "userType", "displayMode", "query"] />

            <#list question.selectedCategoryValues?keys as facetKey>
                <#list question.selectedCategoryValues[facetKey] as value>
                    <input type="hidden" name="${facetKey}" value="${value}">
                </#list>
            </#list>

            <@LimitDropdown />
            <@SortDropdown />
            <@DisplayMode />                    
            <button type="submit" class="sr-only">
                Submit
            </button>
        </form>           
    </div>
</#macro>

<#--
  Generate an HTML drop-down to control the number of results

  @param limits Array of number of results to provide (defaults to 10, 20, 50)
-->
<#macro LimitDropdown limits=[10, 20, 50, 100]>
    <!-- search_tools.LimitDropdown -->
    <div class="sq-form-question sq-form-question-select">
        <label class="sq-form-question-title sr-only" for="search-tools__results-per-page">Results per page:</label>
        <div class="sq-form-question-answer">
            <select name="num_ranks" class="sq-form-field" id="search-tools__results-per-page">
                <#list limits as limit>
                    <#if ((question.inputParameters["num_ranks"]?first?number)!0) == limit>
                        <#-- Selected case -->
                        <option value="${limit}" selected>${limit}</option>
                        <#--  <a class="dropdown-list__list-link" title="Limit to ${limit} results" href="${question.collection.configuration.value("ui.modern.search_link")}?${removeParam(QueryString, "num_ranks")}&num_ranks=${limit}">  -->
                    <#else>
                        <#-- Unselected case -->
                        <option value="${limit}">${limit}</option>
                    </#if>
                </#list>
            </select>
        </div>
    </div>
</#macro>

<#--
  Generate an HTML drop-down for sorting results

  @param options Map of sort options, where keys are the `sort` paratmeter (e.g. `date`) and values the label (e.g. `Date (Newest first)`)
-->
<#macro SortDropdown options={
  "": "Relevance",
  "date": "Date (Newest first)",
  "adate": "Date (Oldest first)",
  "title": "Title (A-Z)",
  "dtitle": "Title (Z-A)",
  "prox": "Distance",
  "url": "URL (A-Z)",
  "durl": "URL (Z-A)",
  "shuffle": "Shuffle"} >
    <!-- search_tools.SortDropdown -->
    <div class="sq-form-question sq-form-question-select">
        <label class="sq-form-question-title sr-only" for="search-tools__sort">Results per page:</label>
        <div class="sq-form-question-answer">
            <select name="sort" class="sq-form-field" id="search-tools__sort">
                <#list options as key, value>
                    <#if ((options[question.inputParameters["sort"]?first])!"") == value>
                        <#-- Selected case -->
                        <option value="${key}" selected>${value}</option>
                    <#else>
                        <#-- Unselected case -->
                        <option value="${key}">${value}</option>
                    </#if>
                </#list>
            </select>
        </div>
    </div>    
</#macro>

<#-- Obtain the result mode from the CGI paramters; Valid values are LIST and CARD -->
<#function getDisplayMode question>
    <#-- Default the display mode to "list" -->
    <#assign displayMode = ""> 

    <#-- Get the mode that is currently configured -->
    <#if (question.inputParameters["displayMode"]?first)!?has_content>
        <#-- Get the value from the user's selection -->
        <#assign displayMode = question.inputParameters["displayMode"]?first!?upper_case>    
    <#elseif (question.getCurrentProfileConfig().get("stencils.results.display_mode."+ response.customData.stencils.tabs.selected))!?has_content>
        <#-- Get the value from the profile config to see if a default has been specified from tabs. -->
        <#assign displayMode = question.getCurrentProfileConfig().get("stencils.results.display_mode."+ response.customData.stencils.tabs.selected)!?upper_case>
    <#elseif (question.getCurrentProfileConfig().get("stencils.results.display_mode"))!?has_content>
        <#-- Get the value from profile config -->
        <#assign displayMode = question.getCurrentProfileConfig().get("stencils.results.display_mode")!?upper_case>
    <#else>
        <#-- Default -->
        <#assign displayMode = "LIST"> 
    </#if>

    <#return displayMode>
</#function>

<#--
    Runs the best code when the specified display mode is selected.
-->
<#macro IsDisplayMode mode="LIST">
    <#if getDisplayMode(question) == mode!?upper_case>
        <#nested> 
    </#if>
</#macro>

<#--
    Show the various display mode options to the user
-->
<#macro DisplayMode>
    <!-- search_tools.DisplayMode -->
    <div class="search-tools__button-group">
        <#-- Card view -->
        <a 
            class="search-tools__button <#if getDisplayMode(question) != 'CARD'>search-tools__button--inactive</#if>" 
            title="Card view"
            href='${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, "displayMode")}&displayMode=card' 
        >
            <svg class="svg-icon search-tools__icon">
                <use href="#grid-view"></use>
            </svg>
        </a>
        
        <#-- List view -->
        <a 
            class="search-tools__button <#if getDisplayMode(question) != 'LIST'>search-tools__button--inactive</#if>" 
            title="List view" 
            href='${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, "displayMode")}&displayMode=list'>
            <svg class="svg-icon search-tools__icon">
                <use href="#list-view"></use>
            </svg>
        </a>
    </div>    
</#macro>