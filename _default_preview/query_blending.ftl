
<#ftl encoding="utf-8" output_format="HTML" />

<#--
  Display query blending notice and provide the ability to turn it off.
-->
<#macro QueryBlending>
    <!-- query_blending::QueryBlending -->
    <#if (response.resultPacket.QSups)!?size &gt; 0>        
        <p class="query-blending">
            <svg class="svg-icon svg-icon--small">
                <use href="#information"></use>
            </svg>
            
            Your query has been expanded to <strong><#list response.resultPacket.QSups as qsup> ${qsup.query}<#if qsup_has_next>, </#if></#list></strong>. 
            &nbsp;
            Search for
            <a class="query-blending__highlight" href="?${QueryString}&amp;qsup=off" title="Turn off query blending"><em>${question.originalQuery}</em></a>
            instead.
        </p>
    </#if>
</#macro>