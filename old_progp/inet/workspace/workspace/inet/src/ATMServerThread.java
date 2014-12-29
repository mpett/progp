import java.io.*;
import java.net.*;
import java.util.Hashtable;

/**
   @author Viebrapadata
 */
public class ATMServerThread extends Thread {
	private Socket socket = null;
	private BufferedReader in;
	PrintWriter out;
	private Moss moss;
	
	private Hashtable<Integer, User> users = new Hashtable<Integer, User>();

	private String[] currentLang = {"(1)Balance, (2)Withdrawal, (3)Deposit, (4)Language, (5)Exit",
			"Enter verification code:",
			"Code verified!",
			"ACCESS DENIED",
			"Enter amount:",
			"Current balance is ",
			" dollars",
			"What language? (1)English, (2)Swedish",
			"Good Bye"};
	
	private String[] engLang = {"(1)Balance, (2)Withdrawal, (3)Deposit, (4)Language, (5)Exit",
			"Enter verification code:",
			"Code verified!",
			"ACCESS DENIED",
			"Enter amount:",
			"Current balance is ",
			" dollars",
			"What language? (1)English, (2)Swedish",
			"Good Bye"};
	
	private String[] sweLang = {"(1)Saldo, (2)Uttag, (3)Insättning, (4)Språk, (5)Avsluta",
			"Mata in engångskod:",
			"Engångskod verifierad",
			"ÅTKOMST NEKAD",
			"Ange belopp:",
			"Saldo: ",
			" dollar",
			"Välj språk: (1)Engelska, (2)Svenska",
			"Tjarå"};

	private int[] auth_codes = {1, 3, 5, 7, 9,
								11, 13, 15, 17, 19,
								21, 23, 25, 27, 29,
								31, 33, 35, 37, 39,
								41, 43, 45, 47, 49,
								51, 53, 55, 57, 59,
								61, 63, 65, 67, 69,
								71, 73, 75, 77, 79,
								81, 83, 85, 87, 89,
								91, 93, 95, 97, 99};
	
	public ATMServerThread(Socket socket) {
		super("ATMServerThread");
		this.socket = socket;

		users.put(573, new User(573, 1234));
		users.put(1337, new User(1337, 1337));
		users.put(2, new User(2, 2222));
	}

//	private String readLine() throws IOException {
//		String str = in.readLine();
//		//System.out.println(""  + socket + " : " + str);
//		return str;
//	}

	private boolean verifyCode(int code){
		boolean verified = false;
		for(int i : auth_codes) {
			if (i == code)
				verified = true;
		}
			
		return verified;
	}

	public void run(){

		try {
			out = new PrintWriter(socket.getOutputStream(), true);
			in = new BufferedReader
			(new InputStreamReader(socket.getInputStream()));

			moss = new Moss(in,out);
			
			String inputLine, outputLine;

			int cardnr = 0;
			int value;

			boolean loggedIn = false;

			while(!loggedIn) {
				outputLine = "Hi! Enter cardnr: ";
//				out.println(outputLine);
				moss.write(outputLine);
//				inputLine = readLine();
				inputLine = moss.read();
				cardnr = Integer.parseInt(inputLine);

				outputLine = "PIN code: ";
//				out.println(outputLine);
				moss.write(outputLine);
//				inputLine = readLine();
				inputLine = moss.read();
				int pin = Integer.parseInt(inputLine);

				if(users.containsKey(cardnr) && users.get(cardnr).login(cardnr, pin)) {
					outputLine = "t" + "Login successful";
//					out.println(outputLine);
					moss.write(outputLine);
					loggedIn = true;
				} else {
					outputLine = "f" + "Wrong cardnumber or PIN. Try again.";
//					out.println(outputLine);
					moss.write(outputLine);
				}
			}

//			out.println(getWelcome());
//			out.println(currentLang[0]);
			
			moss.write(getWelcome());
			moss.write(currentLang[0]);
//			inputLine = readLine();
			inputLine = moss.read();
			int choice = Integer.parseInt(inputLine);

			while (choice != 5) {
				int deposit = 1;
				switch (choice) {
				case 2:

//					out.println(currentLang[1]);
					moss.write(currentLang[1]);
//					inputLine = readLine();
					inputLine = moss.read();
					int code = Integer.parseInt(inputLine);

					if(verifyCode(code)) {
						outputLine = "t" + currentLang[2];
//						out.println(outputLine);
						moss.write(outputLine);
						deposit = -1;
					} else {
						outputLine = "f" + currentLang[3];
//						out.println(outputLine);
//						out.println(currentLang[0]);
						moss.write(outputLine);
						moss.write(currentLang[0]);
//						inputLine = readLine();
						inputLine = moss.read();
						choice = Integer.parseInt(inputLine);
						break;
					}
				case 3:
//					out.println(currentLang[4]);
					moss.write(currentLang[4]);	
//					inputLine = readLine();
					inputLine = moss.read();
					value = Integer.parseInt(inputLine);
					int balance = users.get(cardnr).getBalance();
					users.get(cardnr).setBalance(balance += deposit * value);
				case 1:
//					out.println(currentLang[5] + users.get(cardnr).getBalance() + currentLang[6]);
//					out.println(currentLang[0]);
					moss.write(currentLang[5] + users.get(cardnr).getBalance() + currentLang[6]);
					moss.write(currentLang[0]);
//					inputLine = readLine();
					inputLine = moss.read();
					choice = Integer.parseInt(inputLine);
					break;
				case 4:
//					out.println(currentLang[7]);
					moss.write(currentLang[7]);
//					inputLine = readLine();
					inputLine = moss.read();
					int langChoice = Integer.parseInt(inputLine);
					setLang(langChoice);
//					out.println(currentLang[0]);
					moss.write(currentLang[0]);
//					inputLine = readLine();
					inputLine = moss.read();
					choice = Integer.parseInt(inputLine);
					break;
				case 5:
					break;
				default: 
					break;
				}
			}
//			out.println(currentLang[8]);
			moss.write(currentLang[8]);
			out.close();
			in.close();
			socket.close();
		}catch (IOException e){
			e.printStackTrace();
		}

	}

	private void setLang(int lang) {
		switch(lang) {
		case 1:
		currentLang = engLang;
		break;
		case 2:
		currentLang = sweLang;
		break;
		}
	}

	private String getWelcome() {
		try{
			// Open the file that is the first 
			// command line parameter
			FileInputStream fstream = new FileInputStream("welcome_message.txt");
			// Get the object of DataInputStream
			DataInputStream in = new DataInputStream(fstream);
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			String welcomeMessage = br.readLine();
			if (welcomeMessage.length() > 80)
				welcomeMessage = welcomeMessage.substring(0, 80);
			//Close the input stream
			in.close();
			return welcomeMessage;
		}catch (Exception e){//Catch exception if any
			System.err.println("Error: " + e.getMessage());
			return "Welcome to bank!";
		}
		
	}

}

