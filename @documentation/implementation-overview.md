**Jump to:**

[[_TOC_]]

# Client overview

| Field | Value |
| ---      |  ------  |
| Client name | e.g. University of Example Client|
| Implementation overview | *What is the project about (e.g. search over the client website, course finder, intranet search, accessibility or content audit, etc.)* <br /> *What are the systems involved (CMS, databases, LDAP etc.)*|

>>>
__TODO__: Populate the above table with the relevant information.
>>>

## Capabilities implemented

Please indicate which capabilities have been implemented for this project. This is needed to update Funnelback’s capability register to help Funnelback locate implementations using specific features.

| Capability| Yes/No |
| ---      |  ---------:|
| Website Search | No |
| Enterprise Search | No |
| Intranet Search | No |
| Portal Search | No |
| E-commerce Search | No |
| Applications/Document/News Search | No |
| Content Auditor | No |
| Accessibility Auditor | No |
| Content Classifier | No |
| Text Miner | No |
| Contextual Navigation | No |
| Search Sessions | No |
| Faceted Navigation | No |
| Results Collapsing | No |
| Search Powered Content | No |
| Predictive Segmentation | No |
| Content Modifier | No |
| Simple Auto Completion | No |
| Structured Auto Completion | No |
| Faceted Auto Completion | No |
| Concierge | No |
| Best Bets | No |
| Curator | No |
| Quick Links | No |
| Recommendations | No |
| Course Finder | No |
| Event Search | No |
| Map Integration | No |
| Location Based Search | No |
| Social Media Integration | No |
| Tabbed Search | No |
| Rich Media Search | No |
| Thumbnail images | No |

>>>
__TODO__: Populate the above table with the relevant information.
>>>

## Server hardware configurations

The server configuration can be found below:

| Field | Value |
|  ---   |  ---  |
| Hardware type | e.g `VM`|
| Operating System | *e.g. Linux CentOS 7.0*|
| CPU | *e.g. 4 cores*|
| RAM | *e.g. 8GB*|
| HDD | *e.g. 300GB*|

>>>
__TODO__: Populate the above table with the relevant information.

This section can be removed if the implementation is hosted on the Funnelback Cloud.
>>>

## Funnelback application details

**Funnelback version**: 15.6.0.12

Non-standard port used:

* Admin webserver: 9443
* Search webserver: 8080
etc.

>>>
__TODO__: Populate the above placeholders with the relevant information. Also include any:

* system-wide or global.cfg
* non-standard configuration
* Custom SSL certificate installed in web/conf/client-ssl.keystore , global.cfg updated accordingly

This section can be removed if the implementation is hosted on the Funnelback Cloud.
>>>

## Admin URL

The URL to access the Funnelback Admin UI (if the server is publicly available):

`https://<hostname>/search/admin`

>>>
__TODO__: Change the above placeholder with the relevant information.

This section can be removed if the implementation is hosted on the Funnelback Cloud*
>>>

## Search URL(s)

The lists all the search URLs used by the project, either when wrapped by a CMS or another system, or when search users directly access Funnelback:

| Function | Integration point | Source URL | Funnelback endpoint |
| ---      |  ------  |--------- | ----- |
| Main search   | Top-right corner search box (all pages). Wrapped by CMS  | `http://client.com/`  | `http://funnelback-server.com/s/search.html?collection=client-meta&profile=example` |
| Course finder | Course finder homepage. Direct access to Funnelback | `http://courses.client.com/` | `http://courses.client.com/search.json?collection=courses` |
| Course listing pages (generated) |  Courses section of the main website. Wrapped by CMS | `http://client.com/courses/` | `http://funnelback-server.com/s/search.html?collection=courses&form=listing` |

>>>
__TODO__: Populate the above table with the relevant information.
>>>

## Other integration endpoints (XML/JSON)

>>>
__TODO__: Describe here any additional integration endpoint made via search.json or search.xml

If no other integration endpoint, mention: No other integration endpoints
>>>

## Funnelback API clients

The following is a list of Funneblack APIs used by a third party system (other than previous integration endpoints).

e.g.

| Function | Third party system | APIs used |
| ---      |  ------  |---------:|
| Include Analytics overview in the client CMS homepage   | Client CMS (Kentico)   | Admin API: Analytics   |

>>>
__TODO__: Populate the above table with the relevant information.

This section can be removed if no additional Funnelback APIs are used in the implementation.
>>>

## Domain name and SSL

The search will be available on a Funnelback URL by default (e.g. search-`CLIENTNAME`.clients.funnelback.com).

>>>
__TODO__: Please change the above if a custom domain name is required (e.g. search.example.com) and provide information how it has been implemented.

i.e. Has the client added a CNAME entry in the DNS to point to the search URL?

Note: If SSL is required on a custom domain, a SSL certificate must be purchased by the client and provided to Funnelback.
>>>

## Users and roles

A high level summary of the users and roles can be found below:

### Users

| User | Function |
| ---  |  ------  |
| jsmith | Super administrator with access to every |
| jdoe | Only has access to the marketing dashboard |
| fbarker | Can create collections but cannot delete collections|

### Roles

| Role | Function |
| ---  |  ------  |
| marketing   | Only provide access to the marketing dashboard  |
| implementer   | Provides access to to the marketing dashboard and the administration UI. Is capable of implementing collections but is unable to do server wide functions such as license administration and ugprading the server|
| superadmin | Provides full access to everything on the server|

_Note: Roles are only applicable from v15.18 onwards_

>>>
__TODO__: Please populate the above table with the users and roles founds on the system.

Please note that we only require a high level summary of the functional aspect of the user. Information around the technical details such as Funnelback permissions and collections and profiles they have access to will be captured during the migration when the user.ini are carried across.
>>>

## Collection configurations

Please refer to each collection for information on `why` and  `what` features are implemented.

>>>
__TODO__: Please complete a collection overview document (`@documentation/collection-over.md`) for each collection. An example can be found in [collection overview](implementation-collection-overview.md).
>>>