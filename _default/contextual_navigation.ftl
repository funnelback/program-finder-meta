<#ftl encoding="utf-8" output_format="HTML" />
<#-- 
  This template contains markup and logic related to the 
  contextual navigation feature. Contextual navigation is also 
  known as related search. It provides a mechansim refine the results
  by expanding the query terms based on the documents being crawled. 
-->

<#--
  Display the contextual navigation panel only if there are valid values
-->
<#macro ContextualNavigation>
    <!-- contextual_navigation::ContextNavigation -->
    <@HasContextualNavigation>
        <section class="related-links">
            <h2 class="related-links__heading">
                Related searches for <strong><@s.QueryClean /></strong>
            </h2>
            <ul class="related-links__list">
                <#list (response.resultPacket.contextualNavigation.categories)![] as category>
                    <#list category.clusters as cluster>
                        <li class="related-links__item">
                            <a  
                                href="${cluster.href}" 
                                class="related-links__link"
                            >
                                ${cluster.label?replace("...", " <strong>${response.resultPacket.contextualNavigation.searchTerm} </strong> ")?no_esc}
                            </a>
                        </li>
                    </#list>
                </#list>                        
            </ul>
        </section>
    </@HasContextualNavigation>
</#macro>

<#-- 
    Displays the nested code if contextual navigation has at least 1 entry.
-->
<#macro HasContextualNavigation>
    <#if (response.resultPacket.contextualNavigation.categories)!?has_content &&
        response.resultPacket.contextualNavigation.categories?filter(category -> category.clusters?size gt 0)?size gt 0>
        <#nested>
    </#if>
</#macro>