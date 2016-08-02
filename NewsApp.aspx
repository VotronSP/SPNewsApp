
<!-- 
    The SI Group SharePoint News App proved users with the ability to create News Articles and Display them in a webPart
    News App developed by: Ermal Shkullaku

    Version 2.0.0
    Updates in this Version: 
    - Added ability to Install App as a Web Part and Install it's dependencies
    - Added multifunctional list with fields
 -->
    <!-- //////////////////////////////////////////////// -->
    <!-- REQUIRED PLUGINS/FRAMEWORKS/ELEMENTS -->
    <link rel="stylesheet" href="/SiteAssets/JSApps/GlobalNewsApp/assets/css_assets/swift-box-layout.min.css" />
    <link rel="stylesheet" href="/Style Library/css/animate.css" />
    <script type="text/javascript" src="/SiteAssets/JSApps/GlobalNewsApp/assets/swift-box.min.js"></script>
    <script type="text/javascript" src="/SiteAssets/JSApps/GlobalNewsApp/assets/angular.min.js"></script>
    <script type="text/javascript" src="/SiteAssets/JSApps/GlobalNewsApp/assets/ng-sharepoint.js"></script>
    <script type="text/javascript" src="/SiteAssets/JSApps/GlobalNewsApp/assets/angular-resource.min.js"></script>
    <script type="text/javascript" src="/SiteAssets/JSApps/GlobalNewsApp/assets/angular-route.min.js"></script>
    <script type="text/javascript" src="/SiteAssets/JSApps/GlobalNewsApp/assets/angular-sanitize.min.js"></script>
    <script type="text/javascript" src="/SiteAssets/JSApps/GlobalNewsApp/assets/appLoader.js"></script>   
    <!-- //////////////////////////////////////////////// -->
    <!-- //////////////////////////////////////////////// -->

<!-- Inject Angular and Display the Loading screen -->
<!-- //////////////////////////////////////////////// -->
  <center>
    <div id="loadTheContent" ng-app="newsApp" class="ng-scope">
        <div ng-controller="main">
            <ng-view></ng-view>
                <div ng-if="newsArticles.length !== 0" id="loadingArticles">
                    <center>
                        <ul style="padding-left: 5px;">
                            <p style="color: #000; text-decoration: none; font-size: 20px;">
                                <i class="fa fa-spinner fa-spin fa-2x fa-fw" style="color:#72b1c8;"></i>
                                <br>
                                <span style="color:#72b1c8;">Loading Articles... Please Wait.</span>
                            </p>
                        </ul>
                    </div>
<!-- //////////////////////////////////////////////// -->

                <!-- Load the NO ARTICLES FOUND module if NO ARTICLES ARE FOUND -->
                <!-- //////////////////////////////////////////////// -->
                <center>
                <div ng-if="newsArticles.length === 0">
                    <div id="si_NewsApp" style="display:none;">
                        <!-- START ARTICLE -->
                        <div class="nb_news_wrap" exp_img_h="auto">
                            <!-- CHANGE ARTICLE DATE/TIME START-->
                            <article datetime="No Article Found">
                                <!-- CHANGE ARTICLE DATE/TIME END-->

                                <!-- CHANGE ARTICLE TITLE START-->
                                <header>No Articles Found</header>
                                <!-- CHANGE ARTICLE TITLE END -->

                                <!-- CHANGE ARTICLE IMAGE START -->
                                <img src="http://media-s3-us-east-1.ceros.com/dallas-cowboys/images/2016/04/13/7ee560b043456e8f467bc9c025ca9fab/3-document-article-news-newspaper-512.png"></img>
                                <!-- CHANGE ARTICLE IMAGE END -->

                                <!-- CHANGE ARTICLE BODY START -->
                                <section>

                                    <!-- CHANGE ARTICLE DATE ON BODY START -->
                                    <span class="lcnb_author">No Articles Found - </span>
                                    <!-- CHANGE ARTICLE DATE ON BODY END -->

                                    <!-- CHANGE ARTICLE DETAILS START -->
                                    Create a New Article by clicking on the link below! This link will take you directly to a page where you can add your own article by filling in the required fields.</a>

                                    <!-- CHANGE ARTICLE DETAILS END -->

                                </section>
                                <!-- CHANGE ARTICLE BODY END -->

                                <!-- CHANGE ARTICLE READ MORE LINK START -->
                                <a ng-href="#" class="lcnb_inline_link">Read More</a>
                            </article>
                            <!-- CHANGE ARTICLE READ MORE LINK END -->
                            <!-- END ARTICLE -->
                        </div>
                    </div>
                </div>
            </center>    
            <!-- //////////////////////////////////////////////// -->   

            <!-- Load App and angular if Articles are FOUND -->
            <!-- //////////////////////////////////////////////// -->
			<center>
                <div ng-if="newsArticles.length !== 0" id="si_NewsApp" style="display:none;">
                    <!-- START ARTICLE -->
                    <div class="nb_news_wrap" exp_img_h="auto">
                        <div ng-repeat="item in newsArticles | filter: {'Published': true}: true | orderBy : '-ID'">
                            <!-- CHANGE ARTICLE DATE/TIME START-->
                            <article datetime="{{item.Date}}">
                                <!-- CHANGE ARTICLE DATE/TIME END-->

                                <!-- CHANGE ARTICLE TITLE START-->
                                <header>{{item.Title}}</header>
                                <!-- CHANGE ARTICLE TITLE END -->

                                <!-- CHANGE ARTICLE IMAGE START -->
                                <img ng-src={{item.Image.Url}}></img>
                                <!-- CHANGE ARTICLE IMAGE END -->

                                <!-- CHANGE ARTICLE BODY START -->
                                <section>

                                    <!-- CHANGE ARTICLE DATE ON BODY START -->
                                    <span class="lcnb_author">{{item.Title}}</span>
                                    <!-- CHANGE ARTICLE DATE ON BODY END -->

                                    <!-- CHANGE ARTICLE DETAILS START -->
                                    <div ng-bind-html="item.Body" | unsafe></div>
                                    <!-- CHANGE ARTICLE DETAILS END -->

                                </section>
                                <!-- CHANGE ARTICLE BODY END -->

                                <!-- CHANGE ARTICLE READ MORE LINK START -->
                                <a ng-href="{{item.Link.Url}}" class="lcnb_inline_link">Read More</a>
                            </article>
                            <!-- CHANGE ARTICLE READ MORE LINK END -->
                            <!-- END ARTICLE -->
                        </div> 
                    </div> 
                </div> 
                </center>   
                </div>  
                   <a href="../Lists/News%20Articles/NewForm.aspx" class="animated zoomIn" style="font-size: 14px; color: #000; text-decoration: none;"><i class="fa fa-newspaper-o" aria-hidden="true"></i> Create an Article </a>
                </div>
                </center>
                <!-- //////////////////////////////////////////////// -->           