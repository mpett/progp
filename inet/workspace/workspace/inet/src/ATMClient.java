import java.io.*;   
import java.net.*;  
import java.util.Scanner;

/**
   @author Snilledata
*/
public class ATMClient {
    private static int connectionPort = 8989;
	private static Moss moss;
    
    public static void main(String[] args) throws IOException {
        
        Socket ATMSocket = null;
        PrintWriter out = null;
        BufferedReader in = null;
        String adress = "";
        

        try {
            adress = args[0];
        } catch (ArrayIndexOutOfBoundsException e) {
            System.err.println("Missing argument ip-adress");
            System.exit(1);
        }
        try {
            ATMSocket = new Socket(adress, connectionPort); 
            out = new PrintWriter(ATMSocket.getOutputStream(), true);
            in = new BufferedReader(new InputStreamReader
                                    (ATMSocket.getInputStream()));
        } catch (UnknownHostException e) {
            System.err.println("Unknown host: " +adress);
            System.exit(1);
        } catch (IOException e) {
            System.err.println("Couldn't open connection to " + adress);
            System.exit(1);
        }

		moss = new Moss(in,out);

        System.out.println("Contacting bank ... ");

        
        Scanner scanner = new Scanner(System.in);
        int userInput;
        boolean loggedIn = false;
        while(!loggedIn) {
//        	System.out.println(in.readLine());	//enter cardnr
        	System.out.println(moss.read());
        	System.out.print("> ");
            userInput = scanner.nextInt();
//          out.println(userInput);				//send cardnr to server
            moss.write("" + userInput);
            
//          System.out.println(in.readLine());	//enter PIN
        	System.out.println(moss.read());
            System.out.print("> ");
            userInput = scanner.nextInt();
//            out.println(userInput);				//send PIN to server
            moss.write("" + userInput);
            
//			String loginAns = in.readLine();
            String loginAns = moss.read();
            loggedIn = loginAns.startsWith("t");
            System.out.println(loginAns.substring(1));
        }
        
//        System.out.println(in.readLine()); //receive & print welcome message
//        System.out.println(in.readLine()); //receive & print menu
        
    	System.out.println(moss.read());
    	System.out.println(moss.read());


        System.out.print("> ");
        int menuOption = scanner.nextInt();
//        out.println(menuOption);
        moss.write("" + menuOption);

        
        while (menuOption != 5) {
            switch (menuOption) {
            case 2:
//                System.out.println(in.readLine());	//Enter verification code
            	System.out.println(moss.read());
                System.out.print("> ");
                userInput = scanner.nextInt();
//                out.println(userInput);				//send verification code to server
                moss.write("" + userInput);

//              String verifAns = in.readLine();
                String verifAns = moss.read();
                System.out.println(verifAns.substring(1));
                if(verifAns.startsWith("f")){
//                	System.out.println(in.readLine()); //print menu
                	System.out.println(moss.read());

                	System.out.print("> ");
                	menuOption = scanner.nextInt();
//                	out.println(menuOption);
                    moss.write("" + menuOption);
                	break;
                }

            case 3:
//            	System.out.println(in.readLine()); //Enter amount:	
            	System.out.println(moss.read());
                System.out.print("> ");
                userInput = scanner.nextInt();
//                out.println(userInput);				//send amount
                moss.write("" + userInput);

            case 1:
//            	System.out.println(in.readLine()); //print balance
//            	System.out.println(in.readLine()); //print menu
            	
            	System.out.println(moss.read());
            	System.out.println(moss.read());

            	System.out.print("> ");
            	menuOption = scanner.nextInt();
//            	out.println(menuOption);
                moss.write("" + menuOption);
                break;
                
            case 4:
//            	System.out.println(in.readLine()); //print lang menu
            	System.out.println(moss.read());

                System.out.print("> ");
                userInput = scanner.nextInt();
//                out.println(userInput);				//send langChoice
                moss.write("" + userInput);
            	
//            	System.out.println(in.readLine()); //print menu
            	System.out.println(moss.read());
            	System.out.print("> ");
            	menuOption = scanner.nextInt();
//            	out.println(menuOption);
                moss.write("" + menuOption);
                break;
            case 5:
                break;
            default: 
                break;
            }
        
        }
//    	System.out.println(in.readLine()); //print good bye
    	System.out.println(moss.read());

        out.close();
        in.close();
        ATMSocket.close();
    }
}   
