<#ftl encoding="utf-8" output_format="HTML" />

<#--
    Javascript required to configure concierge
-->
<#macro AutoComplete>
  <#if (question.getCurrentProfileConfig().get("stencils.auto-completion.datasets"))!?has_content>
    jQuery('#query').qc({
        program: '<@s.cfg>auto-completion.program</@s.cfg>',
        alpha: '<@s.cfg>auto-completion.alpha</@s.cfg>',
        show: '<@s.cfg>auto-completion.show</@s.cfg>',
        sort: '<@s.cfg>auto-completion.sort</@s.cfg>',
        length: '<@s.cfg>auto-completion.length</@s.cfg>',
        classes: {
            dataset: "module-search__item",
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
                    suggestion: jQuery('#auto-completion-${dataset}').text()
                  }
                </#if>
            }<#if dataset_has_next>,</#if>
          </#list>
        }
    });
  </#if>
</#macro>