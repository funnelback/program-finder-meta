<#ftl encoding="utf-8" output_format="HTML" />

<#macro CartTemplate>
    <script id="cart-template-program-finder" type="text/x-cart-template">
        <td>
            <a href="#" class="module-compare__remove" data-url="{{url}}">Remove</a>
            <figure class="module-compare__bg">
                <img src="https://source.unsplash.com/random/335x192?{{name}}" alt="">
            </figure>
            <span class="module-compare__phrase">{{programDelivery}}</span>
            <h3 class="module-compare__title">{{name}}</h3>
            <p class="module-compare__desc">
                {{desc}}
            </p>
            <a href="{{url}}" class="btn--link">More Details</a>
            <dl class="module-compare__data-list">
                <dt> 
                    Credential type
                </dt>
                <dd> 
                    {{programCredentialType}}
                </dd>
                <dt> 
                    Duration
                </dt>
                <dd> 
                    {{programLengthYears}} years
                </dd>
                <dt> 
                    Delivery method
                </dt>
                <dd> 
                    {{programDelivery}}
                </dd>                                                                      
                <dt> 
                    Department
                </dt>
                <dd> 
                    {{programDepartment}}
                </dd>
                <dt> 
                    Faculty
                </dt>
                <dd> 
                    {{programFaculty}}
                </dd>
            </dl>
        </td>
    </script>
</#macro>
