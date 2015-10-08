/*  ::

    :: Theme         : Talisman
    :: Theme URI     : http://funcoders.com/templates/Talisman

    :: File          : js/theme.js
    :: Name          : Main js file
    :: Version       : 1.1

:: */
var Talisman = {

    extend : function() {

        /*  :: Extentions to jQuery :: */
        $.browser         = {};
        $.browser.msie    = false;
        $.browser.version = 0;
        if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
            $.browser.msie = true;
            $.browser.version = RegExp.$1;
        }
        $.mobile       = {};
        $.mobile.is    = (/android|webos|iphone|ipad|ipod|blackberry|iemobile|opera mini/i.test(navigator.userAgent.toLowerCase()));
        $.mobile.width = 992;

        if ($.mobile.is) {
            $.browser.scroll = 0;
        } else {
            $('body').append('<div id="scroll-width" style="height:100px;width:100px;visible:hidden;position:fixed;z-index:-9999999" />');
            $.browser.scroll =  $('#scroll-width').get(0).clientWidth;
            $('#scroll-width').css('overflow-y', 'scroll');
            $.browser.scroll -= $('#scroll-width').get(0).clientWidth;
            $('#scroll-width').remove();
        }

        /*  :: Extentions to Mediaelements :: */
        $.extend(mejs.MepDefaults, {
            audioVolume: 'horizontal',
            videoVolume: 'horizontal'
        });

        /*  :: Extentions to jQuery functions :: */
        $.fn.resizeComplete = function(func, ms, method) {

            var timer = 0;
            this.resize(function() {
                clearTimeout(timer);
                timer = setTimeout(func, ms);
            });

            if (method === 'load') {
                this.on('load', func);
            } else if (method === 'ready') {
                func();
            }
        };

        $.fn.isOnScreen = function(f, ratio) {

            var $that   = this,
                win     = $(window);

            ratio = (ratio !== undefined) ? ratio : 0.9;

            win.scroll(function() {

                var viewport = {
                    top : win.scrollTop(),
                    left : win.scrollLeft()
                };

                viewport.right = viewport.left + win.width() * ratio;
                viewport.bottom = viewport.top + win.height() * ratio;

                return $that.each(function() {

                    if ($(this).data('isOnScreen') === undefined) {

                        var bounds = $(this).offset();
                        bounds.right = bounds.left + $(this).outerWidth();
                        bounds.bottom = bounds.top + $(this).outerHeight();

                        if (!(viewport.right < bounds.left || viewport.left > bounds.right || viewport.bottom < bounds.top || viewport.top > bounds.bottom - $(this).outerHeight())) {

                            f.call($(this));
                            $(this).data('isOnScreen', true);

                        }
                    }
                });

            });
        };

        $.fn.onTop = function(f) {

            if ($(this).scrollTop() > 0) {
                $('html, body').animate({
                    scrollTop: 0
                }, 300, 'easeOutQuad');

                setTimeout(f, 600);
            } else {
                f();
            }
        };

        $.fn.getProperty = function(name) {

            var id;
            $.each(this, function(index, value) {
                if (value === name) {
                    id = index;
                    return false;
                }
            });

            return id;
        };

        $.fn.hasClasses = function(selector) {
            var classNamesRegex = new RegExp("( " + selector.replace(/ +/g, "").replace(/,/g, " | ") + " )"),
                rclass = /[\n\t\r]/g,
                i = 0,
                l = this.length;
            for (i; i < l; i += 1) {
                if (this[i].nodeType === 1 && classNamesRegex.test((" " + this[i].className + " ").replace(rclass, " "))) {
                    return true;
                }
            }
            return false;
        };
    },
    /*jsl:ignore*/
    addons : function() {

        /* :: waitForImages :: */
        (function(e){var t="waitForImages";e.waitForImages={hasImageProperties:["backgroundImage","listStyleImage","borderImage","borderCornerImage"]},e.expr[":"].uncached=function(t){if(!e(t).is('img[src!=""]'))return!1;var n=new Image;return n.src=t.src,!n.complete},e.fn.waitForImages=function(n,r,i){var s=0,o=0;e.isPlainObject(arguments[0])&&(n=arguments[0].finished,r=arguments[0].each,i=arguments[0].waitForAll),n=n||e.noop,r=r||e.noop,i=!!i;if(!e.isFunction(n)||!e.isFunction(r))throw new TypeError("An invalid callback was supplied.");return this.each(function(){var u=e(this),a=[],f=e.waitForImages.hasImageProperties||[],l=/url\(\s*(['"]?)(.*?)\1\s*\)/g;i?u.find("*").andSelf().each(function(){var t=e(this);t.is("img:uncached")&&a.push({src:t.attr("src"),element:t[0]}),e.each(f,function(e,n){var r=t.css(n),i;if(!r)return!0;while(i=l.exec(r))a.push({src:i[2],element:t[0]})})}):u.find("img:uncached").each(function(){a.push({src:this.src,element:this})}),s=a.length,o=0,s===0&&n.call(u[0]),e.each(a,function(i,a){var f=new Image;e(f).bind("load."+t+" error."+t,function(e){o++,r.call(a.element,o,s,e.type=="load");if(o==s)return n.call(u[0]),!1}),f.src=a.src})})}})(jQuery);

        /* :: jQuery Easing v1.3 - http://gsgd.co.uk/sandbox/jquery/easing/ :: */
        jQuery.easing.jswing=jQuery.easing.swing;jQuery.extend(jQuery.easing,{def:"easeOutQuad",swing:function(e,f,a,h,g){return jQuery.easing[jQuery.easing.def](e,f,a,h,g)},easeInQuad:function(e,f,a,h,g){return h*(f/=g)*f+a},easeOutQuad:function(e,f,a,h,g){return -h*(f/=g)*(f-2)+a},easeInOutQuad:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f+a}return -h/2*((--f)*(f-2)-1)+a},easeInCubic:function(e,f,a,h,g){return h*(f/=g)*f*f+a},easeOutCubic:function(e,f,a,h,g){return h*((f=f/g-1)*f*f+1)+a},easeInOutCubic:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f*f+a}return h/2*((f-=2)*f*f+2)+a},easeInQuart:function(e,f,a,h,g){return h*(f/=g)*f*f*f+a},easeOutQuart:function(e,f,a,h,g){return -h*((f=f/g-1)*f*f*f-1)+a},easeInOutQuart:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f*f*f+a}return -h/2*((f-=2)*f*f*f-2)+a},easeInQuint:function(e,f,a,h,g){return h*(f/=g)*f*f*f*f+a},easeOutQuint:function(e,f,a,h,g){return h*((f=f/g-1)*f*f*f*f+1)+a},easeInOutQuint:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f*f*f*f+a}return h/2*((f-=2)*f*f*f*f+2)+a},easeInSine:function(e,f,a,h,g){return -h*Math.cos(f/g*(Math.PI/2))+h+a},easeOutSine:function(e,f,a,h,g){return h*Math.sin(f/g*(Math.PI/2))+a},easeInOutSine:function(e,f,a,h,g){return -h/2*(Math.cos(Math.PI*f/g)-1)+a},easeInExpo:function(e,f,a,h,g){return(f==0)?a:h*Math.pow(2,10*(f/g-1))+a},easeOutExpo:function(e,f,a,h,g){return(f==g)?a+h:h*(-Math.pow(2,-10*f/g)+1)+a},easeInOutExpo:function(e,f,a,h,g){if(f==0){return a}if(f==g){return a+h}if((f/=g/2)<1){return h/2*Math.pow(2,10*(f-1))+a}return h/2*(-Math.pow(2,-10*--f)+2)+a},easeInCirc:function(e,f,a,h,g){return -h*(Math.sqrt(1-(f/=g)*f)-1)+a},easeOutCirc:function(e,f,a,h,g){return h*Math.sqrt(1-(f=f/g-1)*f)+a},easeInOutCirc:function(e,f,a,h,g){if((f/=g/2)<1){return -h/2*(Math.sqrt(1-f*f)-1)+a}return h/2*(Math.sqrt(1-(f-=2)*f)+1)+a},easeInElastic:function(f,h,e,l,k){var i=1.70158;var j=0;var g=l;if(h==0){return e}if((h/=k)==1){return e+l}if(!j){j=k*0.3}if(g<Math.abs(l)){g=l;var i=j/4}else{var i=j/(2*Math.PI)*Math.asin(l/g)}return -(g*Math.pow(2,10*(h-=1))*Math.sin((h*k-i)*(2*Math.PI)/j))+e},easeOutElastic:function(f,h,e,l,k){var i=1.70158;var j=0;var g=l;if(h==0){return e}if((h/=k)==1){return e+l}if(!j){j=k*0.3}if(g<Math.abs(l)){g=l;var i=j/4}else{var i=j/(2*Math.PI)*Math.asin(l/g)}return g*Math.pow(2,-10*h)*Math.sin((h*k-i)*(2*Math.PI)/j)+l+e},easeInOutElastic:function(f,h,e,l,k){var i=1.70158;var j=0;var g=l;if(h==0){return e}if((h/=k/2)==2){return e+l}if(!j){j=k*(0.3*1.5)}if(g<Math.abs(l)){g=l;var i=j/4}else{var i=j/(2*Math.PI)*Math.asin(l/g)}if(h<1){return -0.5*(g*Math.pow(2,10*(h-=1))*Math.sin((h*k-i)*(2*Math.PI)/j))+e}return g*Math.pow(2,-10*(h-=1))*Math.sin((h*k-i)*(2*Math.PI)/j)*0.5+l+e},easeInBack:function(e,f,a,i,h,g){if(g==undefined){g=1.70158}return i*(f/=h)*f*((g+1)*f-g)+a},easeOutBack:function(e,f,a,i,h,g){if(g==undefined){g=1.70158}return i*((f=f/h-1)*f*((g+1)*f+g)+1)+a},easeInOutBack:function(e,f,a,i,h,g){if(g==undefined){g=1.70158}if((f/=h/2)<1){return i/2*(f*f*(((g*=(1.525))+1)*f-g))+a}return i/2*((f-=2)*f*(((g*=(1.525))+1)*f+g)+2)+a},easeInBounce:function(e,f,a,h,g){return h-jQuery.easing.easeOutBounce(e,g-f,0,h,g)+a},easeOutBounce:function(e,f,a,h,g){if((f/=g)<(1/2.75)){return h*(7.5625*f*f)+a}else{if(f<(2/2.75)){return h*(7.5625*(f-=(1.5/2.75))*f+0.75)+a}else{if(f<(2.5/2.75)){return h*(7.5625*(f-=(2.25/2.75))*f+0.9375)+a}else{return h*(7.5625*(f-=(2.625/2.75))*f+0.984375)+a}}}},easeInOutBounce:function(e,f,a,h,g){if(f<g/2){return jQuery.easing.easeInBounce(e,f*2,0,h,g)*0.5+a}return jQuery.easing.easeOutBounce(e,f*2-g,0,h,g)*0.5+h*0.5+a}});

        /* :: SmoothScroll for websites v1.2.1 :: */
        (function(){function c(){var e=false;if(e){N("keydown",y)}if(t.keyboardSupport&&!e){T("keydown",y)}}function h(){if(!document.body)return;var e=document.body;var i=document.documentElement;var a=window.innerHeight;var f=e.scrollHeight;o=document.compatMode.indexOf("CSS")>=0?i:e;u=e;c();s=true;if(top!=self){r=true}else if(f>a&&(e.offsetHeight<=a||i.offsetHeight<=a)){i.style.height="auto";setTimeout(refresh,10);if(o.offsetHeight<=a){var l=document.createElement("div");l.style.clear="both";e.appendChild(l)}}if(!t.fixedBackground&&!n){e.style.backgroundAttachment="scroll";i.style.backgroundAttachment="scroll"}}function m(e,n,r,i){i||(i=1e3);k(n,r);if(t.accelerationMax!=1){var s=+(new Date);var o=s-v;if(o<t.accelerationDelta){var u=(1+30/o)/2;if(u>1){u=Math.min(u,t.accelerationMax);n*=u;r*=u}}v=+(new Date)}p.push({x:n,y:r,lastX:n<0?.99:-.99,lastY:r<0?.99:-.99,start:+(new Date)});if(d){return}var a=e===document.body;var f=function(s){var o=+(new Date);var u=0;var l=0;for(var c=0;c<p.length;c++){var h=p[c];var v=o-h.start;var m=v>=t.animationTime;var g=m?1:v/t.animationTime;if(t.pulseAlgorithm){g=D(g)}var y=h.x*g-h.lastX>>0;var b=h.y*g-h.lastY>>0;u+=y;l+=b;h.lastX+=y;h.lastY+=b;if(m){p.splice(c,1);c--}}if(a){window.scrollBy(u,l)}else{if(u)e.scrollLeft+=u;if(l)e.scrollTop+=l}if(!n&&!r){p=[]}if(p.length){M(f,e,i/t.frameRate+1)}else{d=false}};M(f,e,0);d=true}function g(e){if(!s){h()}var n=e.target;var r=x(n);if(!r||e.defaultPrevented||C(u,"embed")||C(n,"embed")&&/\.pdf/i.test(n.src)){return true}var i=e.wheelDeltaX||0;var o=e.wheelDeltaY||0;if(!i&&!o){o=e.wheelDelta||0}if(!t.touchpadSupport&&A(o)){return true}if(Math.abs(i)>1.2){i*=t.stepSize/120}if(Math.abs(o)>1.2){o*=t.stepSize/120}m(r,-i,-o);e.preventDefault()}function y(e){var n=e.target;var r=e.ctrlKey||e.altKey||e.metaKey||e.shiftKey&&e.keyCode!==l.spacebar;if(/input|textarea|select|embed/i.test(n.nodeName)||n.isContentEditable||e.defaultPrevented||r){return true}if(C(n,"button")&&e.keyCode===l.spacebar){return true}var i,s=0,o=0;var a=x(u);var f=a.clientHeight;if(a==document.body){f=window.innerHeight}switch(e.keyCode){case l.up:o=-t.arrowScroll;break;case l.down:o=t.arrowScroll;break;case l.spacebar:i=e.shiftKey?1:-1;o=-i*f*.9;break;case l.pageup:o=-f*.9;break;case l.pagedown:o=f*.9;break;case l.home:o=-a.scrollTop;break;case l.end:var c=a.scrollHeight-a.scrollTop-f;o=c>0?c+10:0;break;case l.left:s=-t.arrowScroll;break;case l.right:s=t.arrowScroll;break;default:return true}m(a,s,o);e.preventDefault()}function b(e){u=e.target}function S(e,t){for(var n=e.length;n--;)w[E(e[n])]=t;return t}function x(e){var t=[];var n=o.scrollHeight;do{var i=w[E(e)];if(i){return S(t,i)}t.push(e);if(n===e.scrollHeight){if(!r||o.clientHeight+10<n){return S(t,document.body)}}else if(e.clientHeight+10<e.scrollHeight){overflow=getComputedStyle(e,"").getPropertyValue("overflow-y");if(overflow==="scroll"||overflow==="auto"){return S(t,e)}}}while(e=e.parentNode)}function T(e,t,n){window.addEventListener(e,t,n||false)}function N(e,t,n){window.removeEventListener(e,t,n||false)}function C(e,t){return(e.nodeName||"").toLowerCase()===t.toLowerCase()}function k(e,t){e=e>0?1:-1;t=t>0?1:-1;if(i.x!==e||i.y!==t){i.x=e;i.y=t;p=[];v=0}}function A(e){if(!e)return;e=Math.abs(e);f.push(e);f.shift();clearTimeout(L);var t=f[0]==f[1]&&f[1]==f[2];var n=O(f[0],120)&&O(f[1],120)&&O(f[2],120);return!(t||n)}function O(e,t){return Math.floor(e/t)==e/t}function _(e){var n,r,i;e=e*t.pulseScale;if(e<1){n=e-(1-Math.exp(-e))}else{r=Math.exp(-1);e-=1;i=1-Math.exp(-e);n=r+i*(1-r)}return n*t.pulseNormalize}function D(e){if(e>=1)return 1;if(e<=0)return 0;if(t.pulseNormalize==1){t.pulseNormalize/=_(1)}return _(e)}var e={frameRate:150,animationTime:400,stepSize:120,pulseAlgorithm:true,pulseScale:8,pulseNormalize:1,accelerationDelta:20,accelerationMax:1,keyboardSupport:true,arrowScroll:50,touchpadSupport:true,fixedBackground:true,excluded:""};var t=e;var n=false;var r=false;var i={x:0,y:0};var s=false;var o=document.documentElement;var u;var a;var f=[120,120,120];var l={left:37,up:38,right:39,down:40,spacebar:32,pageup:33,pagedown:34,end:35,home:36};var t=e;var p=[];var d=false;var v=+(new Date);var w={};setInterval(function(){w={}},10*1e3);var E=function(){var e=0;return function(t){return t.uniqueID||(t.uniqueID=e++)}}();var L;var M=function(){return window.requestAnimationFrame||window.webkitRequestAnimationFrame||function(e,t,n){window.setTimeout(e,n||1e3/60)}}();var P=/chrome/i.test(window.navigator.userAgent);var H="onmousewheel"in document;if(H&&P){T("mousedown",b);T("mousewheel",g);T("load",h)}})()

    },
    /*jsl:end*/
    _columns : function(target, wrap) {

        var $wrap  = wrap.width(),
            visible,
            columns;

        if (target.hasClass('col-4')) {
            visible = 4;
        } else if (target.hasClass('col-3')) {
            visible = 3;
        } else if (target.hasClass('col-2')) {
            visible = 2;
        } else if (target.hasClass('col-1')) {
            visible = 1;
        } else {
            visible = 5;
        }

        if ($wrap < 1201 && $wrap >= 984 && visible > 4) {
            columns = 4;
        } else if ($wrap < 984 && $wrap >= 751 && visible > 3) {
            columns = 3;
        } else if ($wrap < 751 && $wrap >= 480 && visible > 2) {
            columns = 2;
        } else if ($wrap < 488 && visible > 1) {
            columns = 1;
        } else {
            columns = visible;
        }

        return columns;
    },
    _Tab : function(window, $) {

        "use strict"; // jshint ;_;

        var FC_Tab = function(element, options) {
            this.init(element, options);
        };

        FC_Tab.prototype = {

            constructor: FC_Tab,

            init: function(element, options) {

                var navs     = $('.fc-tab-heading > li', element),
                    current  = $('.fc-tab-heading > li.current', element),
                    tab      = $('.fc-tab-content > div', element),
                    vert     = $(element).children().is('[class*="col-"]'),
                    opt      = $(element).data('options'),
                    config   = {},
                    active;

                config = $.extend({}, $.fn.fcTab.defaults, options);

                /*  :: Extend with inline options :: */
                if (opt !== undefined) {
                    config = $.extend({}, config, opt);
                }

                /*  :: Add full width class :: */
                if (config.fullWidth && vert !== undefined) { $(element).addClass('fc-full-width'); }

                /*  :: Add current class :: */
                if (current.length > 1) {
                    current.each(function(i) {
                        if (i === 0) {
                            active = $(current.get(0)).index();
                        } else {
                            $(this).removeClass('current');
                        }
                    });
                } else if (current.length === 1) {
                    active = $(current.get(0)).index();
                } else {
                    active = 0;
                    navs.eq(active).addClass('current');
                }

                tab.each(function(i) {
                    if (i === active) {
                        $(this).addClass('current');
                    } else {
                        $(this).removeClass('current');
                    }
                });

                /*  :: Process :: */
                $(navs).on('click', function() {

                    if ($(element).is('.active') || $(this).is('.current')) { return false; } // multiple click protection

                    $(this).addClass('current').siblings().removeClass('current');

                    var next = $(this).index(),
                        prev = $(".fc-tab-content > div:visible", element).index(),
                        to,
                        from;

                    if (config.animation === 'fade' || config.animation === 'slide') {

                        if (config.animation === 'fade') {
                            to   = {opacity: 0};
                            from = {opacity: 0};
                        } else {
                            if (prev > next) {
                                to      = vert ? {opacity: 0, top: '30px'} : {opacity: 0, left: '30px'};
                                from    = vert ? {opacity: 0, top: '-30px'} : {opacity: 0, left: '-30px'};
                            } else {
                                to      = vert ? {opacity: 0, top: '-30px'} : {opacity: 0, left: '-30px'};
                                from    = vert ? {opacity: 0, top: '30px'} : {opacity: 0, left: '30px'};
                            }
                        }

                        $(element).addClass('active');

                        $('.fc-tab-content > div:visible', element).animate(to, config.speed, 'easeInOutBack', function() {
                            $(this).hide().removeClass('current');
                            tab.eq(next).show().css(from).animate({opacity: 1, left: 0, top: 0}, config.speed, 'easeOutCirc', function() {
                                $(element).removeClass('active');
                            }).addClass('current');
                        });

                    } else {
                        tab.eq(next).addClass('current').siblings().removeClass('current');
                    }
                });
            }
        };

        $.fn.fcTab = function(option) {
            return this.each(function() {
                var $this = $(this),
                    data = $this.data('fcTab'),
                    options = typeof option === 'object' && option;
                if (!data) {
                    data = new FC_Tab(this, options);
                    $this.data('fcTab', data);
                }
                if (typeof option === 'string') { data[option](); }
            });
        };

        $.fn.fcTab.Constructor = FC_Tab;

        $.fn.fcTab.defaults = {
            animation : false,
            speed     : 200,
            fullWidth : false
        };
    },
    _Accordion : function(window, $) {

        "use strict"; // jshint ;_;

        var FC_Accordion = function(element, options) {
            this.init(element, options);
        };

        FC_Accordion.prototype = {

            constructor: FC_Accordion,

            init: function(element, options) {

                var navs     = $('div > .fc-accordion-heading', element),
                    opt      = $(element).data('options'),
                    config   = {};

                config = $.extend({}, $.fn.fcAccordion.defaults, options);

                /*  :: Extend with inline options :: */
                if (opt !== undefined) {
                    config = $.extend({}, config, opt);
                }

                /*  :: Process :: */
                $(navs).click(function() {

                    var block   = $(this).parent(),
                        content = $('.fc-accordion-content', block);

                    if (block.is('.active')) {
                        content.css('display','block').slideUp(config.speed, 'easeInOutExpo').parent().removeClass('active');
                    } else {
                        if (config.toggle === true) {
                            content.css('display','none').slideDown(config.speed, 'easeInOutExpo').parent().addClass('active').siblings('.active').removeClass('active').children('.fc-accordion-content').css('display','block').slideUp(config.speed, 'easeInOutExpo');
                        } else {
                            content.css('display','none').slideDown(config.speed, 'easeInOutExpo').parent().addClass('active');
                        }
                    }
                });
            }
        };

        $.fn.fcAccordion = function(option) {
            return this.each(function() {
                var $this = $(this),
                    data = $this.data('fcAccordion'),
                    options = typeof option === 'object' && option;
                if (!data) {
                    data = new FC_Accordion(this, options);
                    $this.data('fcAccordion', data);
                }
                if (typeof option === 'string') { data[option](); }
            });
        };

        $.fn.fcAccordion.Constructor = FC_Accordion;

        $.fn.fcAccordion.defaults = {
            toggle : false,
            speed  : 400
        };
    },
    init : function() {

        var $that = this;

        this.extend();
        this.addons();

        $(function() {
            $that.other();

            $that.page.scrollspy();
            $that.page.header();

            $that.components.fancybox();
            $that.components.counter();
            $that.components.media();
            $that.components.iframe();
            $that.components.iconbox();

            $that._Tab(window, jQuery);
            $that.components.tab();

            $that._Accordion(window, jQuery);
            $that.components.accordion();

            $that.components.slider();
            $that.components.carousel();
            $that.components.testimonial();

            $that.page.grid();
            $that.page.form();
            $that.page.ajax();
            $that.page.comments();
            $that.page.animate();

        });

    },
    page : {
        header : function() {

            /* :: Slide block :: */
            $('body').delegate('.navbar-bar', 'position', function(e, li, myValue) {

                var el = li ? $(li) : $('#header .navbar-nav > li.active');

                if (el !== undefined && el.length) {

                    $('.navbar-bar').css({
                        left : el.position().left + 'px',
                        width : el.width() + 'px'
                    });
                }
            });
            $('#header .navbar-nav > li').hover(function () {
                $('.navbar-bar').trigger('position', this);
            }, function() {
                $('.navbar-bar').trigger('position');
            });
            $(window).resizeComplete(function() {
                $('.navbar-bar').trigger('position');
            }, 50, 'ready');

            if ($.mobile.is) {
                $('#header .navbar-nav > li a').on('click', function(event) {
                    if ($(this).parent().children('ul.dropdown').length) {
                        if (!$(this).is('.clicked')) {
                            $('#header .navbar-nav > li a').not(this).removeClass('clicked');
                            $(this).addClass('clicked');
                            event.preventDefault();
                        }
                    }
                });

                $('body > *').on('click', function(event) {
                    if ($(window).width() < $.mobile.width) {
                        if (!$(event.target).parents('#main-menu').length) {
                            $('#header .navbar-nav > li a').removeClass('clicked').off('mouseenter mouseleave');
                        }
                    }
                });
            }

            /* :: Social :: */
            var social;
            $('#header .social-nav > li a').hover(function () {
                social = $('span', this);
                if (window.outerWidth > 1200) {
                    social.width(social[0].scrollWidth);
                }
            }, function() {
                social.width(0);
            });
        },
        grid : function() {

            var grid = $('.fc-grid');
            if (grid.length) {

                $(window).resizeComplete(function() {

                    grid.each(function() {

                        var $that = $(this),
                            $wrap = $that.closest('.fc-grid-wrap'),
                            defaults = {
                                layoutMode: 'masonry',
                                gutterWidth : 0
                            },
                            options = $that.data('options'),
                            config = (options !== undefined) ? $.extend(true, defaults, options) : defaults,

                            gutter = config.gutterWidth,
                            columns = Talisman._columns($that, $wrap);

                        /* Prepare grid */
                        $that.css({
                            marginTop : -1 * gutter + 'px',
                            marginLeft : -1 * gutter + 'px'
                        }).children().css({
                            width : Math.floor(($wrap.width() - gutter * (columns - 1)) / columns) + 'px',
                            marginTop : gutter + 'px',
                            marginLeft : gutter + 'px'
                        });

                        $that.isotope(config);
                        $('.fc-slider, video.fc-media, audio.fc-media, iframe[height="100%"]', $that).trigger('updateSizes');

                        if (!$wrap.hasClass('created')) {
                            $wrap.addClass('created');
                        }

                        $that.isotope('layout');

                    });
                }, 100, 'load');

                /* :: Open filter :: */
                $('.fc-filter-heading').on('click', '.btn', function() {

                    var toggleFilter = $(this).closest('.fc-filter');

                    if ($(this).hasClass('active')) {
                        toggleFilter.find('a.fc-close').trigger('click');
                    } else {
                        $(this).addClass('active');
                        toggleFilter.children('.fc-filter-content').slideDown(150, function() {
                            toggleFilter.addClass('filter-active');
                        });
                    }
                    return false;
                });

                /* :: Close filter :: */
                $('.fc-filter').on('click', 'a.fc-close', function() {

                    var toggleFilter = $(this).closest('.fc-filter');

                    toggleFilter.removeClass('filter-active').find('.fc-filter-heading .btn').removeClass('active');

                    setTimeout(function() {

                        toggleFilter.children('.fc-filter-content').slideUp(150);

                    }, 200);

                    return false;
                });

                /* :: Filter switcher :: */
                $('.fc-filter .fc-switcher').on('click', 'a', function(event) {
                    if (!$(this).hasClass('active')) {
                        $(this).addClass('active').siblings().removeClass('active');
                        if ($(this).attr('href') === '#on') {

                            $(this).closest('.fc-filter').addClass('filter-multiple');

                        } else {

                            $(this).closest('.fc-filter').removeClass('filter-multiple');

                        }
                    }
                    event.preventDefault();
                });

                /* :: Filtering :: */
                $('.fc-filter-content ul').on('click', 'a', function(event) {

                    if ($(this).is('.active')) { return false; }

                    event.preventDefault();

                    var $filter = $(this).closest('.fc-filter'),
                        $list = $(this).closest('ul'),
                        cat,
                        cats = [],
                        text,
                        texts = [];

                    if ($filter.hasClass('filter-multiple') && $(this).attr('href') !== '*') {
                        $(this).addClass('active');
                        $('a[href="*"]', $list).removeClass('active');
                    } else {
                        $(this).addClass('active').parent('li').siblings().find('a').removeClass('active');
                    }

                    $('li a.active', $filter).each(function () {

                        if ($(this).attr('href') !== '*') {
                            cats.push($(this).attr('href'));
                            texts.push($(this).text());
                        }
                    });

                    cat = cats.join(', ');
                    text = texts.join(', ');

                    $('.fc-filter-heading .fc-filter-text', $filter).text(text);

                    $($filter.data('grid')).isotope({ filter : cat });
                });

            }
        },
        scrollspy : function() {

            var $body = $('body'),
                $header = $('#header'),

                $contact = $('#contact'),
                $contactNav = $('a[href="$contact"]', $header),

                activeNav = $('.navbar-nav.nav li.active');

            $(function() {

                $('html').addClass('loaded');

                setTimeout(function() {

                    /* :: Go to section :: */
                    var hash = document.location.hash,
                        offset = (this.outerWidth < $.mobile.width) ? 0 : $('#header').outerHeight() + 35,
                        scrollTop = (hash.substring(0, 1) === '#') ? $(hash).offset().top - offset : 0;

                    $('html, body').scrollTop(scrollTop);

                    $(window).scroll();

                    /* :: Menu slider :: */
                    $('.navbar-bar').trigger('position');

                    setTimeout(function() {
                        /* :: Hide loader :: */
                        $('.fc-page-loader').css('top', '100%');
                    }, 300);

                }, 300);


                $body.on('activate.bs.scrollspy', function () {
                    $('.navbar-bar').trigger('position');
                });

            });

            $(window).resizeComplete(function() {

                var $spy = $body.data('bs.scrollspy');

                if ($spy) {

                    $body.scrollspy('refresh');
                    $spy.options.offset = (this.outerWidth < $.mobile.width) ? 0 : $header.outerHeight() + 40;
                }

                if ($('html').hasClass('contact-active')) {

                    $body.css('margin-top', $contact.height()).find('#contact').css('margin-top', $contact.height() * -1 + 'px');

                }

            }, 40, 'load');

            $header.on('click', 'a', function() {

                var $spy = $body.data('bs.scrollspy'),

                    $that = $(this),

                    link = $that.attr('href'),
                    type = link.substring(0, 1);

                if (link !== '#' && (type === '#' || type === '$')) {

                    $body.scrollspy('refresh');


                    if (type === '#' && $spy) {

                        if ($('html').hasClass('contact-active')) {
                            $spy.offsets[0] = 0;
                            $spy.offsets[1] = $spy.offsets[1] + $spy.options.offset;
                        }

                        $('html, body').animate({
                            scrollTop:  $(link).offset().top - $spy.options.offset + 'px'
                        }, 600);
                    }

                    if (type === '$') {

                        if (link === '$contact' && !$('html').hasClass('contact-active')) {

                            $(window).onTop(function() {

                                var height = $contact.height();

                                /* :: Contact action :: */
                                $('html').addClass('contact-active').children('body').animate({ marginTop : height + 'px'}, 700, 'easeOutQuad', function() {

                                    if ($spy) {

                                        /* :: Update $contact -> #contact :: */
                                        $contactNav.attr('href', '#contact');

                                        /* :: Update scrollSpy :: */
                                        $body.scrollspy('refresh');
                                        $spy.offsets[0] = 0;
                                        $spy.offsets[1] = $spy.offsets[1] + $spy.options.offset;

                                    }

                                    $contactNav.parent('li').addClass('active').siblings().removeClass('active');
                                    $('.navbar-bar').trigger('position');

                                }).find('#contact').css('margin-top', height * -1 + 'px');

                            });
                        }
                        if (link === '$main-menu') {

                            $that.toggleClass('active');

                            $('#main-menu').slideToggle(300, 'easeInOutExpo', function() {
                                $body.scrollspy('refresh');
                            });
                        }
                    }

                    return false;
                }
            });

            $('#contact > a.fc-close').on('click', function() {
                $(window).onTop(function () {

                    /* :: Update link state :: */
                    $('.navbar-nav.nav li > a[href="#home"]').parent('li').addClass('active').siblings().removeClass('active');

                    $body.animate({ marginTop : 0}, 700, 'easeOutQuad', function() {

                        $(this).css('margin-top', '');

                        /* ::Contact action :: */
                        $('html').removeClass('contact-active').find('#header').css('position', '');

                        /* ::Update #contact -> $contact :: */
                        $contactNav.attr('href', '$contact');

                        /* ::Update scrollSpy :: */
                        $body.scrollspy('refresh');

                        /* ::Update link state :: */
                        activeNav.addClass('active').siblings().removeClass('active');

                        $('.navbar-bar').trigger('position');

                    });

                });

                return false;
            });

            $(window).scroll(function() {
                if ($('html').hasClass('contact-active')) {
                    if ($(window).scrollTop() > $contact.height()) {
                        $header.css('position', 'fixed');
                    } else {
                        $header.css('position', 'absolute');
                    }
                }
            });
        },
        ajax : function() {

            function ajax_block(remove) {
                if (remove) {
                    $('#ajax-block').remove();
                } else {
                    $('body').prepend('<div id="ajax-block" />');
                }
            }

            function ajax_loader(id, e) {
                $(id).prepend('<div class="loader"></div>').find('.loader').animate({
                    width : '100%'
                }, (e.lengthComputable) ? e.loaded / e.total * 100 + '%' : 200, 'easeOutQuad', function() {
                    $(this).animate({
                        opacity : 0
                    }, 1000, function() {
                        $(this).remove();
                    });
                });
            }

            function ajax_next(cur, max) {
                return ((cur + 1) > max - 1) ? 0 : cur + 1;
            }

            function ajax_prev(cur, max) {
                return ((cur - 1) < 0) ? max - 1 : cur - 1;
            }

            var list,
                map,
                current,
                count;
            $('a[data-ajax]').on('click', function(e) {

                /* ::Show blocker :: */
                ajax_block();

                /* ::Ajax group array :: */
                list = [];
                map  = [];
                $('a[data-ajax="' + $(this).data('ajax') + '"]').each(function() {

                    var value = $(this).attr('href');

                    if ($.inArray(value, map) < 0) {
                        map.push(value);
                        list.push(this);
                    }
                });

                count = list.length;
                current =  $.inArray(this, list);

                var $that = $(this),
                    url = $that.attr('href'),
                    prev = '#',
                    next = '#',
                    navDisabled = ' fc-disabled';

                if (count > 1) {
                    prev = ajax_prev(current, count);
                    next = ajax_next(current, count);
                    navDisabled = '';
                }

                /* ::Overlay margins :: */
                $('html').addClass('ajax-active').css('margin-right', $.browser.scroll + 'px');
                $('#header').css('margin-right', $.browser.scroll + 'px');

                /* ::Template :: */
                $('body').append('<div id="ajax-overlay">' +
                                    '<div id="ajax-wrapper">' +
                                        '<aside class="fc-article-nav">' +
                                            '<ul>' +
                                                '<li class="prev">' +
                                                    '<a class="fc-nav fc-prev' + navDisabled + '" href="' + prev + '" rel="Prev" target="_blank"></a>' +
                                                '</li>' +
                                                '<li class="back">' +
                                                    '<a title="Close" class="fc-nav fc-close" href="http://labs.funcoders.com/html/Talisman/demo/"></a>' +
                                                '</li>' +
                                                '<li class="next">' +
                                                    '<a class="fc-nav fc-next' + navDisabled + '" href="' + next + '" rel="Next" target="_blank"></a>' +
                                                '</li>' +
                                            '</ul>' +
                                        '</aside>' +
                                        '<div id="ajax-wrapper-inner">' +
                                            '<div class="ajax-container"><div class="container"></div></div>' +
                                        '</div>' +
                                    '</div>' +
                                '</div>');


                /* ::Load target :: */
                $.ajax({
                    url       : url,
                    cache     : false,
                    success: function (response) {

                        var ajax_wrapper = $('#ajax-wrapper');

                        /* :: Append article :: */
                        $('.ajax-container > .container', ajax_wrapper).html($(response).find('.fc-article'));

                        ajax_wrapper.waitForImages(function() {

                            Talisman.components.slider(this);
                            Talisman.components.media(this);
                            Talisman.components.iframe(this);

                            /* :: Show new :: */
                            $('.fc-page-loader').addClass('no-spinner').removeAttr('style');
                            $(this).delay(150).animate({'top': 0}, 700, 'easeInOutExpo', function() {

                                $(this).addClass('loaded').removeAttr('style');

                                ajax_block(true);

                            });
                        });
                    }
                });

                return false;
            });

            /* :: Navigation actions :: */
            $('body').on('click', '#ajax-wrapper > .fc-article-nav .fc-nav', function(e) {

                ajax_block();

                if ($(this).hasClasses('fc-next, fc-prev')) {

                    var $that = $(this),
                        url = $(list[$that.attr('href')]).attr('href');

                    current = parseInt($that.attr('href'), 10);

                    /* :: Load page :: */
                    $.ajax({
                        url       : url,
                        cache     : false,
                        xhrFields : {
                            onprogress: function (e) {
                                ajax_loader('#ajax-wrapper .fc-article-nav', e);
                            }
                        },
                        success: function (response) {

                            $('#ajax-wrapper-inner').append('<div class="ajax-container new"><div class="container"></div></div>').find('.ajax-container.new > .container').html($(response).find('.fc-article')).parent().css({
                                left : $that.hasClass('fc-next') ? '100%' : '-100%',
                                position : 'absolute'
                            });

                            if ($('.ajax-container').not('.new').height() < $('.ajax-container.new').height()) {
                                $('#ajax-wrapper-inner').height($('#ajax-wrapper-inner .ajax-container.new').height());
                            }

                            var ajax_wrapper = $('#ajax-wrapper');

                            ajax_wrapper.waitForImages(function() {

                                /* :: Update scripts :: */
                                Talisman.components.slider(this);
                                Talisman.components.media(this);
                                Talisman.components.iframe(this);

                                /* :: Hide current :: */
                                $('.ajax-container').not('.new').delay(20).animate({
                                    left : $that.hasClass('fc-next') ? '-100%' : '100%'
                                }, 700, 'easeOutCubic', function() {

                                    $(this).remove();

                                    $('#ajax-wrapper-inner').removeAttr('style');
                                    $('.ajax-container.new').removeClass('new').removeAttr('style');

                                    $('.fc-article-nav .fc-prev', ajax_wrapper).attr('href', ajax_prev(current, count));
                                    $('.fc-article-nav .fc-next', ajax_wrapper).attr('href', ajax_next(current, count));

                                    ajax_block(true);

                                });

                                /* :: Show new :: */
                                $('.ajax-container.new').animate({
                                    left : 0
                                }, 700, 'easeOutCubic');
                            });
                        }
                    });

                } else {

                    $('#ajax-wrapper').removeClass('loaded').css({
                        top : 0
                    }).animate({
                        'top': '100%'
                    }, 700, 'easeInOutExpo', function() {


                        $('#ajax-overlay').remove();

                        $('html').removeClass('ajax-active').removeAttr('style');
                        $('#header').removeAttr('style');

                        ajax_block(true);

                    });
                    setTimeout(function() {
                        $('.fc-page-loader').css('top', '100%');
                    }, 400);
                }

                return false;
            });
        },
        form : function() {

            /* :: Placeholder :: */
            $('.placeholder > .form-control').focus(function() {

                $(this).parent().addClass('focus');

            }).focusout(function() {

                $(this).parent().removeClass('focus');

            }).bind('change keyup input', function() {

                if ($(this).val() !== '') {
                    $(this).parent().addClass('keyup');
                } else {
                    $(this).parent().removeClass('keyup');
                }

            }).blur(function() {

                if ($(this).val() === '') {
                    $(this).removeClass('error').closest('.form-field').find('.text-error').remove();
                }

            });

            var $form = $('form.form-validate');

            if ($form.length) {
                $form.each(function() {

                    var $that = $(this);

                    $that.validate({
                        submitHandler: function(form) {

                            $.ajax({
                                type    : $(form).attr('method'),
                                url     : $(form).attr('action'),
                                data    : $(form).serialize(),
                                dataType: 'json',
                                success : function(data) {

                                    var response = '<div class="response ' + data.response + '">' + data.text + '</div>',
                                        f = $(form).validate();

                                    /* :: Show response :: */
                                    if ($(form).is('#contact-form')) {
                                        $('button[type="submit"]', form).before(response);
                                    } else {
                                        $(form).append(response);
                                    }

                                    $('.response', form).animate({right: '15px', opacity: 1}, 1000, 'easeInOutExpo', function() {

                                        /* :: Hide response :: */
                                        setTimeout(function() {
                                            $('.response', form).animate({right: '30px', opacity: 0}, 1000, 'easeInOutExpo', function() {
                                                $(this).remove();
                                            });
                                        }, 5000);

                                    });

                                    /* :: Reset form :: */
                                    $(form)[0].reset();
                                    f.prepareForm();
                                    f.hideErrors();
                                    f.resetForm();
                                    $('.placeholder > .form-control', form).change().blur();
                                }
                            });

                        },
                        success: function(label, field) {},
                        errorPlacement: function(error, field) {

                            var $parent = $(field).parent('.placeholder');

                            $parent = $parent.parent();
                            $parent.find('.text-error').remove();
                            $parent.append('<span class="text-error">' + error.text() + '</span>');
                        }
                    });

                });
            }
        },
        comments : function() {

            var comments    = $('.fc-comments'),
                replyBlock  = $('.fc-comments-reply', comments);

            if (comments.length) {

                /* :: Show comment form :: */
                $('.fc-comment-content .reply a', comments).on('click', function() {

                    var $that = $(this);

                    replyBlock.animate({opacity: 0}, 100, function() {

                        $that.closest('.fc-comment').after(replyBlock).next().animate({opacity: 1}, 200);
                    });

                    return false;
                });

                /* :: Hide comment form :: */
                $('.fc-close', replyBlock).click(function() {

                    replyBlock.animate({opacity: 0}, 100, function() {
                        $(this).appendTo($(this).closest('.fc-comments')).animate({opacity: 1}, 200);
                    });

                    return false;
                });
            }
        },
        animate : function() {
            var animatePosition, delay;
            if ($.mobile.is) {
                $('*[data-animate]').addClass('animated done');
            } else {
                $('*[data-animate]').not('.animated').isOnScreen(function() {

                    var $that = $(this),
                        effect = $that.data('animate'),
                        offset = $that.offset().top;

                    if (animatePosition !== offset) {
                        animatePosition = offset;
                        delay = 0;
                    } else {
                        delay += 1;

                        $that.css({
                            '-webkit-animation-delay': delay * 0.1 + 's',
                            'animation-delay': delay * 0.1 + 's'
                        });
                    }

                    $that.addClass(effect + ' animated');
                    setTimeout(function() {
                        $that.removeClass(effect).addClass('done');
                    }, 2000);
                });
            }
        }
    },
    components: {
        fancybox : function() {

            $('a[data-modal="fancybox"]').fancybox({
                margin      : 40,
                fitToView   : true,
                width       : '70%',
                height      : '70%',
                padding : 0,
                helpers : {
                    title : {
                        type    : 'outside'
                    }
                },
                tpl : {
                    closeBtn    : '<a title="Close" class="fc-nav fc-close" href="javascript:;"></a>',
                    prev        : '<a title="Previous" class="fc-nav fc-prev" href="javascript:;"></a>',
                    next        : '<a title="Next" class="fc-nav fc-next" href="javascript:;"></a>'
                },
                iframe     : {
                    preload : false
                },
                openEffect : 'fade',
                closeEffect : 'fade',
                openSpeed : 800,
                closeSpeed : 300,
                afterLoad: function(current) {
                    setTimeout(function () {
                        $(current.wrap).parent().addClass('opened');
                    }, 10);
                },
                beforeClose : function(current) {
                    $(this.wrap).parent().removeClass('opened');
                }
            });

            /* :: If teaser inside fill grid :: */
            $('.project-grid .fc-article-heading img').each(function () {
                $(this).parent().css('background-image', 'url(' + this.src + ')');
            });
        },
        counter : function () {

            var counter =  $('.fc-counter.action');
            if (counter.length) {

                $('input.bar', counter).knob({
                    width        : 150,
                    thickness    : 0.05,
                    displayInput : false,
                    readOnly     : true
                });

                counter.isOnScreen(function() {

                    var $that   = $(this),
                        value   = $('span.value', $that),
                        bar     = $('.bar', $that),
                        min     = bar.data('min'),
                        to      = bar.data('value');

                    $({countNum: min}).animate({countNum: to}, {
                        duration: 1000,
                        step: function() {
                            var current = Math.ceil(this.countNum);
                            value.text(current);
                            $('input.bar', $that).val(current).trigger('change');
                            $that.addClass('created');
                        }
                    });

                    $('div.bar', $that).css($that.hasClass('fc-vertical') ? 'height' : 'width', to + '%');
                });
            }
        },
        media : function(target) {

            var media = $('video.fc-media, audio.fc-media', (target !== undefined) ? target : 'body');

            if (media.length) {

                media.mediaelementplayer({
                    audioHeight              : 40,
                    features                 : ['playpause', 'current', 'duration', 'progress', 'volume', 'fullscreen'],
                    alwaysShowControls       : true,
                    timeAndDurationSeparator : '<span> / </span>',
                    iPadUseNativeControls: true,
                    iPhoneUseNativeControls: true,
                    AndroidUseNativeControls: true,
                    success: function (mediaElement, domObject) {
                        $(mediaElement).addClass('created').on('updateSizes', function() {

                            var width, height;

                            if ($.mobile.is) {

                                width = $(this).parent().width();
                                height = width * 9 / 16;

                                $(this).height(height + 'px');

                            } else {

                                width = $(this).closest('.mejs-container').parent().width();
                                height = width * this.videoHeight / this.videoWidth;

                                this.player.setPlayerSize(width, height);
                                this.player.setControlsSize();
                                this.player.media.setVideoSize(width, height);
                            }

                        });
                        if ($.mobile.is) {
                            $(mediaElement).trigger('updateSizes');
                        }
                    }
                });
            }

        },
        iframe : function(target) {

            var iframe = $('iframe[height="100%"]', (target !== undefined) ? target : 'body');

            if (iframe.length) {

                iframe.on('updateSizes', function () {
                    $(this).addClass('created').height($(this).width() * 9 / 16 + 'px');
                });

                $(window).resizeComplete(function() {
                    iframe.trigger('updateSizes');
                }, 50, 'load');

                if (target !== undefined) {
                    iframe.trigger('updateSizes');
                }

            }
        },
        iconbox : function() {

            var iconbox = $('.fc-iconbox.fc-style-4.fc-hover');
            if (iconbox.length) {
                $(window).resizeComplete(function() {
                    $('.fc-iconbox-content > *', iconbox).each(function() {
                        $(this).css('margin-top', ($(this).parent().height() - $(this).height()) / 2 + 'px');
                    });
                }, 50, 'ready');
            }
        },
        tab : function() {
            var tab = $('.fc-tab');
            if (tab.length) {
                tab.fcTab();
            }
        },
        accordion : function() {
            var accordion = $('.fc-accordion');
            if (accordion.length) {
                accordion.fcAccordion();
            }
        },
        testimonial :  function() {

            var testimonial = $('.fc-testimonial');
            if (testimonial.length) {
                $(window).load(function() {

                    testimonial.wrap('<div class="fc-testimonial-outer"><div class="fc-testimonial-inner"></div></div>').each(function() {

                        var $that   = $(this),
                            $wrap    = $that.closest('.fc-testimonial-wrap'),
                            defaults = {
                                scroll      : {
                                    fx : "crossfade",
                                    duration : 300,
                                    onBefore: function(data) {
                                        $('.fc-testimonial-heading', $wrap).eq($that.triggerHandler("currentPosition")).addClass('active').siblings().removeClass('active');
                                    }
                                },
                                auto        : {
                                    play    : false
                                },
                                prev        : {
                                    button  : function() { return $wrap.find('a.fc-prev'); }
                                },
                                next        : {
                                    button  : function() { return $wrap.find('a.fc-next'); }
                                },
                                width       : '100%',
                                height      : 'variable',
                                responsive  : true,
                                items       : {
                                    width   : 100,
                                    height  : 'variable',
                                    visible : 1
                                },
                                onCreate    : function(data) {
                                    $wrap.addClass('created');
                                },
                                pagination  : {
                                    container: function() { return $wrap.find('.fc-pagi'); },
                                    anchorBuilder: function(nr, item) { return '<a href="#' + nr + '"></a>'; }
                                }
                            },
                            options = $that.data('options'),
                            config = (options !== undefined) ? $.extend(true, defaults, $that.data('options')) : defaults;

                        $('.fc-testimonial-heading', $that).prependTo('.fc-testimonial-outer', $that).eq(0).addClass('active');

                        $that.carouFredSel(config, { debug : false });

                    });
                });

                $('.fc-testimonial-heading').on('click', function() {
                    $(this).closest('.fc-testimonial-wrap').find('.fc-testimonial').trigger('slideTo', $(this).index());
                });

                $(window).resizeComplete(function() {
                    testimonial.trigger('updateSizes');
                }, 50);
            }
        },
        slider : function(target) {

            function slider_init (slider) {
                slider.each(function() {

                    var $that   = $(this),
                        $wrap    = $that.closest('.fc-slider-wrap'),
                        defaults = {
                            auto        : {
                                play    : false
                            },
                            prev        : {
                                button  : function() { return $wrap.find('a.fc-prev'); }
                            },
                            next        : {
                                button  : function() { return $wrap.find('a.fc-next'); }
                            },
                            width       : '100%',
                            height      : 'variable',
                            responsive  : true,
                            items       : {
                                width   : 100,
                                height  : 'variable',
                                visible : 1
                            },
                            onCreate    : function(data) {
                                $wrap.addClass('created');
                            },
                            pagination  : {
                                container: function() { return $wrap.find('.fc-pagi'); },
                                anchorBuilder: function(nr, item) { return '<a href="#' + nr + '"></a>'; }
                            }
                        },
                        options = $that.data('options'),
                        config = (options !== undefined) ? $.extend(true, defaults, options) : defaults;

                    $that.carouFredSel(config, { debug : false }).swipe({
                        swipeLeft: function(event, direction, distance, duration, fingerCount) {
                            $(this).trigger('next');
                        },
                        swipeRight: function(event, direction, distance, duration, fingerCount) {
                            $(this).trigger('prev');
                        }
                    });
                });
            }

            var slider = $('.fc-slider', (target !== undefined) ? target : 'body');

            if (slider.length) {

                if (target !== undefined) {
                    $(window).on('load', slider_init(slider));
                } else {
                    slider_init(slider);
                }

            }
        },
        carousel : function() {

            var carousel = $('.fc-carousel');
            if (carousel.length) {
                $(window).resizeComplete(function() {
                    carousel.each(function() {

                        var $that = $(this),
                            $wrap = $that.closest('.fc-carousel-wrap'),
                            defaults = {
                                auto        : {
                                    play            : false,
                                    timeoutDuration : 10000
                                },
                                prev        : {
                                    button  : function() { return $wrap.find('a.fc-prev'); }
                                },
                                next        : {
                                    button  : function() { return $wrap.find('a.fc-next'); }
                                },
                                width       : '100%',
                                height      : 'variable',
                                responsive  : true,
                                items       : {
                                    width   : 100,
                                    height  : 'variable',
                                    visible : Talisman._columns($that, $wrap)
                                },
                                onCreate    : function(data) {
                                    $wrap.addClass('created');
                                    $(this).trigger('updateSizes');
                                },
                                pagination  : {
                                    container: function() { return $wrap.find('.fc-pagi'); },
                                    anchorBuilder: function(nr, item) { return '<a href="#' + nr + '"></a>'; }
                                }
                            },
                            options = $that.data('options'),
                            config;

                        if ($wrap.hasClass('created')) {
                            $(this).trigger('configuration', ['items.visible', Talisman._columns($that, $wrap)]).trigger('updateSizes');
                        } else {

                            config = (options !== undefined) ? $.extend(true, defaults, options) : defaults;

                            $that.wrap('<div class="fc-carousel-outer"><div class="fc-carousel-inner"></div></div>').carouFredSel(config, { debug : false });
                        }
                    });
                }, 70, 'load');
            }
        }
    },
    other : function() {

        /* :: Twiiter / Flickr :: */
        var tweets = $('#tweets'),
            flickr = $('#flickr');

        if (tweets.length) {
            tweets.twitterfeed();
        }
        if (flickr.length) {
            flickr.jflickrfeed({
                limit   : 8,
                qstrings: {
                    id: flickr.data('id')
                },
                itemTemplate:   '<div class="col-sm-3">' +
                                    '<a href="{{image_b}}" data-modal="fancybox" data-fancybox-group="flickr" title="{{title}}">' +
                                        '<span><i class="fa fa-plus"></i></span>' +
                                        '<img src="{{image_s}}" alt="{{title}}">' +
                                    '</a>' +
                                '</div>'
            });
        }

        $(window).resizeComplete(function() {

            /* :: Full width section :: */
            if ($('.fc-section-full-width').length) {
                $('.fc-section-full-width').css({
                    width : $('#main').width(),
                    marginLeft : ($('#main > .container').offset().left + 15) * -1 + 'px'
                });
            }

            /* :: Video section :: */
            if ($.mobile.is) {
                $('#page-slider video, .fc-section-bg video').hide();
            }
            $('.fc-section-bg > video').each(function() {
                var $that      = $(this),
                    $parent    = $that.parent(),
                    videoRatio = this.videoWidth / this.videoHeight,
                    height     = $parent.outerHeight(),
                    width      = $(window).width();

                if (videoRatio) {
                    if (videoRatio < width / height) {
                        height = width / videoRatio;
                    } else {
                        width = height * videoRatio;
                    }
                }

                $that.css({
                    width : width + 'px',
                    height : height + 'px',
                    marginTop : height / -2,
                    marginLeft : width / -2
                });
            });

        }, 30, 'load');

    }
};

Talisman.init();