<#ftl encoding="utf-8" output_format="HTML" />

<#--
    Display Curator messages.

    @param position Position attribute to consider from the Curator message.
        Only messages with a position attribute matching this will be displayed. Can be empty to display all messages regardless of position.
-->
<#macro Curator position>
    <!-- curator.Curator -->
    <section class="module-curator module-curator--no-bg">
        <h2 class="sr-only">Curator</h2>
        <article class="module-curator__list">
            <#list (response.curator.exhibits)![] as exhibit>
                <#if exhibit.category != "BEST_BETS">
                    <#if !position?? || ((exhibit.additionalProperties.position)!"center") == position>
                        <#if exhibit.messageHtml??>
                            <#-- Simple message -->
                            <blockquote class="blockquote search-exhibit ${(exhibit.additionalProperties.class)!} mb-3 p-1">
                                ${exhibit.messageHtml?no_esc}
                            </blockquote>
                        <#elseif exhibit.descriptionHtml??>                        
                            <article class="module-curator__item ${(exhibit.additionalProperties.class)!}">
                                <div class="module-curator__top">
                                    
                                    <#-- Display the image if there is one -->
                                    <#if (exhibit.additionalProperties.image)!?has_content>
                                        <figure class="module-curator__bg">
                                            <#-- TODO - CHange the URL to reference one from the curator rule -->
                                            <img src="${(exhibit.additionalProperties.image)!}" alt="">
                                        </figure>                                    
                                    </#if>
                                    <div>
                                        <h3 class="module-curator__title">
                                            <a href="${exhibit.linkUrl!}" class="module-curator__link">
                                                ${exhibit.titleHtml!}
                                            </a>
                                        </h3>
                                        
                                        <#-- Output the display url which gives context to the curator result -->
                                        <#if exhibit.displayUrl?? && exhibit.displayUrl != "-">
                                            <cite>${exhibit.displayUrl}</cite>
                                        </#if>
                                    </div>
                                    
                                </div>
                                <div class="module-curator__content">
                                    <#-- Output the description -->
                                    <#if exhibit.descriptionHtml??>
                                        <p class="module-curator__desc">
                                            ${exhibit.descriptionHtml?no_esc}
                                        </p>
                                    </#if>

                                    <#-- Output and option explicit the call to action link -->
                                    <#if (exhibit.additionalProperties.call_to_action_url)!?has_content>
                                        <a class="btn--link" href="${(exhibit.additionalProperties.call_to_action_url)!}">
                                            ${(exhibit.additionalProperties.call_to_action_label)!}
                                        </a>
                                    </#if>
                                </div>
                            </article>
                        </#if>
                    </#if>
                </#if>
            </#list>
        </article>
    </section>
</#macro>

<#-- 
    Runs the nested code if there is at least 1 curator rule which 
    matches the position.
-->
<#macro HasCurator position>
    <#if ((response.curator.exhibits)![])?filter(exhibit -> exhibit.category != "BEST_BETS" && (!position?? || ((exhibit.additionalProperties.position)!"center") == position))?size gt 0>
        <#nested>
    </#if>
</#macro>


facets?split(",")?filter( x -> response.facets?filter(y -> x == y.name && y.allValues?size gt 0)?size gt 0)?size gt 0>

<#--
  Display best bets.
-->
<#macro BestBets>
    <!-- curator.BestBets -->
    <#list (response.curator.exhibits)![] as exhibit>
        <#if exhibit.category == "BEST_BETS">   
            <section class="module-curator module-curator--no-bg">
                <h2 class="sr-only">Curator</h2>
                <article class="module-curator__list">                  
                    <article class="module-curator__item ${(exhibit.additionalProperties.class)!}">
                        <div class="module-curator__top">
                            <div>
                                <h3 class="module-curator__title">
                                    <a href="${exhibit.linkUrl!}" class="module-curator__link">
                                        ${exhibit.titleHtml!}
                                    </a>
                                </h3>
                                
                                <#-- Output the display url which gives context to the curator result -->
                                <#if exhibit.displayUrl?? && exhibit.displayUrl != "-">
                                    <cite>${exhibit.displayUrl}</cite>
                                </#if>
                            </div>                            
                        </div>
                        <div class="module-curator__content">
                            <#-- Output the description -->
                            <#if exhibit.descriptionHtml??>
                                <p class="module-curator__desc">
                                    ${exhibit.descriptionHtml?no_esc}
                                </p>
                            </#if>
                        </div>
                    </article>
                </article>
            </section>
        </#if>
    </#list>
</#macro>

<#-- 
    Runs the nested code if there is at least 1 best bet rule.
-->
<#macro HasBestBets>
    <#if ((response.curator.exhibits)![])?filter(exhibit -> exhibit.category == "BEST_BETS")?size gt 0>
        <#nested>
    </#if>
</#macro>