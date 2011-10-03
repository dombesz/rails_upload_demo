// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  var new_uuid;
  $("#user_file").change(function(){
    if(new_uuid!=null){
      $(".uuid").each(function(index){
        $(this).val(new_uuid);
      });
      console.log('uuid'+new_uuid);
    }
    $(this).parent('form').submit();
    $(".meter-value").width('0%');
    $("#progress").html('0%');
    var timeout_id = setTimeout(updateProgress, 0);
  });
  function updateProgress(){
    
    $.getJSON('/progress',{
      uuid:$("#uuid").attr('value')
    },function(response){
      if (response.result<100){
        setTimeout(updateProgress, 1000);
      }
      
      if (response.result==-1) {
        $("#progress").html("Not available.")
      }else{
        new_uuid = response.new_uuid;
        $(".meter-value").width(response.result+'%');
        $("#progress").html(response.result+'%');
      };
      
    });
  }

});
