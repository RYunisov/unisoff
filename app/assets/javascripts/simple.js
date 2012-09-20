$(document).ready(function(){

   $('#query').focus(function(){
  	$(this).css({'color' : '#383838', 'font-style' : 'normal'});	  
   })
   $('#query').focusout(function(){
      $(this).css({'color': '#f3f3f3', 'font-style':'italic'});
   })

//Автозаполнение для поисковой стороки.
    $('#query').keyup(function(event){
      var text = '&query='+this.value
      if ( this.value.length >= 3 ) {
        $.ajax({
          type: 'get',
          url: '/autocomplete',
          data: text,   
          success: function(data){
            $('.droplist').show().html(data);
          }
        })
      } else {
        $('.droplist').hide().html();
      }
    })

});

function fadeto(item) {
 $(item).removeClass('opacity');
};

function fadeout(item) {
 $(item).addClass('opacity');
};

function cleari() {
 var i = document.getElementById('query')
 i.value = ''
 $('.droplist').hide().html();
};

