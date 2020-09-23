<#ftl encoding="utf-8" output_format="HTML" />

<#macro TierBar tierbar>
    <#-- No design in this stencil by default -->
</#macro>


<#macro CartTemplate>
    <script id="cart-template-program-finder" type="text/x-cart-template">
        <td>
            <a href="#" class="module-compare__remove" data-url="{{url}}">Remove</a>
            <figure class="module-compare__bg">
                <img src="https://source.unsplash.com/random/335x192?{{name}}" alt="">
            </figure>
            <span class="module-compare__phrase">{{id}}</span>
            <h3 class="module-compare__title">{{name}}</h3>
            <p class="module-compare__desc">
                {{desc}}
            </p>
            <a href="{{url}}" class="btn--link">More Details</a>
        </td>
    </script>
</#macro>
