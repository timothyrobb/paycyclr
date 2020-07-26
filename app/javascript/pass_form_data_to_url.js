import $ from 'jquery';
$(document).on('click', '[data-pass-data-to]', function(e) {
  e.preventDefault();
  var form = $(this).closest('form')[0];
  var url = $(this).attr('data-pass-data-to');
  form.action = url;
  form.method = "GET";
  form.submit();
});
