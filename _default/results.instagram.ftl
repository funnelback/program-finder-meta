<#ftl encoding="utf-8" output_format="HTML" />
<#-- 
    Presentation and logic to determine how each instagram result
    is to be presented in search results, shortlist and quickview.
-->

<#-- 
    Macro decides how each result should be presented. 

    @param result An individual result fron the data model
    @param view An uppercase string which represents how
        the result should be displayed. Defaults to List.
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
    <!-- results.instagram::GenericView -->
    <article class="listing-item listing-item--instagram listing-item--background-grey10 listing-item--color-black" data-fb-result="${(result.indexUrl)!}">

        <#switch result.listMetadata["instagramMediaType"]!?first!?upper_case>
            <#case "IMAGE">                
            <#case "CAROUSEL_ALBUM">
                <#if (result.listMetadata["instagramMediaUrl"]?first)!?has_content>
                    <div class="listing-item__image-wrapper">
                        <img class="deferred listing-item__image" alt="Thumbnail for ${result.title!}" src="//${httpRequest.getHeader('host')}/s/resources/${question.collection.id}/${question.profile}/img/pixel.gif" data-deferred-src="${(result.listMetadata["instagramMediaUrl"]?first)!}"> 
                    </div>  
                </#if>  
                <#break>
            <#case "VIDEO">
                <#if (result.listMetadata["instagramThumbnailUrl"]?first)!?has_content>
                    <div class="listing-item__image-wrapper">
                        <img class="deferred listing-item__image" alt="Thumbnail for ${result.title!}" src="//${httpRequest.getHeader('host')}/s/resources/${question.collection.id}/${question.profile}/img/pixel.gif" data-deferred-src="${(result.listMetadata["instagramThumbnailUrl"]?first)!}"> 
                    </div>  
                </#if>                  
                <#break>
            <#default>
                <#-- 
                    For showcases, show a placeholder if no image is found. 
                    For all other instances, do nothing in the default case.
                -->
                <#if ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE">
                    <div class="listing-item__image-wrapper">
                        <img class="listing-item__image" alt="Thumbnail for ${result.title!}" src="https://picsum.photos/300/300?sig=${(result.title)!''?url}">
                    </div>
                </#if>                
                <#break>                            
        </#switch>

        <#-- 
            Image - Note: Some APIs produces very long links. 
            Review the MBL (metadata buffer length) setting to 
            ensure that key fields are not truncated.
        -->
        <#if (result.listMetadata["instagramMediaUrl"]?first)!?has_content >
        <#elseif ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE">
            <div class="listing-item__image-wrapper">
                <img class="listing-item__image" alt="Thumbnail for ${result.title!}" src="https://picsum.photos/300/300?sig=${(result.title)!''?url}">
            </div>
        </#if>
        <div class="listing-item__content">
            <#-- Title -->
            <#if (result.listMetadata["author"]?first)!?has_content>
                <div class="listing-item__header">
                    <a 
                        href="${result.clickTrackingUrl!}" 
                        data-live-url="${result.liveUrl}" 
                        title="${result.title!}" 
                        class="listing-item__title-link"
                    >
                        <h3 class="listing-item__title">
                            <@s.boldicize>
                                <@s.Truncate length=180>
                                    @${(result.listMetadata["author"]?first)!} 
                                </@s.Truncate>
                            </@s.boldicize>
                        </h3>
                    </a>
                    
                    <#-- Subtitle -->
                    <#if (result.date)!?has_content>
                        <div class="listing-item__subtitle">
                            <time class="listing-item__time" datetime="${result.date?date?string.iso}" title="${result.date?date?string.medium}">
                                ${prettyTime(result.date?date)}
                            </time> 
                                <span class="fab fa-instagram " aria-hidden="true"></span>   
                                via                                              
                                instagram
                        </div>
                    </#if>
                </div>
            </#if>            
            
            <#-- Body -->
            <div class="listing-item__body">
                <#-- Summary -->
                <#if (result.listMetadata["instagramCaption"]?first)!?has_content>
                    <div class="listing-item__summary">
                        <@s.boldicize>
                            ${(result.listMetadata["instagramCaption"]?first)!?no_esc}
                        </@s.boldicize>                 
                    </div>
                </#if>

                <#-- Call to Action (CTA) -->                        
                <a href="${result.clickTrackingUrl!}" class="listing-item__action">VIEW POST</a>         
            </div>          

            <#-- Display the time which this result has last been visited by the user -->
            <@sessions.LastVisitedLink result=result/> 

            <#-- Footer -->                    
            <div class="listing-item__footer">
                <#if (result.listMetadata["instagramLikesCount"]?first)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <span class="search-results__icon--red far fa-eye" aria-label="Number of views"></span>
                        ${(result.listMetadata["instagramLikesCount"]?first)!}
                    </div>
                </#if>
                <#if (result.listMetadata["instagramCommentsCount"]?first)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <span class="search-results__icon--red far fa-comment" aria-label="Number of comments"></span>
                        ${(result.listMetadata["instagramCommentsCount"]?first)!}
                    </div>
                </#if>                
            </div>                                        
        </div>
    </article>     
</#macro>