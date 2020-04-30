import $ from 'jquery';

$('.add-task-fields').on('click', function() {
  var regexp, time;
  time = new Date().getTime();
  regexp = new RegExp($(this).data('id'), 'g');
  $('.task-fields').append($(this).data('fields').replace(regexp, time));
  return event.preventDefault();
});

$('form').on('click', '.remove-task-field', function() {
  $(this).prev('input[type=checkbox]').prev('input[type=hidden]').val('1');
  $(this).closest('tr').fadeOut();
  return event.preventDefault();
})