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
    <!-- results.facebook.events::GenericView -->
    <article class="listing-item listing-item--promoted listing-item--background-grey10 listing-item--color-black" data-fb-result="${(result.indexUrl)!}">
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

                    <#--  Subtitle -->
                    <#if (result.listMetadata["stencilsFacebookEventLocation"]?first)!?has_content>
                        <div class="listing-item__subtitle">
                            <svg class="svg-icon svg-icon--small">
                                <title>Location</title>
                                <use href="#map"></use>
                            </svg>
                            
                            <#if (result.listMetadata["stencilsFacebookEventLocation"]?first)!?has_content
                                && (result.listMetadata["stencilsFacebookEventLocation"]?first)!?has_content>
                                <a  
                                    class="listing-item__subtitle-link"
                                    target="_blank"                               
                                    href="https://maps.google.com/?q=${(result.listMetadata["stencilsFacebookEventCoordinates"]?first)!(result.listMetadata["stencilsFacebookEventLocation"]?first)!}" target="_blank"
                                >
                                    ${(result.listMetadata["stencilsFacebookEventLocation"]?first)!}
                                </a>
                            <#else>
                                ${(result.listMetadata["stencilsFacebookEventLocation"]?first)!"Unknown location"}
                            </#if>

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

                    <#if (result.listMetadata["stencilsFacebookProfileUrl"]?first)!?has_content>
                        <div class="listing-item__subtitle">
                            <a href="${(result.listMetadata["stencilsFacebookProfileUrl"]?first)!}">       
                                ${(result.listMetadata["author"]?first)!"Unknown author"}
                            </a>
                        </div>
                    </#if> 
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
                <a href="${result.clickTrackingUrl!}" class="listing-item__action">VIEW EVENT</a> 
            </div>          

            <#-- Display the time which this result has last been visited by the user -->
            <@sessions.LastVisitedLink result=result/> 

            <#-- Footer -->                    
            <div class="listing-item__footer">
                <#if (result.listMetadata["d"]?first)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <svg class="svg-icon svg-icon--small">
                            <title>Duration</title>
                            <use href="#time">
                            </use>
                        </svg>
                        ${(result.listMetadata["d"]?first?datetime("yyyy-MM-dd HH:mm:ss.S z")?time?string.short)!} 
                        
                        <#if (result.listMetadata["stencilsFacebookEventEndDateTime"]?first)!?has_content>
                            - ${(result.listMetadata["stencilsFacebookEventEndDateTime"]?first?datetime("yyyy-MM-dd HH:mm:ss.S z")?time?string.short)!}
                        </#if>
                    </div>
                <#else>
                    <div class="listing-item__footer-block listing-item__footer-block">                        
                        <svg class="svg-icon svg-icon--small">
                            <title>Duration</title>
                            <use href="#time">
                            </use>
                        </svg>
                        Not available
                    </div>
                </#if>

                <#if (result.listMetadata["author"]?first)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <svg class="svg-icon svg-icon--small">
                            <title>Author</title>
                            <use href="#user-avatar">
                            </use>
                        </svg>

                        ${(result.listMetadata["author"]?first)!}
                    </div>
                </#if>
            </div>                                        
        </div>
    </article>          
</#macro>
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->