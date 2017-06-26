$(document).ready(function() {
  var inputTimer;
  var modified = false;

  var submitSource = function() {
    clearTimeout(inputTimer);
    inputTimer = setTimeout(function() {
      $('section.demo form.parse').submit();
    }, 500);
  }

  function inputModified() {
    modified = true;

    submitSource();
  }

  function changeLanguage() {
    if (!modified) {
      $('#parse_source').val('')
    }
    else if (!$('#parse_source').val()) {
      modified = false;
    }

    submitSource();
  }

  function highlightReady(e, data, status, xhr) {
    data = $(data);
    $('pre.highlight').replaceWith(data.find('pre.highlight'));
    if (!modified) {
      $('#parse_source').val(data.find('pre.source').text())
    }
  }

  $('form.parse').bind('ajax:success', highlightReady);

  $('#parse_source').on('input', inputModified);
  $('#parse_language').on('change', changeLanguage)

  $('form.new_paste input[type=submit]').on('click', function() {
    $('#paste_language').val($('#parse_language').val());
    $('#paste_source').val($('#parse_source').val());

    return true;
  });

  $(document).ready(function() {
    $('#parse_language').val($('#parse_result').data('lang'))
  });
});
