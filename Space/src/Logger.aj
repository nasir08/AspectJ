import java.io.FileWriter;
import java.io.IOException;
import java.io.BufferedWriter;
import java.io.File;

public aspect Logger {
	pointcut Log(Crew c) : execution(* *.*(..)) &&
	this(c)
	&& !execution(* *.toString());
	after(Crew c) : Log(c){
		long timer = System.currentTimeMillis()%1000;
		StackTraceElement caller = new Throwable().getStackTrace()[1];
		String Data = timer+" : "+caller.getMethodName();
		Data = Data.replace("ajc$interMethod$", "");
		Data = Data.replace("$", " : ");
		Data = Data.replace("Crew", c.toString());
		File file = new File("system-logs.txt");
		FileWriter fw;
		try {
			fw = new FileWriter(file,true);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(Data);
			bw.newLine();
			bw.close();
		}catch (IOException e) {
			e.printStackTrace();
		}
	}
}
