<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
	Macro decides how each result should be presented. 

	@param result An individual result fron the data model
	@param view An uppercase string which represents how
		the result should be displayed. Defaults to DETAILED.
-->
<#macro Result result=result view="LIST">
	<#switch view?upper_case>
		<#case "CARD">
			<@CardView result=result />
			<#break>
		<#case "LIST">
			<#-- Determine if results should be hidden or not -->
			<@ListView result=result />
			<#break>
		<#default>
			<@ListView result=result />
	</#switch>
</#macro>

<#--
	Stardard view of a result which is to be displayed in the 
	main section of the search engine result page (SERP)
	@param result An individual result fron the data model
-->
<#macro ListView result>
	<@GenericView result=result cardClass="fb-card--list" />
</#macro>

<#--
	Card view of a result which is to be displayed in the 
	main section of the search engine result page (SERP)
	@param result An individual result fron the data model
-->
<#macro CardView result>
	<@GenericView result=result cardClass="fb-card--fixed" />
</#macro>

<#--
	A generic view used to drive both the the list and card view
	@param result An individual result fron the data model
-->
<#macro GenericView result cardClass="fb-card--fixed">
    <article class="search-results__item">
        <#if (result.listMetadata["courseImage"]?first)!?has_content>
            <figure class="search-results__bg">
                <img src="${(result.listMetadata["courseImage"]?first)!}" alt="${result.title!}"/>
            </figure>
        <#else>
            <figure class="search-results__bg">
                <img src="https://source.unsplash.com/random/335x192?${(result.title)!''?url}" alt="${result.title!}"/>
            </figure>
        </#if>
        <div class="search-results__content">
            <h3 class="search-results__title">
                <a href="${result.clickTrackingUrl!}" class="search-results__link">
                    ${result.title!}
                </a>
            </h3>
            <p class="search-results__desc">
                <#if (result.listMetadata["c"]?first)!?has_content>
                    ${(result.listMetadata["c"]?first)!}
                <#else>
                    ${result.summary!}
                </#if>
            </p>
            <div class="search-results__bottom">
                <span class="search-results__info search-results__info--icon search-results__info--icon-list">
                    <#if (result.listMetadata["stencilsProgramID"]?first)!?has_content>ID ${(result.listMetadata["stencilsProgramID"]?first)!} - </#if><#if (result.listMetadata["stencilsProgramCredentialName"]?first)!?has_content>${(result.listMetadata["stencilsProgramCredentialName"]?first)!?split("|")?join(", ")}</#if>
                </span>
                <span class="search-results__info search-results__info--icon search-results__info--icon-list">
                    <#local hasPrev = false>
                    <#if ((result.listMetadata["stencilsProgramCredits"]?first)!"0") != "0">
                        ${(result.listMetadata["stencilsProgramLengthYears"]?first)!} credits
                    </#if>
                    <#if ((result.listMetadata["stencilsProgramLengthYears"]?first)!"0") != "0">
                        <#if hasPrev>, </#if>
                        ${(result.listMetadata["stencilsProgramLengthYears"]?first)!} years
                        <#local hasPrev = true>
                    </#if>
                    <#if ((result.listMetadata["stencilsProgramLengthMonths"]?first)!"0") != "0">
                        <#if hasPrev>, </#if>
                        ${(result.listMetadata["stencilsProgramLengthMonths"]?first)!} months
                        <#local hasPrev = true>
                    </#if>
                    <#if ((result.listMetadata["stencilsProgramLengthWeeks"]?first)!"0") != "0">
                        <#if hasPrev>, </#if>
                        ${(result.listMetadata["stencilsProgramLengthWeeks"]?first)!} weeks
                    </#if>
                    <#if ((result.listMetadata["stencilsProgramLengthVaries"]?first)!"false") == "true">
                        Variable length
                    </#if>
                </span>
                <div class="search-results__compare">
                    <input type="checkbox" id="compare${result.rank!}" name="compare${result.rank!}" value="Compare Program">
                    <label class="compare-button" data-url="${result.liveUrl!}" for="compare${result.rank!}">Compare Program</label>
                </div>
            </div>
        </div>
    </article>
</#macro>



<#macro AutoCompleteTemplate>
    <#-- 
        Even though this template is for a "program", we still need to call it a "course"
        The css framework currently assumes that the second channel resides under 
        tt-dataset-courses.


    -->
    <script id="auto-completion-courses" type="text/x-handlebar-template">
        <div class="module-search__list-item">
            <a href="#" class="module-search__list-link" style="background-image: url('https://source.unsplash.com/random/335x192?{{extra.disp.title}};">
                <span class="module-search__list-text">
                    {{extra.disp.title}}
                    <span class="module-search__list-more">Learn More</span>
                </span>
            </a>
        </div>
    </script>
</#macro>