// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function get_point(id)
{
		jQuery.getJSON('/points/' + id, function(data){
       	 $("#assigned_points_value").val(data[0].value);
    	})
    	return false;
}
