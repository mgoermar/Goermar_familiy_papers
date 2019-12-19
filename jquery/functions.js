$(document).ready(function () {
    $('#select-view').change(function (event) {
        var selected = $('option:selected', this).attr('value');
        show_hide(selected);
    });
});


/* toggle auf divs innerhalb des Textes */
function showInlineAnnotation(obj, items) {
	var nid = $(obj).attr('id') + '_info';
	var ins = '';
	items.split(' ').forEach(function (item, index, array) {
		//console.log(index + ' ' + array.length);
		ins += $(item).html();
		if (index < (array.length - 1))	ins += '<hr>';
	});

	if (!$('#' + nid).length) {
		var insert = 
			"<div id=\"" + nid + "\">" +
				"<div class=\"pShow\">" +
					"<img src=\"http://diglib.hab.de/edoc/ed000228/images/close.png\" alt=\"close\"" +
				"	onclick=\"javascript:$('#" + nid + "').detach()\"/>" +
				ins +
				"</div>" +
			"</div>"
		$(obj).after(insert);
	}
	else {
		$('#' + nid).detach();
	}
}

/*function show_hide (selected) {
    var hide, show;
    if (selected == 'orig') {
        hide = '.reg';
        show = '.orig';
    } else {
        hide = '.orig';
        show = '.reg';
    }
    $(hide).hide();
    $(show).show();
};*/

// Personen im Text

/*$( document ).ready(function() {
    $('.rs-ref-person').click(
        
 function (event) {
   var href = $(this).attr('href');

   if (href && href.substring(0,1) === '#') {
     var target = $(href);
     if (target) {
       if (target.hasClass('visible')) {
         if ($(href, this).length > 0) {
            target.detach();
            target.removeClass('visible');
            $('#register').append(target);
            $(this).removeClass('register-info');
         } else {
            target.parent().removeClass('register-info');
            target.detach();
            $(this).append(target);
            $(this).addClass('register-info');
         }
       } else {
         target.detach();
         target.addClass('visible');
         $(this).append(target);
         $(this).addClass('register-info');
       }
     }
   }
   event.preventDefault();
  event.preventDefault();
 }
 );
 }); */
 
 
// Orte im Text

/*$( document ).ready(function() {
    $('.rs-ref-place').click(
        
 function (event) {
   var href = $(this).attr('href');

   if (href && href.substring(0,1) === '#') {
     var target = $(href);
     if (target) {
       if (target.hasClass('visible')) {
         if ($(href, this).length > 0) {
            target.detach();
            target.removeClass('visible');
            $('#register').append(target);
            $(this).removeClass('register-info');
         } else {
            target.parent().removeClass('register-info');
            target.detach();
            $(this).append(target);
            $(this).addClass('register-info');
         }
       } else {
         target.detach();
         target.addClass('visible');
         $(this).append(target);
         $(this).addClass('register-info');
       }
     }
   }
   event.preventDefault();
  event.preventDefault();
 }
 );
 }); */