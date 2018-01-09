$(document).ready(function () {
    $('#code-pane').keypress(function (e) {
	var keyCode = e.keyCode;
	var ctrlKey = e.ctrlKey;
	var code_data = '';
	
	if (ctrlKey && ((keyCode == 10) || (keyCode == 13))) {
	    code_data = $('#code-pane').val();
	    
	    $.ajax({
		type: 'POST',
		url: '/eval-code',
		data: code_data,
		dataType: 'json',
		success: function (result) {
		    var line = 0, start_line = 1;
		    var result_data = '';
		  
		    result_data = '';
		    for (line in result) {
			line = parseInt(line);

			while (start_line < line) {
			    result_data += '\n';
			    start_line++;
			}
			result_data += result[line];
			start_line = line;
		    }

		    $('#result-pane').text(result_data);
		}
	    });
	}
    });
});

