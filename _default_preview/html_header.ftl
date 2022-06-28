<#ftl encoding="utf-8" output_format="HTML" />
<#-- Outputs all the css and related libraries used for the implementation -->

<#-- Template specific code. Avoid changing these files if possible -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,600;0,700;0,800;1,400&display=swap" rel="stylesheet">

<link href="https://unpkg.com/normalize.css@8.0.1/normalize.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<#-- Stencil's theme -->
<link href="${ContextPath}/resources/${question.collection.id}/${question.profile}/themes/stencils/main.css" rel="stylesheet">

<#-- 
    Presentation logic specific to this Stencil. More often that not, this will eventually 
    be refactored into the Stencils Design System.

-->
<link rel="stylesheet" href="${ContextPath}/resources/${(question.collection.id)!}/${(question.profile)!}/css/stencils.css">

<#-- Presentation logic specific for demonstrations. -->
<#if ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE">
    <link rel="stylesheet" href="${ContextPath}/resources/${(question.collection.id)!}/${(question.profile)!}/css/showcase.css">
</#if>

<#-- 
    Implementation specific style changes. It is recommended that changes to the 
    presentation of this implementation should be made here.
-->
<link rel="stylesheet" href="${ContextPath}/resources/${(question.collection.id)!}/${(question.profile)!}/css/customer.css">


