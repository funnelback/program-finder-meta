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
    <!--results.people::GenericView -->
    <article class="listing-item listing-item--people listing-item--background-grey10 listing-item--color-black" data-fb-result="${(result.indexUrl)!}">
        <#if (result.listMetadata["image"]?first)!?has_content>
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
                        title="${(result.listMetadata["peopleFirstName"]?first)!} ${(result.listMetadata["peopleLastName"]?first)!}"
                        class="listing-item__title-link"
                    >
                        <h3 class="listing-item__title">
                            <@s.boldicize>
                                <@s.Truncate length=90>
                                    ${(result.listMetadata["peopleFirstName"]?first)!} ${(result.listMetadata["peopleLastName"]?first)!}
                                </@s.Truncate>
                            </@s.boldicize>
                        </h3>
                    </a>

                    <#--  Subtitle -->
                    <#if (result.listMetadata["peoplePosition"]?first)!?has_content>
                        <div class="listing-item__subtitle">
                            ${(result.listMetadata["peoplePosition"]?first)!}

                            <#if (result.listMetadata["peoplePosition"]?first)!?has_content>            
                                - ${(result.listMetadata["peopleDepartment"]?first)!}                
                            </#if>
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
                <#if (result.listMetadata["author"])!?has_content>
                    <ul aria-label="Result tags" class="listing-item__tags">
                        <#list result.listMetadata["author"] as author>
                            <li class="listing-item__tag">${author}</li>
                        </#list>
                    </ul>
                </#if>

                <#-- Call to Action (CTA) -->                        
                <#--  <a href="${result.clickTrackingUrl!}" class="listing-item__action">VIEW MORE</a>   -->
            </div>          

            <#-- Display the time which this result has last been visited by the user -->
            <@sessions.LastVisitedLink result=result/> 

            <#-- Footer -->                    
            <div class="listing-item__footer">
                <#if (result.listMetadata["peopleEmail"]?first)!?has_content>                
                    <a href="mailto:${(result.listMetadata["peopleEmail"]?first)!}" class="listing-item__footer-block listing-item__footer-block--highlight">
                        <svg class="svg-icon svg-icon--small">
                            <title>Contact email</title>
                            <use href="#email"></use>
                        </svg>
                        ${(result.listMetadata["peopleEmail"]?first)!}
                    </a>
                </#if>
                <#if (result.listMetadata["peoplePhone"]?first)!?has_content>
                    <a href="tel:${(result.listMetadata["peoplePhone"]?first)!}" class="listing-item__footer-block listing-item__footer-block--highlight">
                        <svg class="svg-icon svg-icon--small">
                            <title>Contact phone</title>
                            <use href="#phone"></use>
                        </svg>
                        ${(result.listMetadata["peoplePhone"]?first)!}
                    </a>
                </#if>
                <#if (result.listMetadata["peopleLocation"]?first)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <svg class="svg-icon svg-icon--small">
                        <title>Time</title>
                        <use href="#map"></use>
                        </svg>
                        ${(result.listMetadata["peopleLocation"]?first)!}
                    </div>
                </#if>                  
            </div>
        </div>
    </article>    
</#macro>


<#-- 
    Handlebars template used to display the current object
    in concierge.
--> 
<#macro AutoCompleteTemplate>
    <!-- results.people::AutoCompleteTemplate -->
    <script id="auto-completion-people" type="text/x-handlebars-template">
        <div class="fb-auto-complete--non-organic">
            <h6>
                {{{extra.disp.listMetadata.peopleFirstName.[0]}}}
                {{{extra.disp.listMetadata.peopleLastName.[0]}}}
            </h6>
            <div class="details">
                {{#if extra.disp.listMetadata.peopleDepartment.[0]}}
                    <div class="fb-auto-complete__body__metadata">
                        <span class="far fa-building" aria-hidden="true" aria-label="Department" title="Department"></span> 
                        {{{extra.disp.listMetadata.peopleDepartment.[0]}}}
                    </div>
                {{/if}}

                {{#if extra.disp.listMetadata.peoplePhone.[0]}}
                    <div class="fb-auto-complete__body__metadata">
                        <span class="fas fa-map-marker-alt" aria-hidden="true" aria-label="Phone" title="Phone"></span> 
                        {{{extra.disp.listMetadata.peoplePhone.[0]}}}
                    </div>
                {{/if}}

                {{#if extra.disp.listMetadata.peopleEmail.[0]}}
                    <div class="fb-auto-complete__body__metadata">
                        <span class="far fa-envelope" aria-hidden="true" aria-label="Email" title="DepartmEmailent"></span> 
                        {{{extra.disp.listMetadata.peopleEmail.[0]}}}
                    </div>
                {{/if}}
            </div>
        </div>
    </script>
</#macro>