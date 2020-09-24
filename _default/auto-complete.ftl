<#--
    Javascript required to configure concierge
-->
<#macro AutoComplete>
  <#if question.collection.configuration.hasValue("stencils.auto-completion.datasets")>
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
          <#list question.collection.configuration.value("stencils.auto-completion.datasets")!?split(",") as dataset>
            ${dataset}: {
                name: '${question.collection.configuration.value("stencils.auto-completion.datasets.${dataset}.name")!}',
                collection: '${question.collection.configuration.value("stencils.auto-completion.datasets.${dataset}.collection")!}',
                profile: '${question.collection.configuration.value("stencils.auto-completion.datasets.${dataset}.profile")!question.profile}',
                show: '${question.collection.configuration.value("stencils.auto-completion.datasets.${dataset}.show")!"10"}'
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