//Buttons
$(document).on('click', '#generalBtn', function (e) {
    $("#maleBtn, #femaleBtn, #lowBtn, #mediumBtn, #highBtn").removeClass('active');
});

//$(document).on('click', '', function() {
        //  alert('you clicked either button 1 or button 2');
   //$("#lowBtn, #mediumBtn, #highBtn").removeClass('active');
//}
//);



$(document).ready(function () {
    $("#generalBtn").addClass('active');
});

// $(document).ready(function() {
//     $("#femaleBtn").click(function() {
//         $("#lowBtn").css("background-color","#f6aac9");
//     });
// });


// })
// #mediumBtn.active,
// #mediumBtn:hover{
//     background-color: #b276b2;
// }
//
// #highBtn.active,
// #highBtn:hover{
//     background-color: #7b3a96;
// }

// });


//http://www.w3schools.com/bootstrap/tryit.asp?filename=trybs_ref_js_scrollspy_activate&stacked=h
$(document).ready(function () {
    //removeSection = function(e){
    //   $(e).parents("#myScrollspy > div").remove();
    //  $('#myScrollspy').each(function(){
    //     $(this).scrollspy('refresh');
    // });
    //};
    $("#surveyDashboard").hide();
    $("#subjectsDashboard").show();

    $("#page-top").scrollspy({target: "#mainNav"});
    $("#mainNav").on("activate.bs.scrollspy", function () {
        var x = $(".nav li.active > a").attr('href');
        //$("#demo").empty().html("You are currently viewing: " + x);
        switch (x) {
            case "#survey":
                $("#surveyDashboard").show();
                $("#subjectsDashboard").hide();
                break;
            case "#analyze":
                $("#surveyDashboard").show();
                $("#subjectsDashboard").show();
                break;
            case "#about":
                $("#surveyDashboard").show();
                $("#subjectsDashboard").show();
                break;
            case "#scores":
                $("#surveyDashboard").hide();
                $("#subjectsDashboard").show();
                break;
            default:
                $("#surveyDashboard").hide();
                $("#subjectsDashboard").show();
                break;
        }
        //
        //  if(x!="#survey") {
        // $("#surveyDashboard").hide()
        //  $("#subjectsDashboard").show()
        //
        // } else {
        // //if (x!="#survey") {
        //   $("#surveyDashboard").show()
        //   $("#subjectsDashboard").hide()
        // }
    })

});


//$('#survey').on('activate.bs.scrollspy', function () {
//  
//})

//affixed.bs.affix
//activate.bs.scrollspy
//$('#dashboard').affix({
// offset: $('#mainNav').position()
//offset: {
//top: $('#dashboard').height()
//top:60
//}
//});

//$(document).ready(function(){
/* affix the navbar after scroll below header */
//  $("#dashboard").affix({offset: {top: $("header").outerHeight(true)} });
//});


// $(function() {
//     $('#mydashboard').height($("#mydashboard").height());
//
//     $('#mydashboard').affix({
//         offset: {
//             top: $('#mydashboard').height()
//         }});
// });
//
// $('#survey').on('activate.bs.scrollspy', function () {
//     // $("span").css( "display", "inline" ).fadeOut( "slow" );
//     alert("asd");
// });