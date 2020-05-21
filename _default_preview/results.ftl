<#ftl encoding="utf-8" output_format="HTML" />

<#macro Result result>
    <article class="search-results__item">
            <#if result.metaData.courseImage??>
                <figure class="search-results__bg">
                    <img src="${result.metaData.courseImage}" alt="${result.title}"/>
                </figure>
            <#else>
                <figure class="search-results__bg">
                    <img src="https://source.unsplash.com/random/335x192?${(result.title)!''?url}" alt="${result.title}"/>
                </figure>
            </#if>
            <div class="search-results__content">
                <h3 class="search-results__title">
                    <a href="${result.clickTrackingUrl}" class="search-results__link">
                        ${result.title} <#if result.metaData.courseNumber??>- ${result.metaData.courseNumber}</#if>
                    </a>
                </h3>
                <p class="search-results__desc">
                    <#if result.metaData.courseDesc??>
                        ${result.metaData.courseDesc}
                    <#else>
                        ${result.summary}
                    </#if>
                </p>
                <div class="search-results__bottom">
                    <span class="search-results__info search-results__info--icon search-results__info--icon-list">
                        <#if result.metaData.courseCredit??>${result.metaData.courseCredit?split("|")?join(" to ")} credits</#if>
                    </span>
                    <div class="search-results__compare">
                        <input type="checkbox" id="compare${result.rank}" name="compare${result.rank}" value="Compare ${question.collection.configuration.value("stencils.I18n.finder_type", "Course")}">
                        <label for="compare${result.rank}">Compare ${question.collection.configuration.value("stencils.I18n.finder_type", "Course")}</label>
                    </div>
                </div>
            </div>
        </article>
</#macro>

<#macro TierBar tierbar>
    <#-- No design in this stencil by default -->
</#macro>

<#macro AutoCompleteTemplate>
    <script id="auto-completion-courses" type="text/x-handlebar-template">
        <div class="module-search__list-item">
            <a href="#" class="module-search__list-link" style="background-image: url('https://source.unsplash.com/random/335x192?{{extra.disp.title}};">
                <span class="module-search__list-text">
                    {{extra.disp.title}}
                    <span class="module-search__list-more">Learn More</span>
                </span>
            </a>
        </div>
    </script>
</#macro>

<#macro CartTemplate>
  <script id="cart-template-membership-association-events-web" type="text/x-handlebar-template">
    <div class="card fb-card--fixed mr-2 mb-2 ">
      {{#if metaData.eventImage}}            
        <img class="card-img-top" alt="Thumbnail for {{title}}" src="{{metaData.eventImage}}" /> 
      {{else}}
        <img class="card-img-top" alt="Thumbnail for {{title}}" src="https://source.unsplash.com/random/335x192?{{title}}"> 
      {{/if}}

      <div class="card-body fb-card__body">                
        <#-- Summary section containing the description and key details of the document -->
        <div class="fb-card__summary">
          <div class="card-title">          
            <h6>
              <a href="{{indexUrl}}">
                {{#if title}} 
                  {{title}}  
                {{/if}}
              </a>
            </h6>            
          </div>

          {{#if metaData.eventLocation}} 
            <div class="card-text truncate-text">
              <div class="mb-1"> {{metaData.eventLocation}} </div>
            </div>
          {{/if}}

          {{#if summary}}
            <p class="text-muted card-text">
              {{#truncate 255}}
                {{summary}}
              {{/truncate}}
            </p>
          {{/if}}

          {{#if metaData.jobPosted}} 
            <div class="card-text mb-3">
              <div class="small">
                <span>
                  Posted: 
                </span>
                <span class="text-muted">
                  {{metaData.jobPosted}}
                </span>
              </div>
            </div>
          {{/if}}
        </div>   

        <#-- Additional information such as metadata -->
        <div class="fb-card__additional-info">
          <hr class="mt-3 mb-3" />

          <div class="card-text mb-5">
            <p class="small text-muted">
              Additional information
            </p>

            <#-- The card design supports up to 3 metadata fields -->
            {{#if metaData.eventPricingStandardMember}}
              <div class="truncate-text">
                <div>Member Pricing</div>
                <div class="fb-job__email truncate-text text-muted small">
                  {{metaData.eventPricingStandardMember}}
                </div>
              </div>
            {{/if}}


            {{#if metaData.eventPricingStandardNonMember}}
              <div class="truncate-text">
                <div>Non-member pricing</div>
                <div class="fb-job__email truncate-text text-muted small">
                  {{metaData.eventPricingStandardNonMember}}
                </div>
              </div>
            {{/if}}
          </div>
        </div>
        
        <#-- Key call to actions (CTA) -->
        <div class="fb-card__actions"> 
          <a href="#" class="card-link fb-card__actions__fb-link mt-4" data-toggle="modal" data-target="#signupModal" >REGISTER</a>
          <#--  <a href="#" class="card-link fb-color-secondary">ACTION 2</a>    -->
          <a class="card-link fb-cart__remove fb-card__actions__fb-link"></a>
        </div>
      </div>
    </div>
  </script>

  
</#macro>