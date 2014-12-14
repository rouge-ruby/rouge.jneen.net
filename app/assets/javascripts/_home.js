$(document).ready(function() {
  var inputTimer;

  $('form.parse').bind('ajax:success', function(e, data, status, xhr) {
    $('pre.highlight').replaceWith(data);
  });

  $('#parse_source').on('input', function() {
    submitSource($(this).val());
  });

  var submitSource = function(source) {
    clearTimeout(inputTimer);
    inputTimer = setTimeout(function() {
      $('section.demo form').submit();
    }, 500);
  }
});
