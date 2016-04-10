public aspect Authorization {
	public int Crew.noOfShutDownAttempts = 0;
	public void Crew.kill(){
		this.lifeStatus = "dead";
	}
	
	pointcut blocker(Crew c, OnBoardComputer o) : call(String OnBoardComputer.getMissionPurpose()) &&
	this(c) &&
	target(o);
	String around(Crew c, OnBoardComputer o) : blocker(c,o){
		return(o.toString()+" cannot diaclose that information "+c.toString()+".");
	}
	
	pointcut blocker2(Crew c, OnBoardComputer o) : call(void OnBoardComputer.shutDown()) &&
	this(c) &&
	target(o);
	void around(Crew c, OnBoardComputer o) : blocker2(c,o){
		c.noOfShutDownAttempts++;
		if(c.noOfShutDownAttempts == 1){
			System.out.println("Can't do that "+c.toString()+".");
		}
		else if(c.noOfShutDownAttempts == 2){
			System.out.println("Can't do that "+c.toString()+" and do not ask me again.");
		}
		else{
			System.out.println("You are being retired "+c.toString()+".");
			c.kill();
		}
	}
}
