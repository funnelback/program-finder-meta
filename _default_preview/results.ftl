<#ftl encoding="utf-8" output_format="HTML" />

<#-- Default template used for the cart  -->
<#macro CartTemplate>
    <!-- results.CartTemplate -->
    <script id="cart-template-default" type="text/x-handlebars-template">
        <td>
            <a href="#" class="module-compare__remove" data-url="{{indexUrl}}">Remove</a>

            {{#if metaData.image}}
                <figure class="module-compare__bg">
                    <img src="{{metaData.image}}" alt="{{title}}">                
                </figure>                
            {{else}}
                <img src="https://source.unsplash.com/random/335x192?{{title}}" alt="{{title}}">
            {{/if}}

            <#-- Display a tab on top of the image -->
            <#--  
            <span class="module-compare__phrase">

            </span>  
            -->
            
            {{#if title}} 
                <h3 class="module-compare__title">{{title}}</h3>
            {{/if}}

            {{#if metaData.c}}  
                <p class="module-compare__desc">
                    {{metaData.c}}
                </p>
            {{/if}} 
            
            <a href="{{indexUrl}}" class="btn--link">More Details</a>

            <#--  Display the metadata  -->
            <#--
            <dl class="module-compare__data-list">
                <dt> 
                    Label
                </dt>
                <dd> 
                    Value
                </dd>
            </dl>  
            -->
        </td>
    </script>
</#macro>