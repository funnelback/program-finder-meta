<#ftl encoding="utf-8" output_format="HTML" />
                

<#macro QueryHistory>
    <!-- sessions.query_history.QueryHistory -->
    <article class="search-history__item history-panel query-history">
        <h3 class="history-panel__title">
            <svg aria-hidden="true" class="svg-icon">
                <use href="#search"></use>
            </svg>
            Recent searches
        </h3>
        <#-- Result for query history -->
        <#list session.searchHistory>        
            <div class="session-history-search-results">
                <ul class="history-panel__items ">
                    <#items as item>
                    <li class="history-panel__item">
                        <span class="sr-only">Revisit</span>
                        <a
                            class="history-panel__link"
                            href="${(question.collection.configuration.value("ui.modern.search_link"))!}?${item.searchParams}"
                            aria-label="View results for '${item.originalQuery!}' which queried ${prettyTime(item.searchDate)}"
                            >
                            ${item.originalQuery!"<empty query>"} (${item.totalMatching})
                        </a>
                        <p class="history-panel__last-visited">${prettyTime(item.searchDate)}</p>
                    </li>
                    </#items>
                </ul>
            </div>
        </#list>
        <#-- No results for query history -->
        <p class="session-history-search-empty">
            Your search history is empty.
        </p>
        <#if (session.searchHistory)!?has_content>
            <button
                class="history-panel__clear session-history-clear-search"
                type="button"
                title="Clear recent query history"
                >
                <svg aria-hidden="true" class="svg-icon svg-icon">
                    <use href="#close"></use>
                </svg>
                Clear
            </button>
        </#if>
    </article>
</#macro>    