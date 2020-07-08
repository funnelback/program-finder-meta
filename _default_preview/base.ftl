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
            <input name="query" id="query" type="search" class="module-search__query" autocomplete="off" placeholder="Search for ${question.collection.configuration.value("stencils.I18n.finder_type", "Course")?lower_case}s or a career" value="${question.query!}">
            <button type="submit" class="module-search__btn"><span class="sr-only">Search</span></button>
        </div>
        <#nested>
    </form>
</#macro>

<#macro TypeDisplay name="">
    <h3 class="search-results__section-title">${name} (<span>${response.resultPacket.resultsSummary.totalMatching!}</span>)</h3>
</#macro>

<#macro ResultCount>
    <#if (response.resultPacket.resultsSummary.totalMatching)! != 0>
        <span class="search-results__total text-right">Showing <span>${response.resultPacket.resultsSummary.currStart!}</span> - <span>${response.resultPacket.resultsSummary.currEnd!}</span> of <span>${response.resultPacket.resultsSummary.totalMatching!}</span> Results</span>
    </#if>
</#macro>

<#macro NoResults>
    <#if (response.resultPacket.resultsSummary.totalMatching)! == 0>
        <span class="search-results__total text-right"><span>No</span> results found</span>
    </#if>
</#macro>

<#--
  Display Curator messages

  @param position Position attribute to consider from the Curator message.
    Only messages with a position attribute matching this will be displayed. Can be empty to display all messages regardless of position.
-->
<#macro CuratorExhibits position>
    <#if !haveshownCurator>
    <#global haveshownCurator = true >
    
    <#list (response.curator.exhibits)![] as exhibit>
        <#-- Skip best bets -->
        <#if exhibit.category != "BEST_BETS">      
        <#-- Only display if the position specified matches the Curator position.
            Curators with no position set default to "center" -->
            <#if !position?? || ((exhibit.additionalProperties.position)!"center") == position>

                <#if exhibit.messageHtml??>
                <#-- Simple message -->
                <article class="search-results__item ${(exhibit.additionalProperties.class)!}">
                    <div class="search-results__content">
                        ${exhibit.messageHtml?no_esc}
                    </div>
                </article>
                <#elseif exhibit.descriptionHtml??>
                    <#-- Rich message -->
                    <article class="search-results__item ${(exhibit.additionalProperties.class)!}">
                        <div class="search-results__content">
                            <h3 class="search-results__title">
                                <a href="${exhibit.linkUrl!}" class="search-results__link">${exhibit.titleHtml!}</a>
                            </h3>
                            <p class="search-results__desc">
                                <#if exhibit.displayUrl?? && exhibit.displayUrl != "-">
                                    <cite class="text-success">${exhibit.displayUrl}</cite>
                                    <br />
                                </#if>
                                <#if exhibit.descriptionHtml??>${exhibit.descriptionHtml?no_esc}</#if>
                            </p>
                            <div class="search-results__bottom">
                                <span class="search-results__info ">
                                    ${(exhibit.additionalProperties.tag)!}
                                </span>
                            </div>
                        </div>
                    </article>
                </#if>
            </#if>
        </#if>
  </#list>
  </#if>
</#macro>

<#--
  Display best bets
-->
<#macro BestBets>
  <#list (response.curator.exhibits)![] as exhibit>
    <#if exhibit.category == "BEST_BETS">
    <div class="alert alert-warning" role="alert">
      <strong><a class="text-warning" href="${exhibit.linkUrl!}">${exhibit.titleHtml!}</a></strong>
      <#if exhibit.descriptionHtml??><p>${exhibit.descriptionHtml?no_esc}</p></#if>
      <#if exhibit.displayUrl?? && exhibit.displayUrl != "-"><cite><a class="text-muted" href="${exhibit.linkUrl!}">${exhibit.displayUrl}</a></cite></#if>
    </div>
    </#if>
  </#list>
</#macro>

