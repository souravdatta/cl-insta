function escapeHTML(string)
{
    var pre = document.createElement('pre');
    var text = document.createTextNode( string );
    pre.appendChild(text);
    return pre.innerHTML;
}


$(document).ready(function () {
    var myCodeMirror = CodeMirror(document.getElementById('code-pane'));
    console.log(myCodeMirror);
    
    $('#code-pane').keypress(function (e) {
	var keyCode = e.keyCode;
	var ctrlKey = e.ctrlKey;
	var code_data = '';
	
	if (ctrlKey && ((keyCode == 10) || (keyCode == 13))) {
	    code_data = myCodeMirror.getValue();
	    console.log(code_data);
	    
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
			    result_data += '<br/>';
			    start_line++;
			}
			result_data += escapeHTML(result[line]);
			start_line = line;
		    }

		    $('#result-pane').html(result_data);
		}
	    });
	}
    });
});

