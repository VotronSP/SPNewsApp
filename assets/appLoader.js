// Create a newsApp and include 'ngSharePoint' as a dependency
var newsApp = angular.module('newsApp', ['ngSharePoint', 'ngRoute', 'ngSanitize']);

// ... add a main controller and inject SharePoint service
newsApp.controller('main', ['$scope', 'SharePoint', function($scope, SharePoint) {

    // Get the current web and check if List already exists
    SharePoint.getCurrentWeb().then(function(web) {
        checkIfNewsListExists();
        
        // Get the MantechIcons list
        web.getList('News Articles').then(function(list) {

            // Get items ...
            list.getListItems().then(function(items) {

                $scope.newsArticles = items;
            });
        });
    });
}]);

// Check if News Articles List Exists - Create if it doesnt
function checkIfNewsListExists() {

    // Get the Current Site API
    var context = SP.ClientContext.get_current();
    var web = context.get_web();

    // Look for a "News Articles" list
    try {

        var scope = new SP.ExceptionHandlingScope(context);
        var scopeStart = scope.startScope();

        var scopeTry = scope.startTry();
        var list = web.get_lists().getByTitle("News Articles");
        context.load(list);
        scopeTry.dispose();

        var scopeCatch = scope.startCatch();

        console.log("A list can be created here - User Permissions allowed");

        scopeCatch.dispose();

        var scopeFinally = scope.startFinally();
        scopeFinally.dispose();
        scopeStart.dispose()

        // If a List does not Exist, run the function to create one, else, continue with loading the app
        context.executeQueryAsync(function() {
            if (scope.get_hasException() == true) {
                console.log("Does not exists - Lets Create it")
                createNewsArticlesList();

            } else {
                console.log("Exists - Continue and Load News App");
            }
        }, function() {});
    } catch (ex) {
        console.log(ex.message);
    }
}

// Create the List if it doesn't exist
var listTitle = "News Articles";

function createNewsArticlesList() {
    var context = new SP.ClientContext.get_current();
    var web = context.get_web();
    this.listCollection = web.get_lists();

    var list = new SP.ListCreationInformation();
    list.set_title(listTitle);
    list.set_templateType(100);
    this.listCollection.refreshLoad();
    this.listCollection.add(list);
    context.load(this.listCollection);
    context.executeQueryAsync(Function.createDelegate(this, this.createListSuccess), Function.createDelegate(this, this.createListFailed));
}

// Upon creating a list successfully, lets add our fields for the news app
function createListSuccess() {

    var dateField =
        '<Field Type="DateTime" DisplayName="Date" Name="Date" Description="Please enter the Article Publishing Date. This date will be used to filter out the new and old articles in order." Required="True" />';
    var linkField =
        '<Field Type="URL" DisplayName="Link" Name="Link" Description="If you would like, you can link to an external page within Pulse or an external page that is related to your article." Required="True" />';
    var imageField =
        '<Field Type="URL" DisplayName="Image" Name="Image" Description="Insert an Image URL to be displayed as the Article Main Image. Any sized image will work." Required="True" Format="Image" />';
    var bodyField =
        '<Field Type="Note" DisplayName="Body" Name="Body" Description="The articles body is HTML-friendly! Add images, links, iFrames, you name it. The Body of the article is yours to customize." NumLines="8" RestrictedMode="TRUE" RichText="TRUE" RichTextMode="FullHtml" AppendOnly="TRUE" />';
    var publishedField =
        '<Field Type="Boolean" DisplayName="Published" Name="Published" Decription="By checking this box, your article becomes live. Publish your article if you are ready for it to be displayed."><Default>1</Default></Field>';

    var clientContext = new SP.ClientContext();
    var targetList = clientContext.get_web().get_lists().getByTitle(listTitle);
    fieldCollection = targetList.get_fields();
    fieldCollection.addFieldAsXml(dateField, true, SP.AddFieldOptions.addToDefaultContentType);
    fieldCollection.addFieldAsXml(linkField, true, SP.AddFieldOptions.addToDefaultContentType);
    fieldCollection.addFieldAsXml(imageField, true, SP.AddFieldOptions.addToDefaultContentType);
    fieldCollection.addFieldAsXml(bodyField, true, SP.AddFieldOptions.addToDefaultContentType);
    fieldCollection.addFieldAsXml(publishedField, true, SP.AddFieldOptions.addToDefaultContentType);
    clientContext.load(fieldCollection);
    clientContext.executeQueryAsync(Function.createDelegate(this, this.onAddFieldsSucceeded), Function.createDelegate(this, this.onAddFieldsFailed));
}

function onAddFieldsSucceeded() {
    console.log('List Created Successfully');
    alert("The App has been installed successfully, to see your app please save your page and continue.")
}


// Load NewsApp Settings
$(window).load(function(e) {
    setTimeout(function() {
        $('#si_NewsApp').lc_swift_box({
            height: 345,
            cache_news: true,
            max_news: 10,
            news_per_time: 3,
            nav_arrows: 'side',
            theme: 'light',
            boxed_news: true,
            layout: 'horizontal',
            buttons_position: 'top',
            img_behavior: 'expand',
            exp_main_img_pos: 'inside',
            read_more_btn: false,
            social_share: false,
            carousel: true,
            expandable_news: true,
            scroll_exp_elem: true,
            autoplay: true,
            slideshow_time: 4500,
        });
        var $yourUl = $("#si_NewsApp");
        $yourUl.css("display", $yourUl.css("display") === 'none' ? '' : 'none');
        $('#loadingArticles').remove();
        $('#si_NewsApp').show();
    }, 1500);

});

$.ajaxPrefilter(function(options, originalOptions, jqXHR) {
    options.async = true;
});