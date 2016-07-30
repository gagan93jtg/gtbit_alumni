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
                     console.log("error "+e);
              })
              .always(function()
              {
                     $('.loading').css('display','none');
              });

       });

       $("#edit_history_modal").on('hidden.bs.modal', function ()
       {
              $(this).data('bs.modal', null);
       });
}

function show_on_modal(data)
{
       $('.modal-body').html("<div class='modal_body_question'></div>")
       for (i = 0 ; i < data.length; i++)
              $(".modal_body_question").append("\
                     <div class='modal_question'>\
                     <div class='query_string user-post'> " + data[i].query_string + "</div>\
                     <span class='tags user-post user-tags'> " + data[i].tags + "</span>\
                     </div>");
}
