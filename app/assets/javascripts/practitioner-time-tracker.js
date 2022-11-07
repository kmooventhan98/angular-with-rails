$(function(){  
	$('#datepicker').datepicker({  
		inline: true,  
		showOtherMonths: true,  
		dayNamesMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
    dateFormat: 'mm/dd/yy'
	});  
  $('#datepicker').datepicker('setDate', new Date());
});  
