function bind_edit_history_modal_click(id)
{
 $('.edit_history').click(function()
 {
  $('.loading').css('display','inline-block');
  $.ajax({
   url: '/posts/edit_history',
   type: 'GET',
   data: {id: id}
 })
  .done(function(data)
  {
   show_on_modal(data)
 })
  .fail(function(error)
  {
   $('.modal-body').html('Error encountered ! We have been notified about the same. Try again later');
 })
  .always(function()
  {
   $('.loading').css('display','none');
 });

});
}

function style_tags(element)
{
  tags = $(element).html().trim().split(',');
  $(element).html("Tags : ");
  for (tag in tags)
  {
    $(element).append('<span class="user-tag"> ' + tags[tag] + '</span>');
  }
}

function show_on_modal(data)
{
 $('.modal-body').html("<div class=' modal_body_question'></div>")
 for (index in data)
 {
  $(".modal_body_question").append("\
   <div class='modal_question transparent-panel-full-width'>\
   <div class='query_string user-post'> " + data[index].query_string + "</div>\
   <span class='user-tags user-tags-modal" + index+"'> " + data[index].tags + "</span>\
   </div>");

  style_tags('.user-tags-modal'+index);
}
}
