$(document).on('turbolinks:load', function() {
  $(".tab-label").on("click", function(){
    var $th = $(this).index();
    $(".tab-label").removeClass("active");
    $(".mypage-item-list").removeClass("active");
    $(this).addClass("active");
    $(".mypage-item-list").eq($th).addClass("active");
  });
})
