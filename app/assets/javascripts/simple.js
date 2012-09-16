$(document).ready(function(){
 
 $('#query').focus(function(){
	$(this).css({'color' : '#383838', 'font-style' : 'normal'});	  
 })
 $('#query').focusout(function(){
    $(this).css({'color': '#f3f3f3', 'font-style':'italic'});
 })
/*
 $('#query').change(function(){
 var i = document.getElementById('query').value;  
   $.ajax({
    type: 'GET',
    url: 'www.unisoff.ru:3000/search',
    data:  i    
    }).done(function(data) {
        console.log(data)
        })
 });
*/ 
})

function fadeto(item) {
 $(item).removeClass('opacity');
};

function fadeout(item) {
 $(item).addClass('opacity');
};

function cleari() {
 var i = document.getElementById('query')
 i.value = ''
};

