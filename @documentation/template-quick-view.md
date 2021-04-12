# Quick view

Quick view allows the user view more information about a particular document without them having to leave the search results page. This aims to minimise the amount of hopping back and forth between systems.

## How it works

To enable quick view to a result, simply add the class `js-quick-link` to any clickable element (such as `<button>`) with the attribute `data-target` populated with the `id` of the element to be displayed.

e.g.

Given the following anchor:
```html
<button class="search-results__link">
    ${result.title!}
</button>
```

Enabling quick view will look something like:

```html
<button class="search-results__link js-quick-link" data-target="#uniqueID">
    ${result.title!}
</button>

<!-- Markup for the quick view -->
<dialog id="uniqueID" 
    class="quick-view js-quick-view" 
    role="dialog"
    aria-labelledby="uniqueID-label"
    aria-describedby="uniqueID-desc"
    aria-modal="true">
    <button class="quick-view__close"><span class="sr-only">close</span></button>
    <div class="quick-view__wrapper">
        <div class="quick-view__content">
            <h2 class="quick-view__title" id="uniqueID-label">
                <!-- Custom HTML -->
            </h2>
            <p class="quick-view__desc" id="uniqueID-desc">
                <!-- More custom HTML -->
            </p>
            <div class="quick-view__details">
                <!-- Even more custom HTML -->
            </div>
        </div>
    </div>
</dialog>
```

For an example of this in action, please see the `<#macro GenericView>` in the [programs.ftl](../_default_preview/programs.ftl) and [courses.ftl](../_default_preview/courses.ftl) templates. For an example of the quick view dialog, please see and `<#macro QuickView>` the same templates.

## Accessibility

There must be a clickable element (i.e. `<button>`) with a class of `.quick-view__close` that is keyboard-focusable to close the QuickView.

For accessibility, note the `aria` attributes in the `<dialog>` element, these are used by screenreaders when a dialog is opened.

## Overlay

An overlay is used to capture click events to close the QuickView (there is also a button in the QuickView to close itself).
The overlay should be the first element in the body of the page and is provided in a macro in `base.ftl`, called with:
```ftl
<@base.Overlay />
```

The overlay is present by default in the `simple.ftl` file.

Note: Once Safari and Firefox fully support native `<dialog>` elements, we can get rid of the overlay because the dialog element provides a native overlay.

## Disabling quick view

The Program Finder comes with the quick view enabled by default for both programs and courses. To disable it, simply remove the `js-quick-link` class from the respective result.

## Troubleshooting issues

Check the browser Javascript console for errors, there may be elements expected by the script that are missing in the page which will be displayed with an error message.
