# Search preview

After a prospective student enters a query, they are navigated to a page which has both matching `programs` and `courses` separated into two discrete sections. This separation of results is known as "search preview" in the Program Finder. By grouping results into search previews, we can infer the context of the user by their interaction with each group.

For example, given a prospective student is presented with 8 programs and 8 courses and the user selects "more courses", we can infer that they are more
interested in courses. With this inference, we can narrow down the search results to just courses eliminating programs from the list.  

Please note the same thing can be achieve through facets. This is simply an alternative user experience.

## How it works

Search preview have two key elements; The documents to be displayed in the preview and the navigation link.

![Search preview](images/search_preview.png "Search preview")

### Documents to be displayed

Each search preview contains a list of matching search results. These are powered by extra searches and can be configured 
return documents from different data sources or have different queries or scoping applied.

By default, the Program Finder comes with shipped with two extra searches; programs and courses.

It is enabled via the search package configuration screen.

```ini
ui.modern.extra_searches=courses,programs
ui.modern.extra_searches.courses.query_processor_options=-num_ranks=8 -clive=pnp~ds-program-finder-courses-web -log=off -spelling=off -show_qsyntax_tree=off -explain=false 
ui.modern.extra_searches.courses.source=pnp~sp-program-finder-meta
ui.modern.extra_searches.programs.query_processor_options=-num_ranks=8 -clive=pnp~ds-program-finder-programs-web -log=off -spelling=off -show_qsyntax_tree=off -explain=false 
ui.modern.extra_searches.programs.source=pnp~sp-program-finder-meta
```

### Navigation link

The navigation link allows the user to refine the results down to the context of the search preview.

The link itself can be configured to select any facet which has defined. By default, it will navigate the user to the corresponding tab facet.

```ini
stencils.search_preview.programs.facet_name=Tabs
stencils.search_preview.programs.category_label=Programs
stencils.search_preview.courses.facet_name=Tabs
stencils.search_preview.courses.category_label=Courses
```

The above instructions Funnelback to create a navigation link for "programs" search preview that will select the `Program` facet category under the `Tab` facet.

Similarly, it will create a navigation link for "courses" search preview that will select the `Courses` facet category under the `Tab` facet.

## Adding search previews

This section will describe how to add a new search preview to a page. It involves:

* Added a new extra search
* Updating the templates
* Configuring the navigation link

### Configuring a new extra search

Setup a new extra search which is scoped to the desired documents. Depending on the requirements, this may involve creating new data sources. For more details about extra searches, please visit the [documentation](https://docs.squiz.net/funnelback/docs/latest/build/results-pages/extra-searches/index.html) website.

### Updating the templates

After the extra search has been create, it needs to be exposed in the template. This can be done by modifying the [simple.ftl](../_default_preview/simple.ftl)

e.g. Given a extra search called `tutorials` exists which scopes documents down to just `tutorials`, we can output the results by modifying the following:

```html
    <#-- Programs extra search -->
    <@extra_search.Preview  extraSearchName="programs" documentType=question.getCurrentProfileConfig().get("stencils.I18n.finder_type_primary") + "s" />

    <#-- Courses extra search -->
    <@extra_search.Preview  extraSearchName="courses" documentType=question.getCurrentProfileConfig().get("stencils.I18n.finder_type_secondary") + "s" />
```

to

```html
    <#-- Programs extra search -->
    <@extra_search.Preview  extraSearchName="programs" documentType=question.getCurrentProfileConfig().get("stencils.I18n.finder_type_primary") + "s" />

    <#-- Courses extra search -->
    <@extra_search.Preview  extraSearchName="courses" documentType=question.getCurrentProfileConfig().get("stencils.I18n.finder_type_secondary") + "s" />

    <#-- Tutorials extra search -->
    <@extra_search.Preview  extraSearchName="tutorial" documentType="tutorial" />
```

Note: The documentType parameter represents the display name and is used in the navigation link.

### Configuring the navigation link

The last step is to configure the navigation link to send the user to the required facet. This is done using the following result page or search package configuration parameters:

```ini
stencils.search_preview.<extra_search_name>.facet_name=<name_of_facet>
stencils.search_preview.<extra_search_name>.category_label=<name_of_facet_category>
```

e.g. Given we have a extra search called `tutorial`, a facet call `Tabs` with a facet category called `Tutorial`, then the following will need to be added:

```ini
stencils.search_preview.tutorials.facet_name=Tabs
stencils.search_preview.tutorials.category_label=Tutorials
```

## Removing all search previews

If a client only has one type of document, it would make better sense to remove the search preview functionality from the default implementation and only show
the organic results. The can be done using the following steps:

* Remove extra search configurations from the search package configurations.
* Remove extra search references from the in the template (simple.ftl).
* Update the organic search results so that it is always displayed.
* Remove references in the results page and search package configurations.
* Remove or define new Tab facet.

The following are instructions on how to remove the program and courses search preview from the default implementation.

### Remove extra searches

* Remove all configurations starting with `ui.modern.extra_searches.*` from the search package configurations.

### Remove the references to the search previews from the template (simple.ftl)

You can remove the references to the search previews by removing the following from [simple.ftl](../simple.ftl)

```html
    <#-- Programs extra search -->
    <@extra_search.Preview  extraSearchName="programs" documentType=question.getCurrentProfileConfig().get("stencils.I18n.finder_type_primary") + "s">
        <@no_results.NoResults />
        <@result_list.ResultList />
    </@extra_search.Preview>
    
    <#-- Courses extra search -->
    <@extra_search.Preview  extraSearchName="courses" documentType=question.getCurrentProfileConfig().get("stencils.I18n.finder_type_secondary") + "s">
        <@no_results.NoResults />
        <@result_list.ResultList />
    </@extra_search.Preview>
```
### Update the organic search results so that it is always displayed

The default implementation hides the organic results on the "all" tab so that duplicates do not appear due to the presence of the search previews. To enable
the organic results on all tabs, we need to change the following in [simple.ftl](../_default_preview/simple.ftl):

Change the following:

```html
    <#-- 
        Hide the organic/normal results on the all tab as we only 
        want to display the extra searches.  
    -->
    <@facets.IsNotSelected facetName="Tabs" categoryLabel="All">
        <@no_results.NoResults />
        <@result_list.ResultList />
        <@pagination.Pagination />
    </@facets.IsNotSelected>
```
to
```html
    <@no_results.NoResults />
    <@result_list.ResultList />
    <@pagination.Pagination />
```
### Remove or define new Tab facet

The tab facet allows the user to switch between programs and courses (or both). As there is only one type, it is worthwhile to:

* Remove the Tabs facet completely - This can be via the faceted navigation screens.

* Alternative, you can define new values for the Tab facet.

After completing that, search previews should be disabled.

## Extra notes

*Why is it called a search preview*

It's all related to navigation. Part of the search preview functionality is the navigation link. The user can use this navigation link to see more results related to the extra search. In other words, results being displayed on the first screen is a preview of search results which will be available if the user was to hit the navigation link.
