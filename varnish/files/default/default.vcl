import std;

backend default {
    .host = "localhost";
    .port = "8080";
}

sub vcl_recv {
    # removes all cookies named __utm? (utma, utmb...) - tracking thing
    if (req.http.Cookie) {
        set req.http.Cookie = regsuball(req.http.Cookie, "(^|; ) *__utm.=[^;]+;? *", "\1");
        if (req.http.Cookie == "") {
            remove req.http.Cookie;
        }
    }

    if (req.restarts == 0) {
        if (req.http.x-forwarded-for) {
            set req.http.X-Forwarded-For =
            req.http.X-Forwarded-For + ", " + client.ip;
        } else {
            set req.http.X-Forwarded-For = client.ip;
        }
    }

    if (req.request != "GET" &&
        req.request != "HEAD" &&
        req.request != "PUT" &&
        req.request != "POST" &&
        req.request != "TRACE" &&
        req.request != "OPTIONS" &&
        req.request != "DELETE" &&
        req.request != "PURGE") {
        /* Non-RFC2616 or CONNECT which is weird. */
        return (pipe);
    }

    # we only deal with GET and HEAD by default
    if (req.request != "GET" && req.request != "HEAD") {
        return (pass);
    }

    # normalize url in case of leading HTTP scheme and domain
    set req.url = regsub(req.url, "^http[s]?://[^/]+", "");

    # collect all cookies
    std.collect(req.http.Cookie);

    # static files are always cacheable. remove SSL flag and cookie
    if (req.url ~ "^/(media|js|skin)/.*\.(png|jpg|jpeg|gif|css|js|swf|ico)$") {
        unset req.http.Https;
        unset req.http.Cookie;
    }

    # not cacheable by default
    #if (req.http.Authorization || req.http.Https) {
    if (req.http.Authorization) {
        return (pass);
    }

    # static files are always cacheable. remove SSL flag and cookie
    if (req.url ~ "^/(media|js|skin)/.*\.(png|jpg|jpeg|gif|css|js|swf|ico)$") {
        unset req.http.Https;
        unset req.http.Cookie;
        set req.http.user-agent = "Varnish - static content";
    }

    # do not cache any page from index files
    if (req.url ~ "^/(index)") {
        return (pass);
    }

    # as soon as we have a NO_CACHE cookie pass request
    if (req.http.cookie ~ "NO_CACHE=") {
        return (pass);
    }

    # remove Google gclid parameters
    set req.url = regsuball(req.url,"\?gclid=[^&]+$",""); # strips when QS = "?gclid=AAA"
    set req.url = regsuball(req.url,"\?gclid=[^&]+&","?"); # strips when QS = "?gclid=AAA&foo=bar"
    set req.url = regsuball(req.url,"&gclid=[^&]+",""); # strips when QS = "?foo=bar&gclid=AAA" or QS = "?foo=bar&gclid=AAA&bar=baz"

    call normalize_user_agent;

    return (lookup);
}

sub normalize_user_agent {
    if (req.http.User-Agent ~ "iP(hone|od)|BlackBerry|(m|M)obile|Opera M(obi|ini)") {
        # Mobile devices
        set req.http.User-Agent = "Varnish - Mobile - iPhone iPod BlackBerry Opera Mini Opera Mobi mobile";

    } else if (req.http.User-Agent ~ "iPad|Android|Touch|Silk|Kindle") {
        # Tablets
        # Notes: Android "Mobile" will be caught as a Mobile. "Android" without "Mobile" probably a tablet.
        #        "Touch" will pick up MSIE10 on Surface.
        #        "Silk" is the proxy browser used on Kindle
        set req.http.User-Agent = "Varnish - Tablet - iPad Android Kindle Silk Touch";

    } else if (req.http.User-Agent ~ "MSIE") {
        # In case of IE workarounds
        set req.http.User-Agent = "Varnish - MSIE";

    } else {
        # Default for most browsers, bots, tools, etc.
        # set req.http.User-Agent = req.http.User-Agent ;
        set req.http.User-Agent = "Varnish - normalized User-Agent";
    }
}
