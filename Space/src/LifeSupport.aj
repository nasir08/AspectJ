public aspect LifeSupport {
	public String Crew.lifeStatus = "alive";
	public String Crew.getLifeStatus(){
		return this.lifeStatus;
	}
	
	pointcut filter(Crew c, OnBoardComputer o) : call(* OnBoardComputer.*(..)) &&
	this(c) &&
	target(o);
	Object around(Crew c, OnBoardComputer o) : filter(c,o){
		String str = c.getLifeStatus();
		if(str == "dead"){
			return null;
		}
		else{
			return proceed(c,o);
		}
	}
}
