<#ftl encoding="utf-8" output_format="HTML" />
<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/share/stencils/libraries/base/client_includes.ftl" as client_includes />
<#import "auto-complete.ftl" as auto_complete />
<#import "programs.ftl" as programs />

<#-- Used to send absolute URLs for resources -->
<#assign httpHost=httpRequest.getHeader('host')>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Auto-complete configuration for ${question.collection.configuration.value("group.project_id")!}</title>
    <link href="https://unpkg.com/normalize.css@8.0.1/normalize.css" rel="stylesheet">
    <link href="/s/resources/${question.collection.id}/${question.profile}/css/main.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.10.0/css/all.css">

    <style>
        /* Basic styling for code snippets */
        pre {
            background: #f4f4f4;
            border: 1px solid #ddd;
            border-left: 3px solid #f36d33;
            color: #666;
            page-break-inside: avoid;
            font-family: monospace;
            font-size: 15px;
            line-height: 1.6;
            margin-bottom: 1.6em;
            max-width: 100%;
            overflow: auto;
            padding: 1em 1.5em;
            display: block;
            word-wrap: break-word;
        }
    </style>
</head>
<body>

    <#-- Output the clients global navigation -->
    <@client_includes.ContentHeader />
    
    <div class="fb-container">
        <main class="main" role="main">
            <section class="content-wrapper">
                <h1>Autocomplete configuration</h1>

                <h2>CSS</h2>
                <p>The following CSS file should be included in the &lt;head&gt; of the document. Note that you may need to do additional styling in order to make it work with the rest of the page.</p>
                

<#assign cssSnippets>
<link rel="stylesheet" href="https://${httpHost!}/s/resources/${(question.collection.id)!}/${(question.profile)!}/css/main.css">
<link rel="stylesheet" href="https://${httpHost!}/s/resources/${(question.collection.id)!}/${(question.profile)!}/css/customer-typeahead.css">
</#assign>
                <pre>${cssSnippets!?markup_string}</pre>

                <h2>Javascript</h2>
                <p>The following Javascript dependencies should be included at the end of the &lt;body&gt;</p>
                <p>The following scripts have a dependency on jQuery. The autocompletion has been tested on version 3.x.x, however, is theoretically compatible with version 1.10.2+. Ensure to check for any jQuery errors in the browser console.</p>


<#-- Note: Indentation is off because the leading tabs are shown in the <pre> -->

<!-- Concierge includes -->  
<#assign requiredJavascript>
<script type="text/javascript" src="https://${httpHost}/stencils/resources/thirdparty/jquery/v3.2.1/jquery-3.2.1.min.js"></script>
<!-- Typeahead handles sending the asynchronous HTTP requests on keystroke with debouncing and caching -->
<script type="text/javascript" src="https://${httpHost}/stencils/resources/autocompletion/js/typeahead.bundle-0.11.1.min.js"></script>
<!-- typeahead-fb activates the Typeahead library in the context of the search page -->
<script type="text/javascript" src="https://${httpHost}/s/resources/${question.collection.id}/${question.profile}/js/typeahead.fb-2.6.js"></script>
<!-- Handlebars is used to render client-side templates -->
<script type="text/javascript" src="https://${httpHost}/${GlobalResourcesPrefix}thirdparty/handlebars-4.0.12/handlebars.min.js"></script>
</#assign>


<pre>${requiredJavascript!?markup_string}</pre>

<#assign autoCompleteTemplate>
<@programs.AutoCompleteTemplate />
</#assign>

<pre>${autoCompleteTemplate!?markup_string}</pre>

<#assign configSnippet>
<script>
    <@auto_complete.AutoComplete />
</script>    
</#assign>

                <p>In the snippet below, the #query selector must be replaced with a CSS selector that targets the &lt;input&gt; element in your search bar. 
                For example, if your &lt;input&gt; has an id of "search-input", then replace #query with #search-input
                <pre>${configSnippet?markup_string?replace("suggest.json", "https://" + httpHost + "/s/suggest.json")}</pre>

            </section>
        </main><!-- /.main -->
    </div>
    
    <@client_includes.ContentFooter />
</body>
</html>