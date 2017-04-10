
ready = function(){

}
$(document).on("turbolinks:load", function() {

       // alert("loaded")
     $('body').prepend('<div id="fb-root"></div>');
     
	

	if ($('#new_post').length) {

		$('#new-comment-id').hide();
		$('li').removeClass("link-list-item")
       
	}
});

$(document).on('click', '.yt_video', function(){
	// alert($(this).parent().attr("class"));
	// console.log('I am clicked');
});
