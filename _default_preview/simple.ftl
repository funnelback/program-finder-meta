<#ftl encoding="utf-8" output_format="HTML" />

<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/web/templates/modernui/funnelback.ftl" as fb />

<#import "/share/stencils/libraries/base/client_includes.ftl" as client_includes />
<#import "history_cart.ftl" as history_cart />
<#import "project.ftl" as project />
<#import "base.ftl" as base />
<#import "facets.ftl" as facets />
<#import "results.ftl" as results />
<#import "auto-complete.ftl" as auto_complete />
<#import "curator.ftl" as curator />
<#import "extra_search.ftl" as extra_search />


<#--
    Specific result styling imports
	These imports are required for the automatic template selection to work
	The various namespaces (e.g. 'video', 'facebook') need to be on the main scope 
-->
<#import "programs.ftl" as programs />
<#import "courses.ftl" as courses />

<!DOCTYPE html>
<html lang="en"> 
    <head>
        <!-- htmlcs-disable -->
        <!-- Metadata -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="referrer" content="always">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        
        <title><@s.AfterSearchOnly>${question.query!}<@s.IfDefCGI name="query">,&nbsp;</@s.IfDefCGI></@s.AfterSearchOnly><@s.cfg>service_name</@s.cfg></title>
        
        <#-- Presentation logic shared across all Vertical Product -->
        <link href="https://unpkg.com/normalize.css@8.0.1/normalize.css" rel="stylesheet">
        <script src="/stencils/resources/thirdparty/jquery/v3.2.1/jquery-3.2.1.min.js"></script>
        <link href="/s/resources/${question.collection.id}/${question.profile}/css/main.css" rel="stylesheet">
        
        <#-- Output the implementation specific CSS -->
        <@client_includes.HTMLHeader />
    </head>
    <body>

        <#-- Output the clients global navigation -->
        <@client_includes.ContentHeader />
        
        <div class="fb-container">
            <main class="main" role="main">
                <#-- Display the initial -->
                <@s.InitialFormOnly>                
                    <section class="module-intro content-wrapper">
                        <h1 class="module-intro__title">Explore ${question.getCurrentProfileConfig().get("stencils.I18n.finder_type_primary")?cap_first}s</h1>
                        <p class="module-intro__desc">
                            Use our interactive ${question.getCurrentProfileConfig().get("stencils.I18n.finder_type_primary")?cap_first} Finder to explore what Funnelback has to offer. Filter your search by subject,
                            delivery method and term. Or type a keyword to get started.
                        </p>
                    </section>
                </@s.InitialFormOnly>
                
                <section class="module-search js-module-search content-wrapper">
                    <h2 class="sr-only">Search module</h2>                    
                    <@project.SearchForm />                    
                </section>
                
                <#-- What to display after the user has entered a query -->
                <@s.AfterSearchOnly>                                    
                    <@project.Results />

                    <#-- testing custom code -->
                    <section class="module-compare js-module-compare">
                        <h2 class="sr-only">Compare elements</h2>
                        <div class="module-compare__bar content-wrapper">
                            <a href="#" class="module-compare__close">Close</a>
                            <a href="#" class="module-compare__clear hidden">Clear</a>
                            
                        </div>
                        <div class="module-compare__wrapper content-wrapper">
                            <table class="module-compare__list">
                                <tbody>
                                    <tr>
                                        <th scope="row"></th>
                                        <#-- actual compare items go here -->
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </section>               
                </@s.AfterSearchOnly>

                <section class="quick-view js-quick-view" tabindex="-1">
                    <button class="quick-view__close"><span class="sr-only">close</span></button>
                    <div class="quick-view__wrapper">
                        <div class="quick-view__content">
                        <h2 class="quick-view__title">Lorem ipsum dolor (Ph.D.)</h2>
                        <p class="quick-view__desc">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Interdum risus, ultricies nec maecenas ornare
                            adipiscing viverra nullam. Ultrices varius tortor, elit enim, eget id amet.
                        </p>
                        <p class="quick-view__desc">
                            At pulvinar eget sed semper. Lectus facilisis cursus neque viverra in morbi. Augue ultrices non in nunc, sit in.
                            Tempus laoreet mattis elementum dui ante augue. Egestas tincidunt eget tellus pretium adipiscing amet risus.
                        </p>

                        <div class="quick-view__details">
                            <h3 class="quick-view__details-title">Program details</h3>

                            <div class="quick-view__details-content">
                                <h4>Lorem ipsum dolor sit amet.</h4>
                                <p>
                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Non molestie ac adipiscing a.
                                    Pharetra purus nam quis feugiat.
                                </p>
                                <p>
                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Non molestie ac adipiscing a.
                                </p>
                                <dl>
                                    <dt>Program length:</dt>
                                    <dd>3 years</dd>
                                    <dt>Qualification:</dt>
                                    <dd>pHd Science</dd>
                                </dl>
                                <a href="#" class="btn">Visit program page</a>
                            </div>
                        </div>
                    </div>
                        <section class="related">
                        <h3 class="related__title">Related courses</h3>
                        <ul class="related__list">
                            <li class="related__item">
                                <figure class="related__bg">
                                    <img src="mysource_files/img-1.jpg" alt="">
                                </figure>
                                <div class="related__content">
                                    <a href="#" class="related__link">
                                        <h4 class="related__item-title">
                                            Lorem Ipsum Dorem
                                        </h4>
                                        <span>Ph.D.</span>
                                    </a>
                                    <p class="related__desc">
                                        Lorem ipsum dolor sit amet, consectetur non...
                                    </p>
                                </div>
                            </li>
                            <li class="related__item">
                                <figure class="related__bg">
                                    <img src="mysource_files/img2.jpg" alt="">
                                </figure>
                                <div class="related__content">
                                    <a href="#" class="related__link">
                                        <h4 class="related__item-title">
                                            Lorem Ipsum Dorem Lorem Ipsum Dorem
                                        </h4>
                                    </a>
                                    <p class="related__desc">
                                        Lorem ipsum dolor sit amet, consectetur non.
                                    </p>
                                </div>
                            </li>
                            <li class="related__item">
                                <figure class="related__bg">

                                </figure>
                                <div class="related__content">
                                    <a href="#" class="related__link">
                                        <h4 class="related__item-title">
                                            Lorem Ipsum Dorem
                                        </h4>
                                        <span>Ph.D.</span>
                                    </a>
                                    <p class="related__desc">
                                        Lorem ipsum dolor sit amet, consectetur non.
                                    </p>
                                </div>
                            </li>
                            <li class="related__item">
                                <figure class="related__bg">

                                </figure>
                                <div class="related__content">
                                    <a href="#" class="related__link">
                                        <h4 class="related__item-title">
                                            Lorem Ipsum Dorem
                                        </h4>
                                        <span>Ph.D.</span>
                                    </a>
                                    <p class="related__desc">
                                        Lorem ipsum dolor sit amet, consectetur non.
                                    </p>
                                </div>
                            </li>
                            <li class="related__item">
                                <figure class="related__bg">

                                </figure>
                                <div class="related__content">
                                    <a href="#" class="related__link">
                                        <h4 class="related__item-title">
                                            Lorem Ipsum Dorem
                                        </h4>
                                        <span>Ph.D.</span>
                                    </a>
                                    <p class="related__desc">
                                        Lorem ipsum dolor sit amet, consectetur non.
                                    </p>
                                </div>
                            </li>
                            <li class="related__item">
                                <figure class="related__bg">

                                </figure>
                                <div class="related__content">
                                    <h4 class="related__item-title">
                                        <a href="#" class="related__link">
                                            Lorem Ipsum Dorem
                                        </a>
                                    </h4>
                                    <p class="related__desc">
                                        Lorem ipsum dolor sit amet, consectetur non.
                                    </p>
                                </div>
                            </li>
                        </ul>
                    </section>
                    </div>
                </section>                
            </main><!-- /.main -->
        </div>
  
        <#-- Concierge includes -->  
        <script src="/stencils/resources/thirdparty/jquery/v3.2.1/jquery-3.2.1.min.js"></script>
        <script src="/stencils/resources/thirdparty/popper/v1.12.3/umd/popper.min.js"></script>
        <script src="/stencils/resources/thirdparty/bootstrap/v4.0.0/js/bootstrap.min.js"></script>
        
        <#-- Radio button changes -->
        <script type="text/javascript">
            $(document).ready(function () {
                $('.program-finder-display').click(function() {
                    var url = $(this).attr('data-url');
                    window.location.href = url;
                });
            });
        </script>

        <script src="/stencils/resources/autocompletion/js/typeahead.bundle-0.11.1.min.js"></script>
        <script type="text/javascript" src="${GlobalResourcesPrefix}thirdparty/handlebars-4.0.12/handlebars.min.js"></script>
        <script src="/s/resources/${question.collection.id}/${question.profile}/js/typeahead.fb-2.6.js"></script>
        

        <#-- 
            Include all the auto complete templates which determines 
            how items in concierge are to be displayed.
        -->
        <@programs.AutoCompleteTemplate />

        <script>
            jQuery(document).ready( function() {
                <@auto_complete.AutoComplete />
            });
        </script>
        

        <@client_includes.ContentFooter />

        <#-- Javascript (application) logic shared across all Vertical Product -->
        <script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/js/runtime.js"></script>
        <script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/js/vendors.js"></script>
        <script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/js/main.js"></script>
    
        <@project.CartTemplate/>
        <@history_cart.Config />
    </body>
</html>
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
