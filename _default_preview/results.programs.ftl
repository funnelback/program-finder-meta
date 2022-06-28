<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
    Macro decides how each result should be presented. 

    @param result An individual result from the data model
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
    Standard view of a result which is to be displayed in the 
    main section of the search engine result page (SERP)
    @param result An individual result from the data model
-->
<#macro ListView result>
    <@GenericView result=result />
</#macro>

<#--
    Card view of a result which is to be displayed in the 
    main section of the search engine result page (SERP)
    @param result An individual result from the data model
-->
<#macro CardView result>
    <@GenericView result=result />
</#macro>

<#--
    A generic view used to drive both the the list and card view
    @param result An individual result from the data model
-->
<#macro GenericView result>
    <!-- results.programs::GenericView -->
    <article class="listing-item listing-item--program listing-item--background-grey10 listing-item--color-black" data-fb-result="${(result.indexUrl)!}">   

        <#if (result.listMetadata["programImage"]?first)!?has_content >
            <div class="listing-item__image-wrapper">
                <img class="deferred listing-item__image" alt="Thumbnail for ${result.title!}" src="//${httpRequest.getHeader('host')}/s/resources/${question.collection.id}/${question.profile}/img/pixel.gif" data-deferred-src="${(result.listMetadata["programImage"]?first)!}"> 
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
                    <#if (result.listMetadata["programFaculty"]?first)!?has_content>
                        <div class="listing-item__subtitle">
                            ${(result.listMetadata["programFaculty"]?first)!}     
                        </div>
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
                    <@s.boldicize>
                        ${result.summary!?no_esc}
                    </@s.boldicize>
                </div>

                <#-- Metadata should as tags/pills -->        
                <#if (result.listMetadata["programCredentialType"])!?has_content
                    || (result.listMetadata["stencilsDeliveryMethod"])!?has_content 
                    || (result.listMetadata["programCredits"])!?has_content>
                    <ul aria-label="Result tags" class="listing-item__tags">
                        <#list (result.listMetadata["programCredentialType"])![] as value>
                            <li class="listing-item__tag">${value}</li>
                        </#list>

                        <#list (result.listMetadata["stencilsDeliveryMethod"])![] as value>
                            <li class="listing-item__tag">${value}</li>
                        </#list>

                        <#list (result.listMetadata["programCredits"])![] as value>
                            <li class="listing-item__tag">${value}</li>
                        </#list>
                    </ul>
                </#if>

                <#-- Call to Action (CTA) -->                        
                <#--  <a href="${result.clickTrackingUrl!}" class="listing-item__action">VIEW PROGRAM DETAILS</a>  -->

                <span class="enable-cart-on-result listing-item__action" 
                        aria-label="Add result to the shortlist">
                </span> 
            </div>          

            <#-- Display the time which this result has last been visited by the user -->
            <@sessions.LastVisitedLink result=result/> 

            <#-- Footer -->                    
            <div class="listing-item__footer">
                <#if (result.listMetadata["programLengthYears"]?first)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <svg class="svg-icon svg-icon--small">
                            <title>Duration</title>
                            <use href="#time">
                            </use>
                        </svg>
                        ${(result.listMetadata["programLengthYears"]?first)!} years
                    </div>
                </#if>

                <#if (result.listMetadata["programCampus"]?first)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <svg class="svg-icon svg-icon--small">
                            <title>Campus</title>
                            <use href="#map"></use>
                        </svg>
                        ${(result.listMetadata["programCampus"]?first)!}
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
    <!-- results.programs::AutoCompleteTemplate -->
	<script id="auto-completion-programs" type="text/x-handlebars-template">
		<div class="fb-auto-complete--non-organic">
            <h6>
                {{{extra.disp.title}}}

                {{#if extra.disp.listMetadata.programCredentialType.[0]}}
                    ({{{extra.disp.listMetadata.programCredentialType.[0]}}})
                {{/if}}                
            </h6>

            <div class="details">
                {{#if extra.disp.listMetadata.programFaculty.[0]}}
                    <div class="fb-auto-complete__body__metadata text-muted">
                        {{{extra.disp.listMetadata.programFaculty.[0]}}}
                    </div>
                {{/if}}

                {{#if extra.disp.listMetadata.stencilsDeliveryMethod.[0]}}
                    <div class="fb-auto-complete__body__metadata text-muted">
                        {{{extra.disp.listMetadata.stencilsDeliveryMethod.[0]}}}
                    </div>
                {{/if}}                
            </div>      
		</div>    
	</script>
</#macro>

<#-- Output the cart template -->
<#macro ShortlistTemplate>
    <!-- results.programs::Shortlist -->    
    <#-- 
        Note: Cart templates as assigned to document types in profile.cfg/collection.cfg using 
        the following configuration:

        stencils.template.shortlist.<collection>=<type> 
        
        e.g. stencils.template.shortlist.higher-education-meta=programs

        For this to function correctly, the ID must be in the following format:
        id="shorlist-template-<type>".

        e.g. id="shorlist-template-programs"
    -->
    <script id="shortlist-template-programs" type="text/x-handlebars-template">
        <article class="listing-item listing-item--program listing-item--background-grey10 listing-item--color-black" data-fb-result="{{indexUrl}}">   

            {{#if metaData.programImage}} 
                <div class="listing-item__image-wrapper">
                    <img class="listing-item__image" alt="Thumbnail for {{title}}" src="{{metaData.programImage}}"> 
                </div> 
                <#-- Show a placeholder image for showcase -->     
                <#if ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE">
                    {{else}}
                    <div class="listing-item__image-wrapper">
                        <img class="listing-item__image" alt="Thumbnail for {{title}}" src="https://picsum.photos/300/300?sig={{title}}">
                    </div>
                </#if>
            {{/if}} 
            <div class="listing-item__content">
                <#-- Title -->
                {{#if title}} 
                    <div class="listing-item__header">
                        <a href="{{indexUrl}}" title="{{title}}" class="listing-item__title-link">
                            <h3 class="listing-item__title">
                                {{#truncate 255}}
                                    {{title}}  
                                {{/truncate}}
                            </h3>
                        </a>

                        <#-- Subtitle -->
                        {{#if metaData.programFaculty}}  
                            <div class="listing-item__subtitle">
                                {{metaData.programFaculty}}       
                            </div>
                        {{/if}} 

                        <#-- Pretty version of the url of the document -->
                        {{#if indexUrl}}  
                            <cite class="listing-item__subtitle listing-item__subtitle--highlight">
                                {{indexUrl}}
                            </cite>
                        {{/if}} 
                    </div>
                {{/if}} 
                
                
                <#-- Body -->
                <div class="listing-item__body">
                    <#-- Summary -->
                    {{#if metaData.c}} 
                        <div class="listing-item__summary">
                            {{#truncate 255}}
                                {{metaData.c}}  
                            {{/truncate}}
                        </div>
                    {{/if}} 

                    <#-- Metadata should as tags/pills -->        
                    <ul aria-label="Result tags" class="listing-item__tags">                                    
                        {{#list metaData.programCredentialType joinWith=", "}}
                            <li class="listing-item__tag">{{ this }}</li>
                        {{/list}}

                        {{#list metaData.stencilsDeliveryMethod joinWith=", "}}
                            <li class="listing-item__tag">{{ this }}</li>
                        {{/list}}

                        {{#list metaData.programCredits joinWith=", "}}
                            <li class="listing-item__tag">{{ this }} credits</li>
                        {{/list}}
                    </ul>

                    <p>
                        <span class="fb-cart__remove"></span>
                    </p>

                    <span class="enable-cart-on-result listing-item__action" 
                            aria-label="Add result to the shortlist">
                    </span> 
                </div>          

                <#-- Footer -->                    
                <div class="listing-item__footer">
                    {{#if metaData.programLengthYears}} 
                        <div class="listing-item__footer-block listing-item__footer-block">
                            <svg class="svg-icon svg-icon--small">
                                <title>Duration</title>
                                <use href="#time">
                                </use>
                            </svg>
                            {{metaData.programLengthYears}} years
                        </div>
                    {{/if}} 

                    {{#if metaData.programCampus}} 
                        <div class="listing-item__footer-block listing-item__footer-block">
                            <svg class="svg-icon svg-icon--small">
                                <title>Campus</title>
                                <use href="#map"></use>
                            </svg>
                            {{metaData.programCampus}}
                        </div> 
                    {{/if}} 
                </div>                                        
            </div>
        </article>    
    </script>
  
  </#macro>