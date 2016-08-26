$(document).on('click', '#calibrationCheck', function (e) {
    $(".btn-pisa").removeClass('active');
    // #alert("df");
});

$(document).ready(function () {
    $(".shiny-plot-output").mousemove(function (event) {
        $(".plotTooltip").show();
        $(".plotTooltip").css({
            position: "fixed",
            // visibility: "visible",
            top: (event.pageY-350)+"px",
            left: (event.pageX-40)+"px"});
    });
});


// $('#dashboard').affix({
//
//     // offset: $('#mainNav').position()
//     offset: {
//         top: $('#dashboard').height()
//       }
// });

// $(function() {
//     $('#dashboard').height($("#mydashboard").height());
//
//     $('#mydashboard').affix({
//         offset: { top: $('#mydashboard').offset().top }
//     });
//     });
//
// $('#survey').on('activate.bs.scrollspy', function () {
//     // $("span").css( "display", "inline" ).fadeOut( "slow" );
//     alert("asd");
// });