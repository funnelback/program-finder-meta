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
        <#if (result.listMetadata["stencilsProgramCredentialName"]?first)!?has_content>
            <figure class="search-results__bg">
                <img src="${(result.listMetadata["stencilsProgramCredentialName"]?first)!}" alt="${result.title!}"/>
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
                <#if (result.listMetadata["stencilsCourseDesc"]?first)!?has_content>
                    ${(result.listMetadata["stencilsCourseDesc"]?first)!}
                <#else>
                    ${result.summary!}
                </#if>
            </p>
            <div class="search-results__bottom">
                <span class="search-results__info search-results__info--icon search-results__info--icon-list">
                    <#if (result.listMetadata["stencilsCourseDepartment"]?first)!?has_content>Department: ${(result.listMetadata["stencilsCourseDepartment"]?first)!}</#if>
                </span>
                <span class="search-results__info search-results__info--icon search-results__info--icon-list">
                    <#if (result.listMetadata["stencilsCourseDelivery"]?first)!?has_content>Delivery: ${(result.listMetadata["stencilsCourseDelivery"]?first)!}</#if>
                </span>
                <span class="search-results__info search-results__info--icon search-results__info--icon-list">
                    <#if (result.listMetadata["stencilsCourseCredit"]?first)!?has_content>${(result.listMetadata["stencilsCourseCredit"]?first)!}</#if>
                </span>
            </div>
        </div>
    </article>
</#macro>
