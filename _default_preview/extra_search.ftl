<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
  Provides preview of a facet. This allows the user to see 
  a sample of the results on another tab or facet selection without 
  having to click back and forwards. 

  @param extraSearchName The extra search of the documents of the target tab.
  @param documentType The type of documents which is being displayed by
    the extra search.
  @param view Controls how the documents will be presented.
  @param parentQuestion The question containin the tabs facet. This is required
    as extra searches remove facet navigation results. It defaults to the
     global question which is currently in scope.
-->
<#macro Preview extraSearchName documentType="" view="List" parentQuestion=question>
  <#assign parentQuestion = question>
  <@fb.ExtraResults name=extraSearchName>
    <#if (response.resultPacket.results)!?has_content>
      <div class="content-wrapper">
        <h3 class="search-results__section-title">${documentType}</h3>
        <#-- 
            Show the more link which will allow the user to navigate
            to the corresponding tab or facet.
        -->
        <#if (response.customData.stencilsSearchPreviewLink)!?has_content>
          
          <#assign searchLink = question.getCurrentProfileConfig().get("ui.modern.search_link")!>
          <#assign previewLink = response.customData.stencilsSearchPreviewLink!>
          
          <a href="${searchLink}${previewLink}" class="search-results__link-all text-right" title="See more results for ${tabDisplayName!}">
            See all ${documentType!} 
            <span>(${(response.resultPacket.resultsSummary.totalMatching)!})</span>
          </a>
        </#if>

        <@project.ResultList name=question.collection.configuration.value("stencils.I18n.finder_type_secondary", "Course")?cap_first + "s" />

      </div>
    </#if>
  </@fb.ExtraResults>
</#macro>