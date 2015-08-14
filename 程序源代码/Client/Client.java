import javax.microedition.midlet.*;
import javax.microedition.io.*;
import javax.microedition.lcdui.*;
import java.io.*;

public class Client extends MIDlet implements Runnable,
CommandListener{
	//������
	private Display display;
	private Form main,Mycmd,MyMessageBox,MyWebPage,MyMouse,MyMovie,MyWakeup;

	private StringItem si,cmdRet,successRet,sTips;
	private TextField user,pass,sf,cmdline,title,context,url,mtime,moviename,dns,mac;//���Ѷ˿ھ�Ĭ��Ϊ2012��!
	private boolean stop;
	private Command startCommand=new Command("����Server",Command.ITEM,1);
	private Command exitCommand=new Command("�˳�����",Command.EXIT,1);
	private Command backCommand=new Command("�ص�����",Command.ITEM,1);

	private Command shutCommand=new Command("�ػ�",Command.ITEM,1);
	private Command resetCommand=new Command("����",Command.ITEM,1);
	private Command standbyCommand=new Command("ע��",Command.ITEM,1);

	private Command overlookCommand=new Command("ʹ�ü��(��/��)",Command.ITEM,1);
	private Command monitorCommand=new Command("��ʾ��(��/��)",Command.ITEM,1);
	private Command cdCommand=new Command("����(��/��)",Command.ITEM,1);
	private Command udiskCommand=new Command("U���ļ����(��/��)",Command.ITEM,1);
	private Command lockCommand=new Command("���������(��/��)",Command.ITEM,1);
        private Command shakeCommand=new Command("������ɧ��(��/��)",Command.ITEM,1);

	private Command telnetCommand=new Command("dos����ģ��",Command.ITEM,1);
	private Command dosCommand=new Command("dos����ִ��",Command.ITEM,1);

	private Command messageboxCommand=new Command("������Ϣ��",Command.ITEM,1);
	private Command sendmessageCommand=new Command("������Ϣ",Command.ITEM,1);
	
	private Command webpageCommand=new Command("����ҳ",Command.ITEM,1);	
	private Command webpageCommandM=new Command("����ҳ",Command.ITEM,1);	


	private Command mouseCommand=new Command("�������(��/��)",Command.ITEM,1);
	private Command mouseCommandM=new Command("�������(��/��)",Command.ITEM,1);

	private Command movieCommand=new Command("��ʼ�������ص�Ӱ",Command.ITEM,1);
	private Command movieCommandM=new Command("��Ӱ�Զ���������",Command.ITEM,1);

	private Command wakeupCommand=new Command("����Զ������",Command.ITEM,1);
	private Command wakeupCommandM=new Command("Զ�̿���",Command.ITEM,1);

        private Command screenCommand=new Command("�鿴��Ļ",Command.ITEM,1);
        private Command qqSoundCommand=new Command("αQQ����",Command.ITEM,1);

	DataInputStream is;
	DataOutputStream os;
	SocketConnection sc;
	Sender sender;
	//Receiver receiver;
	static String ans="";
	private boolean iflock;//��������
	private boolean ifopened;//��ʾ��������
	private boolean ifcdopened;//����������
	private boolean ifmouselocked;//��꿪����
	private boolean udiskopened;//U�̼�ؿ�����
	private boolean overlooked;//ʹ�ü�ؿ�����
	private boolean ReadyScreen;//׼���ý�����Ļͼ������
	private boolean Shaked;//���ڶ��������ˣ�
	//����
	public Client()
		{
		display =Display.getDisplay(this);

		iflock=false;//��ʼ��ʱ��û���ϵ�
		ifopened=true;//��ʼ��ʱ���ǿ�����ʾ����
		ifcdopened=false;//��ʼ��ʱ������ǹ��ŵ�
		ifmouselocked=true;//��ʼ��ʱ����������õ�
		udiskopened=false;//��ʼ��ʱ��U�̼����û����
		overlooked=false;//��ʼ��ʱ��ʹ�ü����û����
		ReadyScreen=false;//��ʼ��ʱ��δ׼���ý���ͼ��
		Shaked=false;//��ʼ��ʱ�򴰿�δ����

		main=new Form("Socket Client");
		cmdline=new TextField("dos����","",50,TextField.ANY);
		moviename=new TextField("��Ӱ����"," ",50,TextField.ANY);
		title=new TextField("��Ϣ�����"," ",50,TextField.ANY);
		context=new TextField("��Ϣ������"," ",50,TextField.ANY);
		url=new TextField("��ַ"," ",50,TextField.ANY);
		mtime=new TextField("��������ʱ��","           ",50,TextField.ANY);
		dns=new TextField("������IP��"," ",50,TextField.ANY);
		mac=new TextField("������ַ"," ",50,TextField.ANY);
		si=new StringItem("����״̬:","δ���ӵ�������");
		successRet=new StringItem("������Ϣ:","��");
		sf=new TextField("������IP:","",80,TextField.ANY);
		sTips=new StringItem("ǧ���۰���:","���Ϸ�����IP�����ڼ������ͨ�����׷����������á�����Ϊ��ʽ��, ����������ϵ qq315102821 (��ʽ�湦�ܲ��ϸ��� �ۼ�30Ԫ�����������۸������) ����ʽ�湦��һ��:1 �ػ� 2 ����  3 ע�� 4 ����(��Ҫ�����������) 5 DOSģ�� 6 ��Ӱ�Զ��������� 7 ��ʾ������ 8 �������� 9 ������� 10 U�̼�� 11 ����ʹ�ü�� 12 ����ҳ 13 ������Ϣ�� 14 αQQ���� 15 ������ ");

		main.append(si);
		main.append(sf);
		main.append(successRet);
		main.append(sTips);
		main.addCommand(startCommand);
		main.addCommand(exitCommand);
		main.addCommand(wakeupCommandM);//Զ�̿���
		main.setCommandListener(this);
		display.setCurrent(main);

		MyWakeup=new Form("Wakeup");
		MyWakeup.addCommand(wakeupCommand);
		MyWakeup.addCommand(backCommand);
		MyWakeup.setCommandListener(this);
		MyWakeup.append(dns);
		MyWakeup.append(mac);
		}


	public void startApp() {}
	public void pauseApp() {}
	public void destroyApp(boolean unconditional) {stop();}

	public void run()
	{
//*********************************����Զ������*************************************
	String adr="";
	String sucINFO;
	adr="socket://"+sf.getString() + ":2012";
	try
	{
		sc=(SocketConnection)Connector.open(adr);
		si.setText("���ӵ�Server");
		is=sc.openDataInputStream();
		os=sc.openDataOutputStream();
		sender=new Sender(os);
	}catch(ConnectionNotFoundException cnfe)
		{
		Alert a=new Alert ("�ͻ���","���������������˳���",null,AlertType.ERROR);
		a.setTimeout(Alert.FOREVER);
		a.setCommandListener(this);
		display.setCurrent(a);
		}catch(IOException ioe)
			{ 
			if(!stop){ioe.printStackTrace();}
			}catch(Exception e){e.printStackTrace();}
//*********************************����Զ������*************************************





//*************************************������Ϣ*************************************
		try{
		while(true)
			{
			StringBuffer sb=new StringBuffer();
			int b=0;
			while(((b=is.read()) != '*') && (b!=-1))
			 {sb.append((char)b);}
			
			
			if(ReadyScreen==true)
			{
			


			}
			else
			{
			sucINFO=Winnowed(sb.toString());
			System.out.println(sucINFO);
			successRet.setText(sucINFO);
			}
			
			}
		}catch(ConnectionNotFoundException cnfe)
			{
			}catch(IOException ioe)
				{ 
				if(!stop){ioe.printStackTrace();}
				}catch(Exception e){e.printStackTrace();}

//*************************************������Ϣ*************************************
	}
//��ť�����
	public void commandAction(Command c,Displayable s)
	{

	if(c==startCommand)
		{
		main.removeCommand(startCommand);//���ӷ�������ť
		//��������**********
		main.addCommand(wakeupCommandM);//Զ�̿���
		main.addCommand(shutCommand);//�ػ�
		main.addCommand(resetCommand);//����
		main.addCommand(standbyCommand);//ע��
		main.addCommand(lockCommand);//���������
		main.addCommand(overlookCommand);//ʹ�ü��
		main.addCommand(udiskCommand);//U�̼��
		main.addCommand(telnetCommand);//TELNETģ��
		main.addCommand(cdCommand);//��������
		main.addCommand(monitorCommand);//��ʾ������
		main.addCommand(mouseCommandM);//�������
		main.addCommand(messageboxCommand);//������Ϣ��
		main.addCommand(webpageCommandM);//����ҳ
		main.addCommand(qqSoundCommand);//α��QQ����
		main.addCommand(shakeCommand);//������

		Mycmd=new Form("CMD");
		Mycmd.addCommand(dosCommand);
		Mycmd.addCommand(backCommand);
		Mycmd.setCommandListener(this);
		Mycmd.append(cmdline);
		
		MyMessageBox=new Form("MessageBox");
		MyMessageBox.addCommand(sendmessageCommand);
		MyMessageBox.addCommand(backCommand);
		MyMessageBox.setCommandListener(this);
		MyMessageBox.append(title);
		MyMessageBox.append(context);
		
		MyWebPage=new Form("WebPage");
		MyWebPage.addCommand(webpageCommand);
		MyWebPage.addCommand(backCommand);
		MyWebPage.setCommandListener(this);
		MyWebPage.append(url);

		MyMouse=new Form("MouseLock");
		MyMouse.addCommand(mouseCommand);
		MyMouse.addCommand(backCommand);
		MyMouse.setCommandListener(this);
		MyMouse.append(mtime);


		MyMovie=new Form("Movie");
		MyMovie.addCommand(movieCommand);
		MyMovie.addCommand(backCommand);
		MyMovie.setCommandListener(this);
		MyMovie.append(moviename);

		Thread t=new Thread(this);
		t.start();
		}

/////////////////////////////////////////��ť����/////////////////////////////////////////movieCommandM

	if(c==shutCommand)
		{
		sender.send("b");
		}


	if(c==resetCommand)
		{
		sender.send("c");
		}


	if(c==standbyCommand)
		{
		sender.send("e");
		}

	if(c==mouseCommandM)
		{
		display.setCurrent(MyMouse);
		}

	if(c==movieCommandM)
		{
		display.setCurrent(MyMovie);
		}

	if(c==movieCommand)
		{
		sender.send("h" + moviename.getString());
		moviename.setText("")
		display.setCurrent(main);
		}

	if(c==wakeupCommandM)
		{
		display.setCurrent(MyWakeup);
		}
	if(c==wakeupCommand)
		{
			String UDPsock;
			DatagramConnection sc2;
			NetworkDatagramSender UDPsender;
			byte[] MGdata=null;
			UDPsock="datagram://" + dns.getString() +":7";  
		 
                        try{
			sc2=(DatagramConnection)Connector.open(UDPsock);
			UDPsender=new NetworkDatagramSender(sc2);
			MGdata=ConstructMagicPacket(mac.getString());

			UDPsender.send(null,MGdata);
			
			}catch(IOException ioe){}catch(Exception e){e.printStackTrace();}
			
			successRet.setText("���ļ������������,���ǧ���۷������ϵͳ������,���������ӵ���������м��");
		}

	if(c==lockCommand)
		{
			if(iflock==true)
			{
				sender.send("du");//����
				iflock=false;
			}
			else
			{
				sender.send("dl");//����
				iflock=true;
			}
	
		}

	if(c==shakeCommand)
		{
			if(Shaked==true)
			{
				sender.send("qf");//ֹͣ��
				Shaked=false;
			}
			else
			{
				sender.send("qt5");//��ʼ��
				Shaked=true;
			}
		}

	if(c==mouseCommand)
		{
			if(ifmouselocked==true)//������þ�������
			{
				sender.send("mt" + mtime.getString());
				ifmouselocked=false;
			}
			else//�����þͿ���
			{
				sender.send("mf");
				ifmouselocked=true;
			}
	
		}


	if(c==cdCommand)
		{
			if(ifcdopened==true)//������ž͹ص�
			{
				sender.send("lf");
				ifcdopened=false;
			}
			else//������žͿ���
			{
				sender.send("lt");
				ifcdopened=true;
			}
	
		}
	
	if(c==overlookCommand)
		{
			if(overlooked==true)//������ž͹ص�
			{
				sender.send("pf");
				overlooked=false;
				successRet.setText("��ʾ:ʹ�ü���Ѿ��ر�!");
			}
			else//������žͿ���
			{
				sender.send("pt");
				overlooked=true;
				successRet.setText("��ʾ:ʹ�ü���Ѿ�����!");
			}
	
		}

	if(c==screenCommand)
		{
		sender.send("f");
		ReadyScreen=true;
		}

	if(c==qqSoundCommand
)
		{
		sender.send("t");
		}

	if(c==webpageCommand)
		{
		sender.send("k" + url.getString());
		url.setString("");
		}

	if(c==sendmessageCommand)
		{
		sender.send("j" + title.getString() + "/" + context.getString());
		}

	if(c==telnetCommand)
		{
		display.setCurrent(Mycmd);
		si=new StringItem("DOS���ؽ��:","");
		Mycmd.append(si);
		}
	if(c==udiskCommand)
		{
			if(udiskopened==true)
			{
				sender.send("nf");
				udiskopened=false;
			}
			else
			{
				sender.send("nt");
				udiskopened=true;
			}
		}
	if(c==dosCommand)
		{
		sender.send("g" + cmdline.getString());
		try{
		while(true)
			{
			StringBuffer sa=new StringBuffer();
			int a=0;
			while(((a=is.read()) != '*') && (a!=-1))
			 {sa.append((char)a);}
			si.setText(sa.toString());
			System.out.println("ִ�н��:"+sa.toString());
			break;
			}
		}catch(ConnectionNotFoundException cnfe)
			{
			}catch(IOException ioe)
				{ 
				if(!stop){ioe.printStackTrace();}
				}catch(Exception e){e.printStackTrace();}
		}


	if(c==backCommand)
		{
		display.setCurrent(main);
		}

	if(c==webpageCommandM)
		{
		display.setCurrent(MyWebPage);
		}

	if(c==messageboxCommand)
		{
		display.setCurrent(MyMessageBox);
		}

	if(c==monitorCommand)
		{
			if(ifopened==true)//��ʾ�����ŵĻ��͹ص���
			{
				sender.send("it");
				ifopened=false;
			}
			else//���û���ŵľͿ�����
			{
				sender.send("if");
				ifopened=true;
			}
		}

	if(c==exitCommand)
		{
		notifyDestroyed();
		destroyApp(true);
		}
/////////////////////////////////////////��ť����/////////////////////////////////////////
	}
	
//stop����
	public void stop()
	{
		try
			{
			stop=true;
			if(sender!=null) {sender.stop();}
			if(is!=null) {is.close();}
			if(os!=null) {os.close();}
			if(sc!=null) {sc.close();}
			}catch(IOException ioe){}

	}
	
//char ss = (char)s.getBytes()[0]
public String Winnowed(String messages)
	{
		char Strget;

		Strget=(messages.substring(0,1)).charAt(0);
		switch(Strget)
		{
 		case 'a':
    			return "����:��¼->�ɹ�!";
 		case 'b':
    			return "����:�ػ�->�ɹ�!";
		case 'c':
			return "����:����->�ɹ�!";
		case 'd':
			return "����:����->�ɹ�!";
		case 'e':
 			return "����:ע��->�ɹ�!";
		case 'f':
			return "����:Զ������->�ɹ�!";//�鿴��Ļ!
		case 'g':
			return "����:DOS����ִ��->�ɹ�!";//dosִ��
		case 'h':
			return "����:��������->�ɹ�!";
		case 'i':
			return "����:��ʾ������->�ɹ�!";
		case 'j':
			return "����:������Ϣ��->�ɹ�!";
		case 'k':
			return "����:����ҳ->�ɹ�!";
		case 'l':
			return "����:��������->�ɹ�!";
		case 'm':
			return "����:�������->�ɹ�!";
		case 'n':
			return "����:U���ļ���ؿ���->�ɹ�!";
		case 'o':
			return "����:Զ�̻���->�����Ѿ�����,���ڿ���!";
		case 'p':
			return "��ʾ:���ļ�������ڱ���ʹ��->������ѡ������,�ػ��Ȳ���";
		case 'z':
			return "��ʾ:���ڻ�ȡ���ļ������Ϣ";
		default:
     			return "false";
		} 
	}



//��дһ���ַ��������� ����VB�е�Mid����
public String Mid(String str,int start,int end)
 {
  try
  {
   if(str.length() > start || str != null)
   {
    if(str.length() > (end-start))
    {
     return str.substring(start,end);
    }
    else
    {
     return str.substring(start,str.length());
    }
   }
   else
   {
    return "Error";
   }
  }
  catch(Exception e)
  {
   return "";
  }
 }

//��дһ���ַ��������� ����VB�е�Mid����


//����һ��Magic Packet
public byte[] ConstructMagicPacket(String Smac)
{	
	int i=0,j=0;
	byte[] DataBuff=new byte[1000];
	byte[] ByteMac=new byte[1000];
	DataBuff=hexToByte("ffffffffffff"+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac);
	return DataBuff;
}
//����һ��Magic Packet


public static final byte[] hexToBytes(String s)
{
	byte[] bytes;
	bytes=new byte[s.length()/2];
	
	for(int i=0;i<bytes.length;i++)
	{
	bytes[i]=(byte) Integer.parseInt(s.substring(2*i,2*i+2),16);
	}
	return bytes;
}


    public static final byte[] hexToByte(String s) {
        byte[] bytes;
        bytes = new byte[s.length() / 2];

        for (int i = 0; i < bytes.length; i++) {
            bytes[i] = (byte) Integer.parseInt(s.substring(2 * i, 2 * i + 2),
                    16);
        }

        return bytes;
    }





public static String getHexString(byte[] b) throws Exception {  

   String result = "";  

   for (int i=0; i < b.length; i++) {  

     result += Integer.toString( ( b[i] & 0xff ) + 0x100, 16).substring( 1 );  

   }  

   return result;  

 }  









}






