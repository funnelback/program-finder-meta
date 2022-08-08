<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
    Presentation and logic for the click history. Click history
    is a list of previously clicked on results by the current user.
-->

<#--
	Display the click history.
-->
<#macro ClickHistory>
    <!-- sessions.click_history::CickHistory -->
    <article class="search-history__item history-panel click-history">
        <h3 class="history-panel__title">
            <svg aria-hidden="true" class="svg-icon">
                <use href="#favorite"></use>
            </svg>
            Recently clicked results
        </h3>
        <#list session.clickHistory>
            <div class="session-history-click-results">
                <ul class="history-panel__items ">
                    <#items as item>
                    <li class="history-panel__item">
                        <span class="sr-only">Revisit</span>
                        <a
                            class="history-panel__link"
                            href="${item.indexUrl}"
                            >
                            ${item.title}
                        </a>
                        <p class="history-panel__last-visited">
                            <span class="sr-only">which was visited</span>
                            <span>
                            ${prettyTime(item.clickDate)}
                            <span class="sr-only">the query</span>
                            <span class="history-panel__query">"${(item.query!"")?replace("!FunDoesNotExist:padrenull","<empty query>")?split("|")?first?trim}"</span>
                            </span>
                        </p>
                    </li>
                    </#items>
                </ul>
            </div>
        </#list>

        <#-- No results for click history -->
        <p class="session-history-click-empty">
            Your click history is empty.
        </p>

        <#if (session.clickHistory)!?has_content>
            <button
                class="history-panel__clear session-history-clear-click"
                title="Clear click history"
                type="button"
                >
                <svg aria-hidden="true" class="svg-icon">
                    <use href="#close"></use>
                </svg>
                Clear
            </button>
        </#if>
    </article>        
</#macro>