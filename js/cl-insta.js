$(document).ready(function () {
    $('#code-pane').keypress(function (e) {
	var key = e.key;
	var ctrlKey = e.ctrlKey;
	var code_data = '';
	
	if (ctrlKey && (key == "Enter")) {
	    code_data = $('#code-pane').val();
	    
	    $.ajax({
		type: 'POST',
		url: '/eval-code',
		data: code_data,
		dataType: 'json',
		success: function (result) {
		    var line = 0, start_line = 1;
		    var result_data = '';
		    
		    console.log(result);
		    result_data = '';
		    for (line in result) {
			while (start_line < line) {
			    result_data += '\n';
			    start_line++;
			}

			result_data += result[line];
			start_line = line;
		    }

		    $('#result-pane').val(result_data);
		}
	    });
	}
    });
});

