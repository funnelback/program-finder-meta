<#ftl encoding="utf-8" output_format="HTML" />
<#-- 
    This template contains markup and logic related to the 
    auto complete feature.
-->

<#--
        Javascript required to configure concierge
-->
<#macro Configuration>
    <#if (question.getCurrentProfileConfig().get("stencils.auto-completion.datasets"))!?has_content>
        jQuery('#query').autocompletion({
            program: '<@s.cfg>auto-completion.program</@s.cfg>',
            alpha: '<@s.cfg>auto-completion.alpha</@s.cfg>',
            show: '<@s.cfg>auto-completion.show</@s.cfg>',
            sort: '<@s.cfg>auto-completion.sort</@s.cfg>',
            <#-- 
            We are not reading from the collection/profile config as we want this to have a value 0
            which the product is prevent us from doing so.  
            length: '<@s.cfg>auto-completion.length</@s.cfg>',  
            -->
            length: 0,
            classes: {
                dataset: "module-search__item"
            }, 
            typeahead: {
                highlight: true,
                <#-- 
                    SDUKP-1762
                    Hint is turned off due to accessibility requirements raised by higher education clients 
                -->
                hint: false
            },   
            datasets:{
                <#list question.getCurrentProfileConfig().get("stencils.auto-completion.datasets")!?split(",") as dataset>
                    ${dataset}: {
                        name: '${question.getCurrentProfileConfig().get("stencils.auto-completion.datasets.${dataset}.name")!}',
                        collection: '${question.getCurrentProfileConfig().get("stencils.auto-completion.datasets.${dataset}.collection")!}',
                        profile: '${question.getCurrentProfileConfig().get("stencils.auto-completion.datasets.${dataset}.profile")!question.profile}',
                        show: '${question.getCurrentProfileConfig().get("stencils.auto-completion.datasets.${dataset}.show")!"10"}'
                        <#if dataset != "organic">
                            , template: {
                                suggestion: document.querySelector('#auto-completion-${dataset}').text
                            }
                        </#if>
                        <#-- 
                            TODO: Figure out how to do popular queries for non-organic channels.
                            Currently, if we use a template, we have trouble setting the header for popular queries and
                            templating the values is difficult.
                            
                            <#if (question.getCurrentProfileConfig().get("stencils.auto-completion.datasets." + dataset + ".popular_queries"))!?has_content>  
                        -->
                        <#-- 
                            Output the config to show popular queries where the search box is focus with no query.
                            Current we only support the organic dataset.
                        -->
                        <#if dataset == "organic" && (question.getCurrentProfileConfig().get("stencils.auto-completion.datasets.organic.popular_queries"))!?has_content>  
                        , 
                            defaultCall: [
                                <#list (question.getCurrentProfileConfig().get("stencils.auto-completion.datasets." + dataset + ".popular_queries")!"")?split(",") as query>
                                    {value: "${query}", label:"${query}"}
                                    <#if query_has_next>,</#if>
                                </#list>
                            ],
                            template: {
                                header: function(context) {
                                    return $('<div>').text(context.query ? 'Suggestions' : 'Popular queries').addClass('tt-category');
                                }
                            }  
                        </#if>                                

                    }<#if dataset_has_next>,</#if>
                </#list>
            }
        });
    </#if>
</#macro>