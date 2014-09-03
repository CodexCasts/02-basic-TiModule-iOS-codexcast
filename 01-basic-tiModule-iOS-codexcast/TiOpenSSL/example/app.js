// open a single window
var win = Ti.UI.createWindow({
	backgroundColor: 'white'
});
var label = Ti.UI.createLabel();
win.add(label);
win.open();

var TiOpenSSL = require('com.codexlabs.tiopenssl');
Ti.API.info("Module is => " + TiOpenSSL);
var secret ="meet me by the bench at noon";
label.text = Ti.OpenSSL.cryptoMessage(secret);

// this code is for demonstrating how to pass a message to the kroll layer
// and how to get an value back from kroll. This particular module has not
// been vetted for secure coding practices.