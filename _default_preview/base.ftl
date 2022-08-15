<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
    A collections of common elements used in search implementations.

    If a particular feature requires multiple presentations or is made
    up more than one macro, consider refactoring the feature to 
    its own freemarker template.
-->

<#-- 
    Creates a valid CSS ID by replacing all special characters (except for hypens)
    with underscores (_). Note mulitple underscores will be replace by 1 underscore.

    @param input A string which is to be converted to a valid CSS ID.
-->
<#function getCssID input="">
    <#return (input)!?replace('[^A-Za-z0-9-]+', '_', 'r')>
</#function>

<#--
    Create html inputs based on the parameters pass on with search. 
    Useful to retaining the user's selections when submitting to forms.
-->
<#macro inputsForForms allowList=[] denyList=[] alwaysIgnore=['HTTP_HOST', 'REMOTE_ADDR', 'REQUEST_URI', 'REQUEST_URL', 'REMOTE_USER']>    
    <#list question.inputParameters as key, value>
        <#if allowList!?has_content>
            <#--  Output only the fields which are in the allow list  -->
            <#if !alwaysIgnore?seq_contains(key) && allowList?seq_contains(key)>
                <input type="hidden" name="${key}" value="${value!?first}">
            </#if>
        <#elseif denyList!?has_content>
            <#--  Output the fields which do not appear in the denyList -->
            <#if !alwaysIgnore?seq_contains(key) && !denyList?seq_contains(key)>
                <input type="hidden" name="${key}" value="${value!?first}">
            </#if>
        <#else>
            <#--  Output all input parameters in the scenario where no allow or deny lists are supplied  -->
            <#if !alwaysIgnore?seq_contains(key)>
                <input type="hidden" name="${key}" value="${value!?first}">
            </#if>
        </#if>
    </#list>
</#macro>




