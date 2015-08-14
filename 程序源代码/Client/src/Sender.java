import javax.microedition.midlet.*;
import javax.microedition.io.*;
import javax.microedition.lcdui.*;
import java.io.*;

public class Sender extends Thread
{	private DataOutputStream os;
	private String message;
	private String test;
	public Sender(DataOutputStream os)
	{
	this.os=os;
	start();
	}

	
	public synchronized void send(String msg)
	{
	message=msg;
	notify();
	}

	public synchronized void run()
	{
		while(true)
		{
		if(message==null)
		{
		try{
		wait();
		}catch(InterruptedException e){}
		}
		if(message==null)
		{
		break;
		}
		try
			{
			//test=URLEncode(message);
			//os.write(message.getBytes());
			//os.write(message);
			  os.write(message.getBytes("UTF-8"));   
			}catch(IOException ioe){ioe.printStackTrace();}
		message=null;
		}

	}

	public synchronized void stop()
	{
	message=null;
	notify();
	}


}
