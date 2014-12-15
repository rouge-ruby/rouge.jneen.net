$(document).ready(function() {
  var inputTimer;

  var submitSource = function() {
    clearTimeout(inputTimer);
    inputTimer = setTimeout(function() {
      $('section.demo form').submit();
    }, 500);
  }

  $('form.parse').bind('ajax:success', function(e, data, status, xhr) {
    $('pre.highlight').replaceWith(data);
  });

  $('#parse_source').on('input', submitSource);
  $('#parse_language').on('change', submitSource)
});
