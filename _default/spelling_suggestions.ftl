<#ftl encoding="utf-8" output_format="HTML" />

<#--
  Display spelling suggestion notice.
-->
<#macro SpellingSuggestions>
    <!-- spelling_suggestions::SpellingSuggestions -->
    <#if (response.resultPacket.spell)??>
        <div class="search-spelling-suggestions">
            <svg class="svg-icon search-spelling-suggestions__icon">
                <use href="#information"></use>
            </svg>
            Did you mean

            <a 
                class="search-spelling-suggestions__link" 
                href="${question.collection.configuration.value("ui.modern.search_link")}?${response.resultPacket.spell.url}" 
                title="Spelling suggestion">${(response.resultPacket.spell.text)!}
            </a>

            ?
        </div>
    </#if>
</#macro>
