<#ftl encoding="utf-8" output_format="HTML" />

<#macro GroupResults extraSearchName documentType="" view="List">
    <div class="grouped-results">
        <div class="grouped-results__navigation">
            <h3 class="grouped-results__title">{title}</h3>
            <a
                href={link}
                class="grouped-results__link"
                title={`See more ${title} results`}
            >
                See all {title}
                <span class="grouped-results__count">
                    ({count})
                </span>
            </a>
        </div>
        {children}
    </div>
</#macro>
