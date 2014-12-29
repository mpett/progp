import java.io.*;


public class User {
	private int cardnr;
	private int pin;
	private int balance;
	
	public User(int cardnr, int pin) {
		this.cardnr = cardnr;
		this.pin = pin;
		balance = getBalance();
	}
	
	public int getCardnr() {
		return cardnr;
	}
	
	public int getBalance() {
		try{
			// Open the file that is the first 
			// command line parameter
			FileInputStream fstream = new FileInputStream(cardnr + ".txt");
			// Get the object of DataInputStream
			DataInputStream in = new DataInputStream(fstream);
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			balance = Integer.parseInt(br.readLine());
			//Close the input stream
			in.close();
			return balance;
		}catch (Exception e){//Catch exception if any
			System.err.println("Error: " + e.getMessage());
			return 0;
		}
	}
	
	public void setBalance(int balance) {
		try{
			// Create file 
			FileWriter fstream = new FileWriter(cardnr + ".txt");
			BufferedWriter out = new BufferedWriter(fstream);
			out.write(""+balance);
			//Close the output stream
			out.close();
		}catch (Exception e){//Catch exception if any
			System.err.println("Error: " + e.getMessage());
		}
	}

	public boolean login(int cardnr, int pin) {
		return (this.cardnr == cardnr && this.pin == pin);
	}
	
}
