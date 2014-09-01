// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function get_point(id)
{
		jQuery.getJSON('/points/' + id, function(data){
			 if(data[0].credit)
			 {
				$("#assigned_points_value").val(data[0].value);
			 }
			 else
			 {
				$("#assigned_points_value").val(data[0].value * -1);
			 }
			 
			 $("#assigned_points_card").val(data[0].card_offense);
			 $("#assigned_points_card_id").val(data[0].card_offense_id);
    	})
    	return false;
}
;
