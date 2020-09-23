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
                <#if result.metaData.stencilsCourseDesc??>
                    ${result.metaData.stencilsCourseDesc}
                <#else>
                    ${result.summary}
                </#if>
            </p>
            <div class="search-results__bottom">
                <span class="search-results__info search-results__info--icon search-results__info--icon-list">
                    <#if result.metaData.stencilsCourseDepartment??>Department: ${result.metaData.stencilsCourseDepartment}</#if>
                </span>
                <span class="search-results__info search-results__info--icon search-results__info--icon-list">
                    <#if result.metaData.stencilsCourseDelivery??>Delivery: ${result.metaData.stencilsCourseDelivery}</#if>
                </span>
                <span class="search-results__info search-results__info--icon search-results__info--icon-list">
                    <#if result.metaData.stencilsCourseCredit??>${result.metaData.stencilsCourseCredit}</#if>
                </span>
                <#-- <div class="search-results__compare">
                    <input type="checkbox" id="compareCourse${result.rank}" name="compareCourse${result.rank}" value="Compare Course">
                    <label class="compare-button" data-url="${result.liveUrl}" for="compareCourse${result.rank}">Compare Course</label>
                </div> -->
            </div>
        </div>
    </article>
</#macro>
