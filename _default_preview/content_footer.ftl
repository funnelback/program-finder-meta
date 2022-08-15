<#ftl encoding="utf-8"output_format="HTML"/>
<#-- 
    Hardcoded footer which can be used if dynamically getting the 
    footer is not possible.

    The example below is simple a sample and currently not being 
    active used in any Stencil demo.
-->

<footer class="fb-footer">
    <div class="content-wrapper">
        <div class="footer-links">
            <h3 class="footer-links__title">About us</h3>
            <ul class="footer-links__list">
                <li class="footer-links__item">
                    <a href="#" class="footer-links__link">Contact information</a>
                </li>
                <li class="footer-links__item">
                    <a href="#" class="footer-links__link">Our site</a>
                </li>
                <li class="footer-links__item">
                    <a href="#" class="footer-links__link">Meet the team</a>
                </li>
            </ul>
        </div>

        <div class="footer-links">
            <h3 class="footer-links__title">Quick Links</h3>
            <ul class="footer-links__list">
                <li class="footer-links__item">
                    <a href="#" class="footer-links__link">Terms and conditions</a>
                </li>
                <li class="footer-links__item">
                    <a href="#" class="footer-links__link">Privacy</a>
                </li>
                <li class="footer-links__item">
                    <a href="#" class="footer-links__link">Sitemap</a>
                </li>
            </ul>
        </div>

        <div class="footer-links">
            <h3 class="footer-links__title">Connections</h3>
            <ul class="footer-links__list">
                <li class="footer-links__item footer-links__item--icon">
                    <a href="#" class="footer-links__link">
                        <img src="/s/resources/${question.collection.id}/${question.profile}/css/mysource_files/instagram.svg" width="auto" height="auto" alt="Go to instagram">
                    </a>
                </li>
                <li class="footer-links__item footer-links__item--icon">
                    <a href="#" class="footer-links__link">
                        <img src="/s/resources/${question.collection.id}/${question.profile}/css/mysource_files/fb.svg" width="auto" height="auto" alt="Go to FB">
                    </a>
                </li>
                <li class="footer-links__item footer-links__item--icon">
                    <a href="#" class="footer-links__link">
                        <img src="/s/resources/${question.collection.id}/${question.profile}/css/mysource_files/twitter.svg" width="auto" height="auto" alt="Go to twitter">
                    </a>
                </li>
            </ul>
        </div>

    </div>

</footer>
<!-- /.footer -->
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
