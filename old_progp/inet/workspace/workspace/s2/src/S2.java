import java.io.*;
import java.util.regex.*;

public class S2 {
	private static BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
	private static String chars = "a-z0-9+_\\-$!#*^%`~=&?/{}|";
	private static String regex = String.format("[%s]+(\\.[%s]+)*@([a-z0-9]+\\.)+(se|nu|com|net|org)", chars, chars);
	private static Pattern pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
	public static void main (String[] args) {
		read();

	}

	static private void read() {
		try {
			while(true) {
				String line = in.readLine();
				if(line == null)
					return;
				process(line);
			}

		} catch (IOException e) {
		}
	}
	
	static private void process(String line) {
		if(pattern.matcher(line).matches()) {
			System.out.println(line + "\tja");
		} else {
			System.out.println(line + "\tnej");
		}
	}
}
