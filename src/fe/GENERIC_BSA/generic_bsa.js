function Disable_Control_C() {
	var keystroke = String.fromCharCode(event.keyCode).toLowerCase();
	if (event.ctrlKey && (keystroke == 'c' || keystroke == 'v')) {
	event.returnValue = false; // disable Ctrl+C
	}
}

document.oncontextmenu = function(){return false};
document.onkeydown = Disable_Control_C;