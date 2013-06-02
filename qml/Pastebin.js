/*
 * Minimal pastebin.com uploader.
 *
 * NOTE: yYou your own API KEY when you login to pastebin,
 * please dont use mine in your apps.
 */

var PASTEBIN_API_KEY = "83072f39be4d5f4f7420b7c6776f09e6";
var PASTEBIN_API_URL = "http://pastebin.com/api/api_post.php";


function post(message, title, on_success, on_failure)
{
    var args = new Array();

    args.push( "api_dev_key=" + PASTEBIN_API_KEY);
    args.push( "api_option=paste");
    args.push( "api_paste_code=" + encodeURIComponent( message));
    args.push( "api_paste_name=" + encodeURIComponent( title));
    args.push( "api_paste_private=1") // not litsed
    args.push( "api_paste_expire_date=1M"); // expires in a month

    var req = new XMLHttpRequest();
    req.open("post", PASTEBIN_API_URL);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    req.onreadystatechange = function() {
        if(req.readyState == XMLHttpRequest.DONE) {
            var response = req.responseText;
            if(response.toLowerCase().indexOf("bad") != 0) // "Bad xxx: yyy"
                on_success(response);
            else
                on_failure(response);
        }
    }

    req.send(args.join('&'));
}
