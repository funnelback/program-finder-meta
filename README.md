# Program Finder Vertical Product

This is a quick reference guide to implementing the Program Finder Vertical Product.

At a high level, you will need to:

* **Setup the program and courses collections** - Create the collections and map the relevant metadata.
* **Setup the meta collection** - Using this git repo as the basis, setup a new meta collection.
* **Configure the extra searches** - Create and configure the programs and courses extra searches.
* **Setup the faceted navigation** - Adjust the `Tabs` and other relevant facets.

## Initial setup

### Setup the programs and courses collections

The first step is to create two collections which will gather the programs and courses. The collection type can vary depending on how the data is made available (please see the funnelback documentation website for more details). When it comes to naming the collection, it is recommended to use the following format:

`<client>-program-finder-<collection_type>`

The important aspect of this step is to get the documents indexed and mapped to the appropriate metadata classes.

The metadata classes are the key drivers as they are used in result presentation, concierge, cart and faceted navigation. Where possible, please use the default metadata classes (names starting with `stencils` or `program`/`course`) names which have been setup in the sample collections.

#### Programs collection

Programs are the qualifications or accreditation earned which is awarded for completing a set number of courses.

For an example of a program collection please see `program-finder-programs-web`.

#### Courses collection

Courses are subjects, units or modules that student undertake as part of a Program. They usually involve lectures, tutorials, workshops, labs etc.

For an example of a course please see `program-finder-courses-web`.

#### Meta collection

The meta collection contains the majority of the application and presentation logic required for the Program Finder Vertical Product. It is recommended to name the collection use the following format:

`<client>-program-finder-meta`

e.g. `funnelback-program-finder-meta`

### Configure the extra searches

The Program Finder uses extra searches to display programs and courses in separate areas on the search engine result page.

To configure the extra searches, change the target collection in the following extra search config:

`extra_search.programs.cfg`

```java
collection=<name_of_meta_collection>
query_processor_options=-num_ranks=8 -clive=<name_of_program_collection> -log=off -curator=off -spelling=off -show_qsyntax_tree=off -explain=false
```

`extra_search.courses.cfg`

```java
collection=<name_of_meta_collection>
query_processor_options=-num_ranks=8 -clive=<name_of_course_collection> -log=off -curator=off -spelling=off -show_qsyntax_tree=off -explain=false
```

### Setup the faceted navigation

The Program Finder relies on a facet called `Tabs` which determines when programs or courses should be displayed. An example of the faceted navigation configuration can be found below:

![Configuring the labels of the facets](@documentation/images/facet_labels.png "Configuring the labels of the facets")

Change the value in the collections field for the `Programs` and `Courses` facets categories so that they reference the relevant collections.

### Review the search

Congratulations! Once you completed the above steps, you should have something similar to the following:

![Configuring the labels of the facets](@documentation/images/program_finder_overview.png "Configuring the labels of the facets")

## Next steps

Please see our [customisation guide](@documentation/template-configurations-guide.md) for information on localisation and customisation.
