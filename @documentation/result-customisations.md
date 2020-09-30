# Result customisations

It is fairly common that clients would like to customise how programs and courses are presented to better their requirements. This guide will touch on how to customise the results presentation in:

* Results
* Quick view
* Concierge
* Cart

## Results

The data used for each implementation can vary from organisations to organisations. This difference in data (in structure, type and quality) and unique requirements of each organisation usually means results needs customised. 

This can involve but not limited to:    

* Adding, changing or removing metadata.
* Changing the length of title or summary.
* Updating the html structure prevent or correct css collisions.

Programs and courses can be customised by modifying `<#macro GenericView>` in [programs.ftl](../_default_preview/programs.ftl) and [courses.ftl](../_default_preview/courses.ftl) templates.

## Quick view

Quick view allows the user view more information about a particular document without them having to leave the search results page. This aims to minimise the amount of hopping back and forth between systems.

It is possible to customise how this is displayed by modifying `<#macro QuickView>` in [programs.ftl](../_default_preview/programs.ftl) and [courses.ftl](../_default_preview/courses.ftl) templates.

## Concierge

In addition to organic query completion, Concierge is setup to bring back relevant programs in a dedicated channel. This can be customised by
modifying  `<#macro AutoCompleteTemplate>` in the [programs.ftl](../_default_preview/programs.ftl) template.

## Cart

Similarly to the results presentation, it is possible to customise how programs the cart are displayed in the cart. This can be done by modifying  `<#macro CartTemplate>` in the [programs.ftl](../_default_preview/programs.ftl) template.

## Configure the header and footer

To help mimic the look and feel of the client's website, it is possible to configure the header and footer to use the clients markup and script.
`<link to header and footers ftl>`
