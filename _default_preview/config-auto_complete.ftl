<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
    This templates aims to provide an easy set of instructions for the client
    to integrate autocomplete into their website. It will detail things like:
    * Required CSS and javascript libraries
    * Handlebar templates for each channel in Concierge
    * Configurations to enable autocomplete

    Implementers will need to ensure that they include all the appropriate 
    handlebar templates as they will most likely differ from project
    to project. Search for "TODO" to see all places where this needs to be 
    reviewed .
-->

<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/share/stencils/libraries/base/client_includes.ftl" as client_includes />
<#import "auto_complete.ftl" as auto_complete />

<#-- 
    TODO: Add or update the follow to include templates containing the handlebar templates required
    for autocomplete.
-->
<#import "people.ftl" as people />
<#import "courses.ftl" as courses />

<#-- Used to send absolute URLs for resources -->
<#assign httpHost=httpRequest.getHeader('host')>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Autocomplete configuration for ${question.collection.configuration.value("group.project_id")!}</title>
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

    <#-- 
        Output the clients global navigation
        Note: If adding the client's header is too much trouble, it could make more sense
        to include the default head that is shipped with Stencils.
    -->
    <@client_includes.ContentHeader />
    
    <div class="fb-container">
        <main class="main" role="main">
            <section class="content-wrapper">
                <h1>Autocomplete configuration</h1>
                
                <h2>Example</h2>
                <form
                    action="https://${httpHost!}/s/search.html" 
                    method="GET"
                    role="search"
                    class="module-search--bg module-search">

                    <div class="module-search__group">
                        <input required 
                            name="query" 
                            id="query" 
                            type="Search query"
                            class="module-search__query tt-input" 
                            autocomplete="off" 
                            placeholder="Start your search here…" 
                            spellcheck="false" 
                            dir="auto"
                            aria-labelledby="fb-query"
                            aria-required="true">
                    </div>

                    <input type="hidden" name="collection" value="${question.collection.id!}">
                    <input type="hidden" name="profile" value="${question.profile!}">
                </form>

                <!-- 
                    We are putting everything in one section to make it
                    easier to understand. 
                    Normally add the CSS to the <head> section and the
                    javascript to the end of the <body> section.
                -->
                <!-- Require CSS and javascript - START -->
                <#-- 
                    TODO: Add or update the following list include the handlebars templates used for the implementation.
                -->                
                <@courses.AutoCompleteTemplate />
                <@people.AutoCompleteTemplate />

                <link rel="stylesheet" href="https://${httpHost!}/s/resources/${(question.collection.id)!}/${(question.profile)!}/css/main.css">
                <link rel="stylesheet" href="https://${httpHost!}/s/resources/${(question.collection.id)!}/${(question.profile)!}/css/customer-typeahead.css">

                <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>
                <!-- Typeahead handles sending the asynchronous HTTP requests on keystroke with debouncing and caching -->
                <script src="https://cdnjs.cloudflare.com/ajax/libs/typeahead.js/0.11.1/typeahead.bundle.min.js" integrity="sha512-qOBWNAMfkz+vXXgbh0Wz7qYSLZp6c14R0bZeVX2TdQxWpuKr6yHjBIM69fcF8Ve4GUX6B6AKRQJqiiAmwvmUmQ==" crossorigin="anonymous"></script>
                <!-- Handlebars is used to render client-side templates -->
                <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>

                <!-- Stencils specific code -->
                <script src="https://${httpHost!}/s/resources/${question.collection.id}/${question.profile}/js/handlebars-helpers.js"></script>  

                <!-- Funnelback auto-complete -->
                <script src="https://${httpHost!}/s/resources/${question.collection.id}/${question.profile}/js/funnelback.autocompletion-2.6.0.stencils.js"></script>


                <script>
                    <@auto_complete.Configuration />
                </script>
                <!-- Required CSS and javascript - END -->   

            </section>

            <section class="content-wrapper">
                <h2>CSS</h2>
                <p>
                    The first step of implementing autocomplete is to include following CSS 
                    file should be included in the &lt;head&gt; of the document. 
                </p>                

<#assign cssSnippets>
<link rel="stylesheet" href="https://${httpHost!}/s/resources/${(question.collection.id)!}/${(question.profile)!}/css/main.css">
<link rel="stylesheet" href="https://${httpHost!}/s/resources/${(question.collection.id)!}/${(question.profile)!}/css/customer-typeahead.css">
</#assign>
                <pre>${cssSnippets!?markup_string}</pre>

                <p> 
                    Please keep in mind that the css provided with Funnelback relies on 
                    the &lt;input&gt; being nested in the following structure:
                    
                    <pre>.fb-container .module-search--bg.module-search .module-search__group</pre>
                    
                    Note: The CSS provided is an example implementation of what you can do. 
                    Please feel free to add additional styling to suit the page your are integrating
                    with.
                </p>

                <h2>Javascript</h2>
                <p>The following Javascript dependencies should be included at the end of the &lt;body&gt;.</p>
                <p>
                    Note: The autocomplete library has a dependency on jQuery. 
                    It has been tested on version 3.x.x, however, is 
                    theoretically compatible with version 1.10.2+. 
                    During implementation, please check for any jQuery errors in the browser console.
                </p>


<#-- Note: Indentation is off because the leading tabs are shown in the <pre> -->
<#assign requiredJavascript>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>
<!-- Typeahead handles sending the asynchronous HTTP requests on keystroke with debouncing and caching -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/typeahead.js/0.11.1/typeahead.bundle.min.js" integrity="sha512-qOBWNAMfkz+vXXgbh0Wz7qYSLZp6c14R0bZeVX2TdQxWpuKr6yHjBIM69fcF8Ve4GUX6B6AKRQJqiiAmwvmUmQ==" crossorigin="anonymous"></script>
<!-- Handlebars is used to render client-side templates -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js" integrity="sha512-zT3zHcFYbQwjHdKjCu6OMmETx8fJA9S7E6W7kBeFxultf75OPTYUJigEKX58qgyQMi1m1EgenfjMXlRZG8BXaw==" crossorigin="anonymous"></script>
<!-- Funnelback autocomplete library -->
<!-- Stencils specific code -->
<script src="https://${httpHost!}/s/resources/${question.collection.id}/${question.profile}/js/handlebars-helpers.js"></script>  

<!-- Funnelback auto-complete -->
<script src="https://${httpHost!}/s/resources/${question.collection.id}/${question.profile}/js/funnelback.autocompletion-2.6.0.stencils.js"></script>
</#assign>

                <strong>Required javascript libraries</strong>
                <pre>${requiredJavascript!?markup_string}</pre>

<#-- 
    TODO: Add or update the following list include the handlebars templates used for the implementation.
-->
<#assign autoCompleteTemplate>
<@people.AutoCompleteTemplate />
<@courses.AutoCompleteTemplate />
</#assign>

                <strong>Handlebars templates</strong>
                <p>
                    The autocomplete library uses Handlebars to control the presentation of 
                    each channel. The required templates can be found below:
                </p>

                <pre class="ftl-markup-string">${autoCompleteTemplate!?markup_string}</pre>

<#assign configSnippet>
<script>
    <@auto_complete.Configuration />
</script>    
</#assign>
                <strong>Autocomplete configurations</strong>
                <p>In the snippet below, the #query selector must be replaced with a CSS selector that targets the &lt;input&gt; element in your search bar. 
                For example, if your &lt;input&gt; has an id of "search-input", then replace #query with #search-input
                <pre class="ftl-markup-string">${configSnippet?markup_string?replace("suggest.json", "https://" + httpHost + "/s/suggest.json")}</pre>
            </section>
        </main><!-- /.main -->
    </div>
    
    <@client_includes.ContentFooter />

    <#-- 
    Funnelback automatically inserts a "zero-width space" between consecutive curly brace characters
    to prevent an XSS vulnerability for AngularJS executing code between curly braces.
    (See patch 15.20.0.19)

    This has the adverse effect of also inserting the "zero-width space" into the Handlebars templates
    when `?markup_string` is called, because Handlebars also uses double curly braces. When these templates
    are copy/pasted into the client CMS, they will have the invisible character which breaks Handlebars,
    yet the templates will *appear* to be correct.
    -->
    <script>
    // Remove zero-width space from Handlebars templates 
    Array.from(document.querySelectorAll('.ftl-markup-string')).forEach(pre => {
        pre.innerText = pre.innerText.replace(/[\u200B-\u200D\uFEFF]/g, '')
    })
    </script>

</body>
</html>