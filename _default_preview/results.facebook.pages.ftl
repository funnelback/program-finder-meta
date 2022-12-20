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
    <!-- results.facebook.pages::GenericView -->
    <article class="listing-item listing-item--promoted listing-item--background-grey10 listing-item--color-black" data-fb-result="${(result.indexUrl)!}">
        <#if (result.listMetadata["image"]?first)!?has_content >
            <div class="listing-item__image-wrapper">
                <img class="deferred" alt="Thumbnail for ${result.title!}" src="//${httpRequest.getHeader('host')}//s/resources/${question.collection.id}/${question.profile}/img/pixel.gif" data-deferred-src="${(result.listMetadata["image"]?first)!}"> 
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
                            ${(result.listMetadata["stencilsFacebookPageCity"]?first)!}       
                            <#if (result.listMetadata["stencilsFacebookPageCountry"]?first)!?has_content>
                                , ${(result.listMetadata["stencilsFacebookPageCountry"]?first)!}
                            </#if>                                  
                        </div>

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
                    </#if>

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
                    ${(response.customData.stencilsMethods.linkify(result.listMetadata["c"]?first!))!?no_esc}
                </div>

                <div class="listing-item__summary">
                    <span class="fas fa-info-circle"></span>
                    <@s.boldicize>
                        ${(response.customData.stencilsMethods.linkify(result.listMetadata["stencilsFacebookPageInfo"]?first!))!?no_esc}
                    </@s.boldicize>
                </div>

                <#-- Call to Action (CTA) -->                        
                <a href="${result.clickTrackingUrl!}" class="listing-item__action">VIEW PAGE</a> 
            </div>          

            <#-- Display the time which this result has last been visited by the user -->
            <@sessions.LastVisitedLink result=result/> 

            <#-- Footer -->                    
            <div class="listing-item__footer">
                <#if (result.listMetadata["stencilsFacebookProfileUrl"]?first)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        By:
                        <a href="${result.customData["stencilsFacebookProfileUrl"]!}">
                            ${(result.listMetadata["author"]?first)!}
                        </a> 
                    </div>
                </#if>

                <#if (result.listMetadata["stencilsFacebookPageWebsite"]?first)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        By:
                        <a href="${(result.listMetadata["stencilsFacebookPageWebsite"]?first)!}">
                            ${(result.listMetadata["stencilsFacebookPageWebsite"]?first)!}
                        </a> 
                    </div>
                </#if>

                <#if (result.listMetadata["stencilsFacebookPagePhone"]?first)!?has_content>
                    <a
                        href="tel:${result.listMetadata["stencilsFacebookPagePhone"]?first!}"
                        class="listing-item__footer-block
                            listing-item__footer-block--highlight"
                    >
                        <svg class="svg-icon listing-item__icon">
                            <title>Contact phone</title>
                            <use href="#phone"></use>
                        </svg>
                        ${result.listMetadata["stencilsFacebookPagePhone"]?first!}
                    </a>                
                </#if>
            </div>                                        
        </div>
    </article>   
</#macro>

<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->