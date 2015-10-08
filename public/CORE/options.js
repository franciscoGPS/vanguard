/*  ::

    :: Theme         : Talisman
    :: Theme URI     : http://labs.funcoders.com/html/Talisman

    :: File          : theme-options.js
    :: Name          : Options js file
    :: Version       : 0.1

:: */

$(function () {
    $('.fc-options-heading a').on('click', function() {
        $(this).closest('.fc-options').toggleClass('fc-open');
        return false;
    });

    $('#theme-options select').change(function() {

        var name    = $(this).attr('name'),
            value   = $(this).val(),
            target  = $(this).attr('data-target'),
            clear_css = '';

        $('option', this).each(function() {
            if (value !== $(this).val()) { clear_css += ' ' + $(this).val(); }
        });

        $.cookie(name, value);

        if (target) {
            if (value !== 'default') {
                $(target).removeClass(clear_css).addClass(value);
            } else {
                $(target).removeClass(clear_css);
            }
        }

        if ($(this).attr('data-refresh')) {
            window.location.href = window.location.origin + window.location.pathname;
        }

    });

    $("#theme-options a").click(function() {

        var name    = $(this).closest("ul").attr("data-name"),
            value   = $(this).attr("href");

        if (name === "talisman-color") {
            $('#layout-color').attr('href', 'css/colors/' + value + '.css');
        }

        $("ul[data-name=" + name + "] a").parent().removeClass("active");
        $(this).parent().addClass("active");

        $.cookie(name, value);

        if ($(this).attr('data-refresh')) {
            window.location.href = window.location.origin + window.location.pathname;
        } else {
            return false;
        }
    });

    $('#bg-changer-invert a').click(function() {

        var current = $('#bg-changer-invert a.active').attr('class'),
            next = $(this).attr('class');


        $(this).addClass('active').siblings().removeClass('active');

        $(this).closest('.fc-section').next().removeClass(current).addClass(next);

        return false;
    });


});