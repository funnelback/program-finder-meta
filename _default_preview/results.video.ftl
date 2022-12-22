<#ftl encoding="utf-8" output_format="HTML" />
<#-- 
    Contains the default presentation logic for a 
    document which is not configured with its own 
    markup. 
-->

<#-- 
    Macro decides how each result should be presented. 

    @param result An individual result fron the data model
    @param view An uppercase string which represents how
        the result should be displayed. Defaults to LIST.
-->
<#macro Result result view="LIST">
    <#switch view?upper_case>
        <#case "CARD">
            <@CardView result=result />
            <#break>
        <#case "LIST">
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
    <@GenericView result=result />
</#macro>

<#--
    Card view of a result which is to be displayed in the 
    main section of the search engine result page (SERP)
    @param result An individual result fron the data model
-->
<#macro CardView result>
    <@GenericView result=result />
</#macro>

<#--
    A generic view used to drive both the the list and card view
    @param result An individual result fron the data model
-->
<#macro GenericView result>
    <!-- results.video::GenericView -->
    <article class="listing-item listing-item--video listing-item--background-grey10 listing-item--color-black" data-fb-result="${(result.indexUrl)!}">
        <#if (result.listMetadata["image"]?first)!?has_content >
            <div class="listing-item__image-wrapper">
                <img class="deferred listing-item__image" alt="Thumbnail for ${result.title!}" src="//${httpRequest.getHeader('host')}/s/resources/${question.collection.id}/${question.profile}/img/pixel.gif" data-deferred-src="${(result.listMetadata["image"]?first)!}"> 
            </div>  
        <#elseif ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE">
            <div class="listing-item__image-wrapper">
                <img class="listing-item__image" alt="Thumbnail for ${result.title!}" src="https://picsum.photos/300/300?sig=${(result.title)!''?url}">
            </div>
        </#if>
        <div class="listing-item__content">
            <#-- Title -->
            <#if (result.title)!?has_content>
                <div class="listing-item__header">
                    <a 
                        href="${result.clickTrackingUrl!}" 
                        data-live-url="${result.liveUrl}" 
                        title="${result.title!}" 
                        class="listing-item__title-link"
                    >
                        <h3 class="listing-item__title">
                            <@s.boldicize>
                                <@s.Truncate length=90>
                                    ${(result.title)!} 
                                </@s.Truncate>
                            </@s.boldicize>
                        </h3>
                    </a>

                    <#-- Pretty version of the url of the document -->
                    <cite class="listing-item__subtitle listing-item__subtitle--highlight">
                        <@s.Truncate length=90>
                            ${(result.displayUrl)!}
                        </@s.Truncate>                
                    </cite>
                </div>
            </#if>            
            
            <#-- Body -->
            <div class="listing-item__body">
                <#-- Summary -->
                <div class="listing-item__summary">
                    <@s.boldicize>
                        ${result.summary!?no_esc}
                    </@s.boldicize>
                </div>

                <#-- Metadata should as tags/pills -->
                <#list result.listMetadata["videoCategory"]![]>
                    <ul aria-label="Result tags" class="listing-item__tags">
                        <#items as category>                                                        
                            <li class="listing-item__tag">                       
                                ${category!}
                            </li>
                        </#items>
                    </ul>
                </#list>                   

                <#-- Call to Action (CTA) -->                        
                <a href="${result.clickTrackingUrl!}" class="listing-item__action">VIEW VIDEO</a> 
            </div>          

            <#-- Display the time which this result has last been visited by the user -->
            <@sessions.LastVisitedLink result=result/> 

            <#-- Footer -->                    
            <div class="listing-item__footer">
                <#if (result.listMetadata["videoDurationPretty"]?first)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <svg class="svg-icon listing-item__icon">
                            <title>Duration</title>
                            <use href="#time">
                            </use>
                        </svg>
                        ${(result.listMetadata["videoDurationPretty"]?first)!}
                    </div>
                <#elseif (result.listMetadata["videoDuration"]?first)!?has_content>                    
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <svg class="svg-icon listing-item__icon">
                            <title>Duration</title>
                            <use href="#time">
                            </use>
                        </svg>
                        ${(result.listMetadata["videoDuration"]?first)!} 
                    </div>
                </#if>

                <#if (result.listMetadata["videoViewCount"]?first)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <span class="far fa-eye" aria-label="Number of views"></span>
                        ${(result.listMetadata["videoViewCount"]?first)!} 
                    </div>
                </#if>

                <#if (result.date?date?string.short)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        ${(result.date?date?string.short)!} - Uploaded by ${(result.listMetadata["videoAuthor"]?first)!"Unknown"}
                    </div>
                </#if>
            </div>                                        
        </div>
    </article>     
</#macro>
