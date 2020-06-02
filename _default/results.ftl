<#ftl encoding="utf-8" output_format="HTML" />

<#macro Result result>
    <article class="search-results__item">
            <#if result.metaData.courseImage??>
                <figure class="search-results__bg">
                    <img src="${result.metaData.courseImage}" alt="${result.title}"/>
                </figure>
            <#else>
                <figure class="search-results__bg">
                    <img src="https://source.unsplash.com/random/335x192?${(result.title)!''?url}" alt="${result.title}"/>
                </figure>
            </#if>
            <div class="search-results__content">
                <h3 class="search-results__title">
                    <a href="${result.clickTrackingUrl}" class="search-results__link">
                        ${result.title}
                    </a>
                </h3>
                <p class="search-results__desc">
                    <#if result.metaData.c??>
                        ${result.metaData.c}
                    <#else>
                        ${result.summary}
                    </#if>
                </p>
                <div class="search-results__bottom">
                    <span class="search-results__info search-results__info--icon search-results__info--icon-list">
                        <#if result.metaData.stencilsProgramID??>ID ${result.metaData.stencilsProgramID} - </#if><#if result.metaData.stencilsProgramCredentialName??>${result.metaData.stencilsProgramCredentialName?split("|")?join(", ")}</#if>
                    </span>
                    <span class="search-results__info search-results__info--icon search-results__info--icon-list">
                        <#local hasPrev = false>
                        <#if (result.metaData.stencilsProgramCredits!"0") != "0">
                            ${result.metaData.stencilsProgramCredits} credits
                        </#if>
                        <#if (result.metaData.stencilsProgramLengthYears!"0") != "0">
                            <#if hasPrev>, </#if>
                            ${result.metaData.stencilsProgramLengthYears} years
                            <#local hasPrev = true>
                        </#if>
                        <#if (result.metaData.stencilsProgramLengthMonths!"0") != "0">
                            <#if hasPrev>, </#if>
                            ${result.metaData.stencilsProgramLengthMonths} months
                            <#local hasPrev = true>
                        </#if>
                        <#if (result.metaData.stencilsProgramLengthWeeks!"0") != "0">
                            <#if hasPrev>, </#if>
                            ${result.metaData.stencilsProgramLengthWeeks} weeks
                        </#if>
                        <#if (result.metaData.stencilsProgramLengthVaries!"false") == "true">
                            Variable length
                        </#if>
                    </span>
                    <div class="search-results__compare">
                        <input type="checkbox" id="compare${result.rank}" name="compare${result.rank}" value="Compare ${question.collection.configuration.value("stencils.I18n.finder_type", "Course")}">
                        <label class="compare-button" data-url="${result.liveUrl}" for="compare${result.rank}">Compare ${question.collection.configuration.value("stencils.I18n.finder_type", "Course")}</label>
                    </div>
                </div>
            </div>
        </article>
</#macro>

<#macro TierBar tierbar>
    <#-- No design in this stencil by default -->
</#macro>

<#macro AutoCompleteTemplate>
    <script id="auto-completion-courses" type="text/x-handlebar-template">
        <div class="module-search__list-item">
            <a href="#" class="module-search__list-link" style="background-image: url('https://source.unsplash.com/random/335x192?{{extra.disp.title}};">
                <span class="module-search__list-text">
                    {{extra.disp.title}}
                    <span class="module-search__list-more">Learn More</span>
                </span>
            </a>
        </div>
    </script>
</#macro>

<#-- this is only used by the vanilla config -->
<#macro CartTemplate>
    <script id="cart-template-program-finder" type="text/x-cart-template">
        <article class="module-compare__item">
            <a href="#" class="module-compare__remove" data-url="{{url}}">Remove</a>
            <h3 class="module-compare__title">{{name}}</h3>
            <p class="module-compare__desc">
                {{desc}}
            </p>
            <div class="module-compare__overview">
                <h4 class="module-compare__overview-title">Course Overview</h4>
                <dl class="module-compare__overview-list">
                    <dt class="module-compare__dt">Course Type</dt>
                    <dd class="module-compare__dd">{{credential}}</dd>
                    <dt class="module-compare__dt">Course ID</dt>
                    <dd class="module-compare__dd">{{id}}</dd>
                </dl>
            </div>
            <a href="{{url}}" class="module-compare__link link">Visit Course Page</a>
        </article>
    </script>
</#macro>