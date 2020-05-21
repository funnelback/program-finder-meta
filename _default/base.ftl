<#ftl encoding="utf-8" output_format="HTML" />
<#---
  Generates a search form for the current collection, passing through the
  relevant parameters like collection, profile, form, scope, ...

  @param class Optional <code>class</code> attribute to use on the &lt;form&gt; tag
-->
<#macro SearchForm class="">
    <form action="${question.collection.configuration.value("ui.modern.search_link")}" method="GET"<#if class?has_content> class="${class}"</#if>>
        <div class="module-search__group">
            <input type="hidden" name="collection" value="${question.collection.id}">
            <#list ["enc", "form", "scope", "lang", "profile"] as parameter>
              <@s.IfDefCGI name=parameter><input type="hidden" name="${parameter}" value="${question.inputParameterMap[parameter]!}"></@s.IfDefCGI>
            </#list>
            <label for="query" class="sr-only">Search</label>
            <input name="query" id="query" type="search" class="module-search__query" autocomplete="off" placeholder="Find ${question.collection.configuration.value("stencils.I18n.finder_type", "Course")?lower_case}s" value="${question.query!}">
            <button type="submit" class="module-search__btn"><span class="sr-only">Search</span></button>
        </div>
        <#nested>
    </form>
</#macro>

<#macro ResultCount>
    <#if (response.resultPacket.resultsSummary.totalMatching)! != 0>
        <span class="search-results__total">Showing <span>${response.resultPacket.resultsSummary.currStart!}</span> - <span>${response.resultPacket.resultsSummary.currEnd!}</span> of <span>${response.resultPacket.resultsSummary.totalMatching!}</span> Results</span>
    </#if>
</#macro>

<#macro NoResults>
    <#if (response.resultPacket.resultsSummary.totalMatching)! == 0>
        <span class="search-results__total"><span>No</span> Results found</span>
    </#if>
</#macro>
