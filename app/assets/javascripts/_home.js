$(document).ready(function() {
  var inputTimer;

  var submitSource = function() {
    clearTimeout(inputTimer);
    inputTimer = setTimeout(function() {
      $('section.demo form.parse').submit();
    }, 500);
  }

  $('form.parse').bind('ajax:success', function(e, data, status, xhr) {
    $('pre.highlight').replaceWith(data);
  });

  $('#parse_source').on('input', submitSource);
  $('#parse_language').on('change', submitSource)

  $('form.new_paste input[type=submit]').on('click', function() {
    $('#paste_language').val($('#parse_language').val());
    $('#paste_source').val($('#parse_source').val());

    return true;
  });

  $(document).ready(function() {
    $('#parse_language').val($('#parse_result').data('lang'))
  });
});
