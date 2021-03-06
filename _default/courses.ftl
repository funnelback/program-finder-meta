<#ftl encoding="utf-8" output_format="HTML" />
<#-- Contains all the presentation logic for Courses -->

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
    <!-- courses.GenericView -->
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
                <button class="search-results__link js-quick-link" data-target="#${base.getCssID(result.liveUrl)}">
                    <@s.Truncate length=100>
                        ${result.title!}
                    </@s.Truncate>
                </button>
            </h3>
            <p class="search-results__desc">
                <@s.boldicize>
                    <@s.Truncate length=170>
                        <#if (result.listMetadata["c"]?first)!?has_content>
                            ${(result.listMetadata["c"]?first)!}                            
                        <#else>
                            ${result.summary!}
                        </#if>
                    </@s.Truncate>
                </@s.boldicize> 
            </p>
            <div class="search-results__bottom">
                <span class="search-results__info search-results__info--icon search-results__info--icon-list">
                    <#if (result.listMetadata["stencilsDeliveryMethod"]?first)!?has_content>Delivery: ${(result.listMetadata["stencilsDeliveryMethod"]?first)!}</#if>
                </span>
                <span class="search-results__info search-results__info--icon search-results__info--icon-list">
                    <#if (result.listMetadata["courseCredit"]?first)!?has_content>${(result.listMetadata["courseCredit"]?first)!}</#if>
                </span>
            </div>
        </div>
    </article>
</#macro>

<#-- 
    Output the template used in the quick view. Quick view
    allows the user view more information about a particular
    document without them having to leave the search results page.
    This aims to minimise the amount of hopping back and forth 
    between systems.
-->
<#macro QuickView result> 
    <!-- courses.QuickViewTempplate -->
    <dialog id="${base.getCssID(result.liveUrl)}" 
            class="quick-view js-quick-view invisible" 
            role="dialog"
            aria-labelledby="${base.getCssID(result.liveUrl)}-course-label"
            aria-describedby="${base.getCssID(result.liveUrl)}-course-desc"
            aria-modal="true">
        <button class="quick-view__close"><span class="sr-only">close</span></button>
        <div class="quick-view__wrapper">
            <div class="quick-view__content">
                <h2 class="quick-view__title" id="${base.getCssID(result.liveUrl)}-course-label">
                    ${result.title!}          
                </h2>
                <p class="quick-view__desc" id="${base.getCssID(result.liveUrl)}-course-desc">
                    <#if (result.listMetadata["c"]?first)!?has_content>
                        ${(result.listMetadata["c"]?first)!}
                    <#else>
                        ${result.summary!}
                    </#if>
                </p>
                <div class="quick-view__details">
                    <h3 class="quick-view__details-title">Program details</h3>

                    <div class="quick-view__details-content">
                        <#--  
                            <p>
                                Insert more information
                            </p>
                            <p>
                                Insert even more information
                            </p>  
                        -->
                        <dl>
                            <#if (result.listMetadata["programCredentialType"]?first)!?has_content>
                                <dt>Credential type:</dt>
                                <dd>${(result.listMetadata["programCredentialType"]?first)!} </dd>
                            </#if>                    
                            <#if ((result.listMetadata["courseCredit"]?first)!"0") != "0">
                                <dt>Credits:</dt>
                                <dd>${(result.listMetadata["courseCredit"]?first)!} credits</dd>
                            </#if>                    
                            <#if (result.listMetadata["programCampus"]?first)!?has_content>
                                <dt>Campus:</dt>
                                <dd>${(result.listMetadata["programCampus"]?first)!} </dd>
                            </#if>
                            <#if (result.listMetadata["stencilsDeliveryMethod"]?first)!?has_content >
                                <dt>Delivery method:</dt>
                                <dd>${(result.listMetadata["stencilsDeliveryMethod"]?first)!} </dd>
                            </#if>
                            <#if (result.listMetadata["programLengthYears"]?first)!?has_content &&
                                ((result.listMetadata["programLengthYears"]?first)!"0") != "0">
                                <dt>Duration:</dt>
                                <dd>${(result.listMetadata["programLengthYears"]?first)!} years</dd>
                            </#if>                                                                              
                            <#if (result.listMetadata["programFaculty"]?first)!?has_content >
                                <dt>Faculty:</dt>
                                <dd>${(result.listMetadata["programFaculty"]?first)!} </dd>
                            </#if>                                                  
                            <#if (result.listMetadata["stencilsDepartment"]?first)!?has_content >
                                <dt>Department:</dt>
                                <dd>${(result.listMetadata["stencilsDepartment"]?first)!} </dd>
                            </#if>                                                  
                            <#if (result.listMetadata["programStatus"]?first)!?has_content >
                                <dt>Status:</dt>
                                <dd>${(result.listMetadata["programStatus"]?first)!} </dd>
                            </#if>                                                  
                            <#if (result.listMetadata["courseCode"]?first)!?has_content >
                                <dt>Code:</dt>
                                <dd>${(result.listMetadata["courseCode"]?first)!} </dd>
                            </#if>
                            <#if (result.listMetadata["courseNumber"]?first)!?has_content >
                                <dt>Number:</dt>
                                <dd>${(result.listMetadata["courseNumber"]?join(", "))!} </dd>
                            </#if>
                            <#if (result.listMetadata["programLength"]?first)!?has_content >
                                <dt>Length:</dt>
                                <dd>${(result.listMetadata["programLength"]?first)!} </dd>
                            </#if>
                            <#if (result.listMetadata["stencilsTermCodes"]?first)!?has_content >
                                <dt>Term codes:</dt>
                                <dd>${(result.listMetadata["stencilsTermCodes"]?join(", "))!} </dd>
                            </#if>             
                        </dl>
                        <a href="${result.clickTrackingUrl!}" class="btn" data-target="#${base.getCssID(result.liveUrl)}">
                            Visit program page
                        </a>                    
                    </div>
                </div>
            </div>
            <#-- TODO: Add related results -->
        </div>
    </dialog>    
</#macro>