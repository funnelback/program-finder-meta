# Program Finder Vertical Product

This is a quick reference guide to implementing the Program Finder Vertical Product.

At a high level, you will need to:

* **Setup the program and courses collections** - Create the collections and map the relevant metadata.
* **Setup the meta collection** - Using this git repo as the basis, setup a new meta collection.
* **Configure the extra searches** - Create and configure the programs and courses extra searches.
* **Setup the faceted navigation** - Create the `display` radio facet and other relevant dropdown facets.
* **Customise result presentation** - Display the relevant images and metadata.
* **Configure concierge** - Customise the concierge to display the relevant metadata.
* **Configure cart** - Customise the cart to display the relevant metadata.
* **Configure the header and footer** - Add the client's header and footer to assist with a seamless transition from client's website to search.

## Setup the programs and courses collections

The first step is to create two collections which will gather the programs and courses. The collection type can vary depending on how the data is made available (please see the funnelback documentation website for more details). When it comes to naming the collection, it is recommended to use the following format:

`<client>-program-finder-<collection_type>`

The important aspect of this step is to get the documents indexed and mapped to the appropriate metadata classes.

The metadata classes are the key drives in the result presentation, concierge, cart and faceted navigation. Please see `<funnelback_server>` for more information.

### Programs

Programs are the qualifications or accreditation earned which is awarded for completing a set number of courses.

For an example of a program collection please see below:

* `program-finder-programs-web`

### Courses

Courses are subjects that student undertake as part of a Program. They usually involve lectures, tutorials, workshops, labs etc.

For an example of a course please see below:

* `program-finder-courses-web`

## Setup the meta collection

The meta collection contains the majority of the application and presentation logic required for the Program Finder Vertical Product. It is recommended to name the collection use the following format:

`<client>-program-finder-meta`

e.g. `funnelback-program-finder-meta`

## Configure the extra searches

The Program Finder uses extra searches to display programs and courses in separate areas on the search engine result page.

To configure the extra searches, change the target collection in the following: extra search config:

`extra_search.programs.cfg`
```
collection=<insert_name_of_program_collection>
query_processor_options=-num_ranks=8 -clive=<insert_name_of_meta_collection>
```

`extra_search.courses.cfg`
```
collection=<insert_name_of_course_collection>
query_processor_options=-num_ranks=8 -clive=<insert_name_of_meta_collection>
```

## Setup the faceted navigation

The Program Finder relies on a facet called `Display` which determines when programs or courses should be displayed. An example of the faceted navigation configuration can be found below:

`<insert image of facet navigation config of display>`

Change the value in the collections field for the Programs and Courses facets so that they reference the relevant collections.

## Customise result presentation

It is fairly common that clients customise the way programs and courses are presented so that it best meets their requirement. This can include but not limited to:
* Adding, changing or removing metadata.
* Changing the length of title or summary.
* Updating the html structure prevent or correct css collisions.

`<link to program and courses ftl>`

## Configure the cart

Similarly to the results presentation, it is possible to customise how items in the cart are displayed. This can be done by modifying the `<link to template with cart ftl>`.

## Configure the header and footer

To help mimic the look and feel of the client's website, it is possible to configure the header and footer to use the clients markup and script.
`<link to header and footers ftl>`
