function RTW_SidParentMap() {
    this.sidParentMap = new Array();
    this.sidParentMap["pwm:9"] = "pwm:6";
    this.sidParentMap["pwm:8"] = "pwm:6";
    this.sidParentMap["pwm:7"] = "pwm:6";
    this.getParentSid = function(sid) { return this.sidParentMap[sid];}
}
    RTW_SidParentMap.instance = new RTW_SidParentMap();
