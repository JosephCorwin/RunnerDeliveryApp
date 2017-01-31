// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
 $(document).ready(function(){


$(".menu-icon").click(function(event) {
  $('.trigger').toggleClass('expand');
  $('.menu-icon').toggleClass('rotate');
});








$("#scroll-1").click(function() {
    $('html, body').animate({
        scrollTop: $("#anchor-1").offset().top - 50 }, 1000);
});

$("#scroll-2").click(function() {
    $('html, body').animate({
        scrollTop: $("#grid").offset().top - 50 }, 1000);
});



                // $('#grid a:nth-of-type(3)').addClass('two-third-grid').removeClass('four-grid, one-third-grid');
                // $('#grid a:nth-of-type(4)').addClass('one-third-grid').removeClass('four-grid, two-third-grid');
                // $('.grid-level:nth-of-type(3) a:nth-of-type(1)').addClass('four-grid').removeClass('two-third-grid, one-third-grid');
                // $('.grid-level:nth-of-type(3) a:nth-of-type(2)').addClass('four-grid').removeClass('two-third-grid, one-third-grid');
                // $('.grid-level:nth-of-type(3) a:nth-of-type(3)').addClass('four-grid').removeClass('two-third-grid, one-third-grid');
                // $('.grid-level:nth-of-type(3) a:nth-of-type(4)').addClass('four-grid').removeClass('two-third-grid, one-third-grid');

          $('#grid').each(function(){


                // get current div
                var $div_parent = $(this);

                // get array of childs in parent div
                var $divsArr = $div_parent.children('a');

                // sort array of childs in parent div (#sponsors) randomly
                $divsArr.sort(function(a,b){

                      // Get a random number between 0 and 10
                      var temp = parseInt( Math.random()*4 );

                      // Get 1 or 0, whether temp is odd or even
                      var isOddOrEven = temp%2;

                      // Get +1 or -1, whether temp greater or smaller than 5
                      var isPosOrNeg = temp>2 ? 1 : -1;

                      // Return -1, 0, or +1
                      return( isOddOrEven*isPosOrNeg );
                })

                // append child items to parent
                .appendTo($div_parent);
                // $('a:nth-of-type(1)').addClass('two-grid');
                // $('a:nth-of-type(2)').addClass('two-grid');
                $('a:nth-of-type(3)').addClass('one-third-grid');
                $('a:nth-of-type(4)').addClass('two-third-grid');
                $('a:nth-of-type(5)').addClass('four-grid');
                $('a:nth-of-type(6)').addClass('four-grid');
                $('a:nth-of-type(7)').addClass('four-grid');
                $('a:nth-of-type(8)').addClass('four-grid');
                $('a:nth-of-type(9)').addClass('two-third-grid');
                $('a:nth-of-type(10)').addClass('one-third-grid');
                $('a:nth-of-type(11)').addClass('one-third-grid');
                $('a:nth-of-type(12)').addClass('two-third-grid');
               
              
          });


    });


