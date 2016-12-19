
ready = function(){

}
$(document).on("turbolinks:load", function() {

	if ($('#new_post').length) {

		$('#new-comment-id').hide();
		$('li').removeClass("link-list-item")
       
	}
});

$(document).on('click', '.content', function(){
	// alert($(this).parent().attr("class"));
});
