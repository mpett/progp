import java.io.*;


public class S1 {
	public static BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

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
				System.out.println();
			}

		} catch (IOException e) {
		}
	}

	static private void process(String line) {
		String[] tmp = line.split(" *[\t;,] *");
		for(int i = tmp.length-1 ; i >= 0 ; i--) {
			System.out.print(tmp[i] + "\t");
		}
	}
}
