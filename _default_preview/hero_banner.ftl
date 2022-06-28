<#ftl encoding="utf-8" output_format="HTML" />

<#--
    Generates a search form for the current collection, passing through the
    relevant parameters like collection, profile, form, scope, ...

    @param preserveTab Boolean indicating if searching via the form should preserve the currently selected tab or not
    @param class Optional <code>class</code> attribute to use on the &lt;form&gt; tag
-->
<#macro SearchForm preserveTab=true class="">
    <!-- hero_banner:SearchForm -->
    <div
        class="no-wysiwyg hero-banner hero-banner--settings hero-banner--overlay-50 hero-banner--bg-compact hero-banner--undefined hero-banner--pull-centered hero-banner-search"
    >
        <div class="hero-banner-wrapper">
            <div class="hero-banner__contents-container">
                <div class="hero-banner__contents">
                    <div class="hero-banner__contents-text"></div>
                    <div class="hero-banner-search__form"
                    >
                        <div class="hero-banner-search__bar">
                            <label for="bannerQuery" class="visuallyhidden">
                            Search:
                            </label>
                            <div
                                class="autocomplete-search"
                                >
                                <div class="autocomplete-search__combobox-wrapper">
                                    <div
                                        id="autocomplete-search-combobox"
                                        role="combobox"
                                        aria-controls="autocomplete-search-input"
                                        aria-expanded="false"
                                        aria-owns="autocomplete-search-listbox"
                                        aria-haspopup="listbox"
                                        class="autocomplete-search__combobox"
                                    >
                                        <#-- Concierge currently also contains the logic and markup for the input box -->
                                        <@concierge.Concierge />	
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                        <@sessions.Controls />                
                </div>
            </div>
            <img 
                src="//${httpRequest.getHeader('host')!}/s/resources/${question.collection.id}/${question.profile}/img/hero-banner-background.png" 
                alt="Alt text description" 
                class="hero-banner__image hero-banner__image--top" 
                srcset="//${httpRequest.getHeader('host')!}/s/resources/${question.collection.id}/${question.profile}/img/hero-banner-background.png 1600w,
                        //${httpRequest.getHeader('host')!}/s/resources/${question.collection.id}/${question.profile}/img/hero-banner-background.png 1000w,
                        //${httpRequest.getHeader('host')!}/s/resources/${question.collection.id}/${question.profile}/img/hero-banner-background.png 800w,
                        //${httpRequest.getHeader('host')!}/s/resources/${question.collection.id}/${question.profile}/img/hero-banner-background.png 450w"
            >
        </div>
    </div>
</#macro>