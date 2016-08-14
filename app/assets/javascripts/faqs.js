function bind_event_to_faq_questions(count)
{
  $('.faq_question').click(function(event)
  {
    cls = $(this).attr('class').split(' ')[1];
    cls = cls.substring(7, cls.length);
    $('.' + cls).slideToggle(1000);
  });
}
