function RTW_Sid2UrlHash() {
	this.urlHashMap = new Array();
	/* <S1>/Sum */
	this.urlHashMap["adder:12"] = "Subsystem.vhd:49";
	this.getUrlHash = function(sid) { return this.urlHashMap[sid];}
}
RTW_Sid2UrlHash.instance = new RTW_Sid2UrlHash();
function RTW_rtwnameSIDMap() {
	this.rtwnameHashMap = new Array();
	this.sidHashMap = new Array();
	this.rtwnameHashMap["<Root>"] = {sid: "adder"};
	this.sidHashMap["adder"] = {rtwname: "<Root>"};
	this.rtwnameHashMap["<S1>/In1"] = {sid: "adder:15"};
	this.sidHashMap["adder:15"] = {rtwname: "<S1>/In1"};
	this.rtwnameHashMap["<S1>/In2"] = {sid: "adder:16"};
	this.sidHashMap["adder:16"] = {rtwname: "<S1>/In2"};
	this.rtwnameHashMap["<S1>/Sum"] = {sid: "adder:12"};
	this.sidHashMap["adder:12"] = {rtwname: "<S1>/Sum"};
	this.rtwnameHashMap["<S1>/Out1"] = {sid: "adder:17"};
	this.sidHashMap["adder:17"] = {rtwname: "<S1>/Out1"};
	this.getSID = function(rtwname) { return this.rtwnameHashMap[rtwname];}
	this.getRtwname = function(sid) { return this.sidHashMap[sid];}
}
RTW_rtwnameSIDMap.instance = new RTW_rtwnameSIDMap();
