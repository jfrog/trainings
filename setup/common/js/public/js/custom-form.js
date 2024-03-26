$(document).ready(function(){
    $("#callFear").on( "click", function() {
        let postData = {"content": $("#payloadArea").val()};
        var jqxhr = $.post( "/fear", postData ,function(data) {
            $( "#callResponse" ).text( "");
            $( "#callResponse" ).text( data.message );
        });
            
      } );
   });