# Quick view

Quick view allows the user view more information about a particular document without them having to leave the search results page. This aims to minimise the amount of hopping back and forth between systems.

## How it works

To enable quick view to a result, simply add the class `js-quick-link` to any anchor <a> with the attribute `data-target` populated with the `id` of the html to be displayed.

e.g.

Given the following anchor:
```html
<a href="${result.clickTrackingUrl!}" class="search-results__link">
    ${result.title!}
</a>
```

Enabling quick view will look something like:

```html
<a href="${result.clickTrackingUrl!}" class="search-results__link js-quick-link" data-target="#uniqueID">
    ${result.title!}
</a>

<!-- Markup for the quick view -->
<section id="uniqueID" class="quick-view js-quick-view" tabindex="-1" role="dialog">
    <button class="quick-view__close"><span class="sr-only">close</span></button>
    <div class="quick-view__wrapper">
        <div class="quick-view__content">
            <h2 class="quick-view__title">
                <!-- Custom HTML -->
            </h2>
            <p class="quick-view__desc">
                <!-- More custom HTML -->
            </p>
            <div class="quick-view__details">
                <!-- Even more custom HTML -->
            </div>
        </div>
    </div>
</section>
```

For an example of this in action, please see the `<#macro GenericView>` in the [programs.ftl](../_default_preview/programs.ftl) and [courses.ftl](../_default_preview/courses.ftl) templates. For an example of the quick view dialog, please see and `<#macro QuickView>` the same templates.

## Disabling quick view

The Program Finder comes with the quick view enabled by default for both programs and courses. To disable it, simply remove the `js-quick-link` class from the respective result.
