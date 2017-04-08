$(document).on("turbolinks:load", function(){

	// Initially the player is not loaded
	var makeVideoPlayer;
	window.ytPlayerLoaded = false;
	var makeVideoPlayer;

	makeVideoPlayer = function(video){
		var player_wrapper;
		if (!window.ytPlayerLoaded) {
			// console.log(window.ytPlayerLoaded);
			player_wrapper = $('#player-wrapper');
			player_wrapper.append('<div id="ytPlayer"><p class="text-center">Loading player...</p></div>');

			window.ytplayer = new YT.Player('ytPlayer', {
				width: '100%',
				heigh: player_wrapper.width()/1.777777777,
				videoId: video,
				playerVars: {
					wmode: 'opaque',
					autoplay: 0,
					modestbranding: 1
				},

				events: {
					'onReady': function(){
						return window.ytPlayerLoaded = true

					},

					'onError': function(errorCode){
						return alert("We are sorry, but the following error occured: " +  errorCode)
					}
				}
			});

		} else {
			window.ytplayer.loadVideoById(video);
			// window.ytplayer.pauseVideo();
			window.ytplayer.playVideo();

		}

	};



	var _run;

	_run = function() {
 	 	$('.yt_video').first().click();
	};

	google.setOnLoadCallback(_run);


	$('.yt_video').click(function() {
		// console.log(this);
 	 return makeVideoPlayer($(this).data('uid'));
	});


	$(window).on('resize', function() {
  		var player;
 		 player = $('#ytPlayer');
  		if (player.size() > 0) {
   			 player.height(player.width() / 1.777777777);
  		}
	});


	$(window).bindWithDelay('resize', function() {
  		var player;
  		player = $('#ytPlayer');
  		if (player.size() > 0) {
    		player.height(player.width() / 1.777777777);
  		}
	}, 500);
	

});


