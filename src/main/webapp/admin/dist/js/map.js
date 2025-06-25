$("#location-tab").one('click',function(){
    $(function () {
        "use strict";

        $.ajax({
            url: "/admin/location",
            type: "GET",
            datatype: "json",
        }).done(function (data) {
            var ordersData = {
                my01: data[0].count,
                my02: data[1].count,
                my03: data[2].count,
                my04: data[3].count,
                my05: data[4].count,
                my06: data[5].count,
                my07: data[6].count,
                my08: data[7].count,
                my09: data[8].count,
                my10: data[9].count,
                my11: data[10].count,
                my12: data[11].count,
                my13: data[12].count,
                my14: data[13].count,
                my15: data[14].count,
            };

            $("#malaysia-map").vectorMap({
                map: "malaysia",
                backgroundColor: "transparent",
                zoomOnScroll: "true",
                regionStyle: {
                    initial: {
                        fill: "rgba(255, 255, 255, 0.7)",
                        "fill-opacity": 1,
                        stroke: "rgba(0,0,0,.2)",
                        "stroke-width": 1,
                        "stroke-opacity": 1,
                    },
                },
                onLabelShow: function (e, el, code) {
                    if (typeof ordersData[code] !== "undefined")
                        el.html(el.html() + " - " + ordersData[code]);
                },
            });
        });
    });
});
