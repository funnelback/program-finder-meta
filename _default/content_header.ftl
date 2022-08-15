<#ftl encoding="utf-8"output_format="HTML"/>

<#-- 
    Hardcoded header which can be used if dynamically getting the 
    header is not possible.

    The example below is simple a sample and currently not being 
    active used in any Stencil demo.
-->
<!--noindex-->
<header class="fb-header">
    <section class="header-top">
        <div class="header-top__wrapper content-wrapper">
            <div class="header-top-links">
                <ul class="header-top-links__list">
                    <li class="header-top-links__item">
                        <a href="#" class="header-top-links__link">Contact us</a>
                    </li>
                </ul>
                <ul class="header-top-links__list  header-top-links__list--icon">
                    <li class="header-top-links__item">
                        <a href="#" class="header-top-links__link header-top-links__link--icon header-top-links__link--icon-user">
                            Alumni</a>
                    </li>
                    <li class="header-top-links__item">
                        <a href="#" class="header-top-links__link header-top-links__link--icon header-top-links__link--icon-star">
                            My account
                        </a>
                    </li>
                    <li class="header-top-links__item">
                        <a href="#" class="header-top-links__link header-top-links__link--icon header-top-links__link--icon-case">
                            Library
                        </a>
                    </li>
                </ul>
            </div>

        </div>
    </section>

    <div class="fb-header-bottom content-wrapper">
        <div class="fb-header-left">
            <div class="header-logo">
                <a class="header-logo__link" href="/s/search.html?collection=${(question.collection.id)!}&profile=${(question.profile)!}">
                    <img class="header-logo__img" src="/s/resources/${question.collection.id}/${question.profile}/img/funnelback-horizontal-dark.svg" width="auto" height="auto" alt="Home"></a>
                </div>

            </div>
            <div class="fb-header-right">
                <div class="header-links">
                    <ul class="header-links__list">
                        <li class="header-links__item">
                            <a href="/s/search.html?collection=${(question.collection.id)!}&profile=${(question.profile)!}" class="header-links__link">Home</a>
                        </li>
                        <li class="header-links__item">
                            <a href="#" class="header-links__link">Study</a>
                        </li>
                        <li class="header-links__item">
                            <a href="#" class="header-links__link">Research and Innovation</a>
                        </li>
                        <li class="header-links__item">
                            <a href="#" class="header-links__link">Industry and Community</a>
                        </li>

                    </ul>
                </div>

                <div class="header-search">
                    <a href="#" class="header-search__link">
                        <span class="sr-only">Search</span>
                    </a>
                </div>

                <a href="#" class="header-hamburger">
                    <span class="header-hamburger__button">
                        <span>
                            <span class="sr-only">More</span>
                        </span>
                    </span>
                </a>

            </div>
        </div>

    </header>



<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
