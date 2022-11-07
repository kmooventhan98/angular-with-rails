//////////////////////////////////////////////////////////////////////////
// FOUNDATION 5 MEDIA BREAKPOINTS ////////////////////////////////////////
// Small screens -- max-width 640px (max-width: 40em)
// Medium screens -- min-width 641px (40.063em) and max-width 1024px (64em)
// Large screens -- min-width 1025px (64.063em)

//////////////////////////////////////////////////////////////////////////
// VARIABLE AND FUNCTION DEFINITIONS /////////////////////////////////////
function resizeDivs() {
	var medLargeScreen = window.matchMedia("screen and (min-width: 40.063em)")

	// if media query falls within the medium or large screen range...
	if (medLargeScreen.matches){
			var maxDiv = -1;

			$('.detailedRFV').each(function() {
				maxDiv = maxDiv > $(this).height() ? maxDiv : $(this).height();
			});

			$('.detailedRFV:not(.last)').each(function() {
				$(this).css('height', maxDiv );
			});
	} else {
			$('.detailedRFV').each(function() {	
					$(this).css('height', $(this).data('initialHeight') );
			});
	}
}

//////////////////////////////////////////////////////////////////////////
// CALL THE RESIZE FUNCTION //////////////////////////////////////////////
	$('.detailedRFV').each(function() {
		var divHeight = $(this).height();
		$(this).data('initialHeight', divHeight );
	});

// On the original page load...
$(document).ready(function() {
	resizeDivs();
});

// When the window is resized... 
$(window).resize(function() {
  resizeDivs();
});