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
    <!-- results.facebook.posts::GenericView -->
    <article class="listing-item listing-item--promoted listing-item--background-grey10 listing-item--color-black" data-fb-result="${(result.indexUrl)!}">
        <#if (result.listMetadata["stencilsFacebookProfileUrl"]?first)!?has_content >
            <div class="listing-item__image-wrapper">
                <img class="deferred" alt="Thumbnail for ${result.title!}" src="//${httpRequest.getHeader('host')}/s/resources/${question.collection.id}/${question.profile}/img/pixel.gif" data-deferred-src="${(result.listMetadata["stencilsFacebookProfileUrl"]?first)!}"> 
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
                    
                    <#-- Subtitle -->
                    <#if (result.listMetadata["stencilsFacebookPageCity"]?first)!?has_content>
                        <div class="listing-item__subtitle">
                            ${result.date?date?string("MMMM dd, yyyy")} via 

                            <span
                                class="
                                listing-item__subtitle-block
                                listing-item__subtitle-block--highlight
                                "
                            >
                                <svg aria-hidden="true" class="svg-icon">
                                <use href="#logo-facebook"></use>
                                </svg>
                                via facebook
                            </span>                                
                        </div>
                    </#if>
                </div>
            </#if>            
            
            <#-- Body -->
            <div class="listing-item__body">
                <#-- Summary -->
                <div class="listing-item__summary">
                    ${(response.customData.stencilsMethods.linkify(result.listMetadata["c"]?first!))!?no_esc}
                </div>

                <#-- 
                    It is common that users share links as posts which we have called a post link. 
                    This section displays the link which is associated with the facebook posts.
                -->
                <#if (result.listMetadata["stencilsFacebookPostLink"]?first)!?has_content>
                    <div class="facebook-post__post-link"> 
                        <#if (result.listMetadata["image"]?first)!?has_content>
                            <img class="deferred post-link__img" alt="Thumbnail for ${result.title!}" src="//${httpRequest.getHeader('host')}//s/resources/${question.collection.id}/${question.profile}/img/pixel.gif" data-deferred-src="${(result.listMetadata["image"]?first)!}"> 
                        </#if>

                        <#-- Title of the link -->
                        <div class="search-results__sub-title post-link__sub-title">
                            <a href="${(result.listMetadata["stencilsFacebookPostLink"]?first)!}" class="search-results__link">
                                <@s.boldicize>
                                    <@s.Truncate length=90>
                                        ${(result.listMetadata["stencilsFacebookPostLinkName"]?first)!}
                                    </@s.Truncate>
                                </@s.boldicize>
                            </a>
                        </div>                    
                        
                        <#-- Description / summary of the link -->
                        <#if (result.listMetadata["stencilsFacebookPostLinkDescription"]?first)!?has_content>
                            <div class="search-results__desc post-link__sub-description">
                                <@s.boldicize>
                                    <@s.Truncate length=120>
                                        ${(result.listMetadata["stencilsFacebookPostLinkDescription"]?first)!}
                                    </@s.Truncate>
                                </@s.boldicize>
                            </div>
                        </#if>
                    </div>
                </#if>
            </div>          

            <#-- Display the time which this result has last been visited by the user -->
            <@sessions.LastVisitedLink result=result/> 

            <#-- Footer -->                    
            <div class="listing-item__footer">
                <#if (result.listMetadata["stencilsFacebookProfileUrl"]?first)!?has_content>
                    <a
                        href="${result.listMetadata["stencilsFacebookProfileUrl"]?first!}"
                        class="listing-item__footer-block
                            listing-item__footer-block--highlight"
                    >                        
                        By
                        ${result.listMetadata["stencilsFacebookProfileUrl"]?first!}
                    </a>                
                </#if>
            </div>                                        
        </div>
    </article>     
</#macro>

<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->