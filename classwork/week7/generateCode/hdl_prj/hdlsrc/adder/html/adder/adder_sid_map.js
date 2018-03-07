function RTW_SidParentMap() {
    this.sidParentMap = new Array();
    this.sidParentMap["adder:15"] = "adder:14";
    this.sidParentMap["adder:16"] = "adder:14";
    this.sidParentMap["adder:12"] = "adder:14";
    this.sidParentMap["adder:17"] = "adder:14";
    this.getParentSid = function(sid) { return this.sidParentMap[sid];}
}
    RTW_SidParentMap.instance = new RTW_SidParentMap();
