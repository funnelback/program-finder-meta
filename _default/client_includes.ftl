<#ftl encoding="utf-8" output_format="HTML" />
<#import "/web/templates/modernui/funnelback.ftl" as fb />

<#--
  Includes client-specific HTML header (for CSS, JS links)
-->
<#macro HTMLHeader>
  <@ClientInclude elementName="html_header" />
</#macro>

<#--
  Includes client-specific HTML content header (e.g. banner, menu, ...)
-->
<#macro ContentHeader>
  <@ClientInclude elementName="content_header" />
</#macro>

<#--
  Includes client-specific HTML content footer
-->
<#macro ContentFooter>
  <@ClientInclude elementName="content_footer" />
</#macro>

<#--
  Include client specific content

  Can be included from a remote URL, or from a local template named after the element
  name in the profile folder (e.g. html_header.ftl, content_header.ftl, etc.)

  @param elementName Name of the element to include (e.g. html_header, content_header, etc.)
-->
<#macro ClientInclude elementName>
  <#local profileConfig = question.getCurrentProfileConfig()>

  <#if profileConfig.get("stencils.client_includes.${elementName}.url")??>
    <#-- 
      Attempt to get the expiry and timeout value if specified by the user. This is
      required as all configs returned by the profile come through as string
      whereas we need them as numbers.
    -->
    <#local defaultExpiry = 3600> <#-- seconds -->
    <#local _expiry = getConfigAsNumber(profileConfig, "stencils.client_includes.${elementName}.expiry", defaultExpiry)>

    <#local defaultTimeout = 50 * 1000> <#-- milliseconds -->
    <#local _timeout = getConfigAsNumber(profileConfig, "stencils.client_includes.${elementName}.timeout", defaultTimeout)>

    <@fb.IncludeUrl 
      url=profileConfig.get("stencils.client_includes.${elementName}.url")
      start=profileConfig.get("stencils.client_includes.${elementName}.start")
      end=profileConfig.get("stencils.client_includes.${elementName}.end")
      expiry=_expiry
      convertRelative=(profileConfig.get("stencils.client_includes.${elementName}.relative")!"true")?boolean
      username=profileConfig.get("stencils.client_includes.${elementName}.username")
      password=profileConfig.get("stencils.client_includes.${elementName}.password")
      useragent=profileConfig.get("stencils.client_includes.${elementName}.useragent")
      timeout=_timeout
      cssSelector=profileConfig.get("stencils.client_includes.${elementName}.cssSelector")
      removeByCssSelectors=profileConfig.get("stencils.client_includes.${elementName}.removeByCssSelectors") />
  <#else>
    <#include "/conf/${question.collection.id}/${question.profile!'_default'}/${elementName}.ftl" ignore_missing=true />
  </#if>
</#macro>

<#-- 
  Attempt to get the config as a number. This is
  required as profile config objects returns all things as strings.
-->
<#function getConfigAsNumber profileConfig, key, default>
  <#if (profileConfig.get(key))!?has_content>
    <#return profileConfig.get(key)!?number>
  <#else>
    <#return default>
  </#if>
</#function>

<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
