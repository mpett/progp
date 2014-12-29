import java.io.*;
import java.net.*;

import java.util.ArrayList;

import org.w3c.dom.*;
import javax.xml.parsers.*; 
import javax.xml.transform.*; 
import javax.xml.transform.dom.DOMSource; 
import javax.xml.transform.stream.StreamResult; 
import org.xml.sax.SAXException;

/**
   @author MaMa
*/
public class ATMServerThread extends Thread {
    private Socket socket = null;
    static private BufferedReader in;
    static private PrintWriter out;
    static private Moss moss; 
    

    
    public ATMServerThread(Socket socket) throws Exception {
        super("ATMServerThread");
        this.socket = socket;
        
        out = new PrintWriter(socket.getOutputStream(), true);
        in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        
        moss = new Moss(in,out);
    }

    public void run(){
         
        try {
            String inputLine;        

            String cardNumber = login();
            if (cardNumber != null)
            {
            
            moss.write(getMenuText(cardNumber));
            inputLine = moss.read();
            int choise = Integer.parseInt(inputLine);
            
            while (choise != 4) {
                switch (choise) {
                case 1:
                    moss.write(getBalanceText(cardNumber) + getUserBalance(cardNumber));
                    break;
                case 2:
                	moss.write(getInputText(cardNumber));
                    String wMoneys = moss.read();
                    deleteFromUserBalance(cardNumber, wMoneys);
                    moss.write(getBalanceText(cardNumber) + getUserBalance(cardNumber));
                	break;
                case 3:
                	moss.write(getInputText(cardNumber));
                    String dMoneys = moss.read();
                    addToUserBalance(cardNumber, dMoneys);
                    moss.write(getBalanceText(cardNumber) + getUserBalance(cardNumber));
                	break;
                    
                default: 
                    break;
                }
                
                moss.write(getMenuText(cardNumber));
                inputLine = moss.read();
                choise = Integer.parseInt(inputLine);
            }
            }
            //moss.write("Good Bye");
            out.close();
            in.close();
            socket.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    
    }

    private String login() throws IOException, SAXException, ParserConfigurationException
    {
    	//Load general strings
    	String welcomeText = "";
    	String cardNumberInputText = "";
    	String numberCodeInputText = "";
    	String loginOkText = "";
    	String loginNotOkText = "";
		Node root =				DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new File("Stuff.xml")).getDocumentElement();
		welcomeText =			findChildNode(findChildNode(root, "general"), "welcometext").getTextContent();
		cardNumberInputText =	findChildNode(findChildNode(root, "general"), "cardnumberinputtext").getTextContent();
		numberCodeInputText =	findChildNode(findChildNode(root, "general"), "numbercodeinputtext").getTextContent();
		loginOkText =			findChildNode(findChildNode(root, "general"), "loginoktext").getTextContent();
		loginNotOkText =		findChildNode(findChildNode(root, "general"), "loginnotoktext").getTextContent();
		
		//Communicate login
		moss.write(welcomeText);
		moss.write(cardNumberInputText);
		String cardNumberInput = "a" + moss.read();
		System.out.println(cardNumberInput);
		moss.write(numberCodeInputText);

		String numberCodeInput = moss.read();
		try {
			Node outNode = findChildNode(findChildNode(root, "users"), cardNumberInput);
			if (findChildNode(outNode, "numbercode").getTextContent().equals(numberCodeInput))
			{
				moss.write("ok");
				moss.write(loginOkText);
				return outNode.getNodeName();
			}
		} catch(Exception e){}

		moss.write("notok");
		moss.write(loginNotOkText);
		return null;
    }

    private String getMenuText(String cardnumber) throws SAXException, IOException, ParserConfigurationException
    {
		Node root = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new File("Stuff.xml")).getDocumentElement();	
		return  findChildNode(findChildNode(findChildNode(root, "languages"), getUserLanguage(cardnumber)), "menutext").getTextContent();
    }
    private String getBalanceText(String cardnumber) throws SAXException, IOException, ParserConfigurationException
    {
		Node root = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new File("Stuff.xml")).getDocumentElement();			
	    return findChildNode(findChildNode(findChildNode(root, "languages"), getUserLanguage(cardnumber)), "balancetext").getTextContent();
    }
    private String getInputText(String cardnumber) throws SAXException, IOException, ParserConfigurationException
    {
		Node root = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new File("Stuff.xml")).getDocumentElement();
	    return findChildNode(findChildNode(findChildNode(root, "languages"), getUserLanguage(cardnumber)), "inputtext").getTextContent();
    }
   
    private String getUserLanguage(String cardnumber) throws SAXException, IOException, ParserConfigurationException
    {
    	Node root = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new File("Stuff.xml")).getDocumentElement();
    	return findChildNode(findChildNode(findChildNode(root, "users"), cardnumber), "language").getTextContent();
    }
    private String getUserBalance(String cardnumber) throws SAXException, IOException, ParserConfigurationException
    {
    	Node root = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new File("Stuff.xml")).getDocumentElement();
    	return findChildNode(findChildNode(findChildNode(root, "users"), cardnumber), "balance").getTextContent();
    }
    
    private void addToUserBalance(String cardnumber, String amount) throws SAXException, IOException, ParserConfigurationException, TransformerException
    {    	
    	Node root = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new File("Stuff.xml")).getDocumentElement();
    	Node node = findChildNode(findChildNode(findChildNode(root, "users"), cardnumber), "balance");
    	node.setTextContent((Integer.parseInt(node.getTextContent()) + Integer.parseInt(amount))+"");
    	
        //setting up a transformer
        TransformerFactory transfac = TransformerFactory.newInstance();
        Transformer trans = transfac.newTransformer();
     
        //generating string from xml tree
        StringWriter sw = new StringWriter();
        StreamResult result = new StreamResult(sw);
        DOMSource source = new DOMSource(root);
        trans.transform(source, result);
        String xmlString = sw.toString();
     
        //Saving the XML content to File
        OutputStream f0;
        byte buf[] = xmlString.getBytes();
        f0 = new FileOutputStream("Stuff.xml");
        for(int i=0;i<buf .length;i++) {
     	f0.write(buf[i]);
        }
    	f0.close();
    	buf = null;
    	
    }
    private void deleteFromUserBalance(String cardnumber, String amount) throws SAXException, IOException, ParserConfigurationException, TransformerException
    {
    	Node root = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new File("Stuff.xml")).getDocumentElement();
    	Node node = findChildNode(findChildNode(findChildNode(root, "users"), cardnumber), "balance");
    	node.setTextContent((Integer.parseInt(node.getTextContent()) - Integer.parseInt(amount))+"");
    	
        //setting up a transformer
        TransformerFactory transfac = TransformerFactory.newInstance();
        Transformer trans = transfac.newTransformer();
     
        //generating string from xml tree
        StringWriter sw = new StringWriter();
        StreamResult result = new StreamResult(sw);
        DOMSource source = new DOMSource(root);
        trans.transform(source, result);
        String xmlString = sw.toString();
     
        //Saving the XML content to File
        OutputStream f0;
        byte buf[] = xmlString.getBytes();
        f0 = new FileOutputStream("Stuff.xml");
        for(int i=0;i<buf .length;i++) {
     	f0.write(buf[i]);
        }
    	f0.close();
    	buf = null;
    }
    
    private Node findChildNode(Node node, String name)
    {
    	NodeList nodeList = node.getChildNodes();

    	for (int i = 0; i < nodeList.getLength(); i++)
    		if (nodeList.item(i).getNodeName().equals(name))
    			return nodeList.item(i);
    	
    	return null;
    }
}