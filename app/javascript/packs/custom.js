import $ from 'jquery';

$(document).ready(function() {
  $('#modal').on('hidden.bs.modal', function(){
    $('.errors').html('')
  });
});