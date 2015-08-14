import javax.microedition.midlet.*;
import javax.microedition.io.*;
import javax.microedition.lcdui.*;
import java.io.*;

public class Client extends MIDlet implements Runnable,
CommandListener{
	//对象定义
	private Display display;
	private Form main,Mycmd,MyMessageBox,MyWebPage,MyMouse,MyMovie,MyWakeup;

	private StringItem si,cmdRet,successRet,sTips;
	private TextField user,pass,sf,cmdline,title,context,url,mtime,moviename,dns,mac;//唤醒端口就默认为2012了!
	private boolean stop;
	private Command startCommand=new Command("连接Server",Command.ITEM,1);
	private Command exitCommand=new Command("退出程序",Command.EXIT,1);
	private Command backCommand=new Command("回到主窗",Command.ITEM,1);

	private Command shutCommand=new Command("关机",Command.ITEM,1);
	private Command resetCommand=new Command("重启",Command.ITEM,1);
	private Command standbyCommand=new Command("注销",Command.ITEM,1);

	private Command overlookCommand=new Command("使用监控(开/关)",Command.ITEM,1);
	private Command monitorCommand=new Command("显示器(开/关)",Command.ITEM,1);
	private Command cdCommand=new Command("光驱(开/关)",Command.ITEM,1);
	private Command udiskCommand=new Command("U盘文件监控(开/关)",Command.ITEM,1);
	private Command lockCommand=new Command("锁定计算机(开/关)",Command.ITEM,1);
        private Command shakeCommand=new Command("窗口震动骚扰(开/关)",Command.ITEM,1);

	private Command telnetCommand=new Command("dos命令模拟",Command.ITEM,1);
	private Command dosCommand=new Command("dos发送执行",Command.ITEM,1);

	private Command messageboxCommand=new Command("弹出信息框",Command.ITEM,1);
	private Command sendmessageCommand=new Command("发送信息",Command.ITEM,1);
	
	private Command webpageCommand=new Command("打开网页",Command.ITEM,1);	
	private Command webpageCommandM=new Command("打开网页",Command.ITEM,1);	


	private Command mouseCommand=new Command("锁定鼠标(开/关)",Command.ITEM,1);
	private Command mouseCommandM=new Command("锁定鼠标(开/关)",Command.ITEM,1);

	private Command movieCommand=new Command("开始搜索下载电影",Command.ITEM,1);
	private Command movieCommandM=new Command("电影自动搜索下载",Command.ITEM,1);

	private Command wakeupCommand=new Command("开启远程主机",Command.ITEM,1);
	private Command wakeupCommandM=new Command("远程开机",Command.ITEM,1);

        private Command screenCommand=new Command("查看屏幕",Command.ITEM,1);
        private Command qqSoundCommand=new Command("伪QQ铃音",Command.ITEM,1);

	DataInputStream is;
	DataOutputStream os;
	SocketConnection sc;
	Sender sender;
	//Receiver receiver;
	static String ans="";
	private boolean iflock;//上锁了吗
	private boolean ifopened;//显示器开着吗
	private boolean ifcdopened;//光驱开着吗
	private boolean ifmouselocked;//鼠标开着吗
	private boolean udiskopened;//U盘监控开着吗
	private boolean overlooked;//使用监控开着吗
	private boolean ReadyScreen;//准备好接收屏幕图像了吗
	private boolean Shaked;//窗口抖动开启了？
	//主类
	public Client()
		{
		display =Display.getDisplay(this);

		iflock=false;//开始的时候没锁上的
		ifopened=true;//开始的时候是开着显示器的
		ifcdopened=false;//开始的时候光驱是关着的
		ifmouselocked=true;//开始的时候鼠标是能用的
		udiskopened=false;//开始的时候U盘监控是没开的
		overlooked=false;//开始的时候使用监控是没开的
		ReadyScreen=false;//开始的时候未准备好接收图像
		Shaked=false;//开始的时候窗口未抖动

		main=new Form("Socket Client");
		cmdline=new TextField("dos命令","",50,TextField.ANY);
		moviename=new TextField("电影名称"," ",50,TextField.ANY);
		title=new TextField("信息框标题"," ",50,TextField.ANY);
		context=new TextField("信息框内容"," ",50,TextField.ANY);
		url=new TextField("网址"," ",50,TextField.ANY);
		mtime=new TextField("锁定持续时间","           ",50,TextField.ANY);
		dns=new TextField("域名或IP："," ",50,TextField.ANY);
		mac=new TextField("网卡地址"," ",50,TextField.ANY);
		si=new StringItem("网络状态:","未连接到服务器");
		successRet=new StringItem("返回信息:","无");
		sf=new TextField("服务器IP:","",80,TextField.ANY);
		sTips=new StringItem("千里眼帮助:","以上服务器IP可以在计算机中通过配套服务器程序查得。本版为正式版, 技术问题联系 qq315102821 (正式版功能不断更新 售价30元，功能增多后价格会上升) 现正式版功能一览:1 关机 2 重启  3 注销 4 开机(不要怀疑这个功能) 5 DOS模拟 6 电影自动搜索下载 7 显示器操作 8 光驱操作 9 鼠标锁定 10 U盘监控 11 电脑使用监控 12 打开网页 13 弹出信息框 14 伪QQ铃音 15 窗口震动 ");

		main.append(si);
		main.append(sf);
		main.append(successRet);
		main.append(sTips);
		main.addCommand(startCommand);
		main.addCommand(exitCommand);
		main.addCommand(wakeupCommandM);//远程开机
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
//*********************************连接远程主机*************************************
	String adr="";
	String sucINFO;
	adr="socket://"+sf.getString() + ":2012";
	try
	{
		sc=(SocketConnection)Connector.open(adr);
		si.setText("连接到Server");
		is=sc.openDataInputStream();
		os=sc.openDataOutputStream();
		sender=new Sender(os);
	}catch(ConnectionNotFoundException cnfe)
		{
		Alert a=new Alert ("客户端","请先启动服务器端程序",null,AlertType.ERROR);
		a.setTimeout(Alert.FOREVER);
		a.setCommandListener(this);
		display.setCurrent(a);
		}catch(IOException ioe)
			{ 
			if(!stop){ioe.printStackTrace();}
			}catch(Exception e){e.printStackTrace();}
//*********************************连接远程主机*************************************





//*************************************接收信息*************************************
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

//*************************************接收信息*************************************
	}
//按钮命令处理
	public void commandAction(Command c,Displayable s)
	{

	if(c==startCommand)
		{
		main.removeCommand(startCommand);//连接服务器按钮
		//基本操作**********
		main.addCommand(wakeupCommandM);//远程开机
		main.addCommand(shutCommand);//关机
		main.addCommand(resetCommand);//重启
		main.addCommand(standbyCommand);//注销
		main.addCommand(lockCommand);//锁定计算机
		main.addCommand(overlookCommand);//使用监控
		main.addCommand(udiskCommand);//U盘监控
		main.addCommand(telnetCommand);//TELNET模拟
		main.addCommand(cdCommand);//光驱控制
		main.addCommand(monitorCommand);//显示器控制
		main.addCommand(mouseCommandM);//鼠标锁定
		main.addCommand(messageboxCommand);//发送信息框
		main.addCommand(webpageCommandM);//打开网页
		main.addCommand(qqSoundCommand);//伪造QQ铃音
		main.addCommand(shakeCommand);//窗口震动

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

/////////////////////////////////////////按钮部分/////////////////////////////////////////movieCommandM

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
			
			successRet.setText("您的计算机正在启动,如果千里眼服务端随系统自启动,您可以连接到计算机进行监控");
		}

	if(c==lockCommand)
		{
			if(iflock==true)
			{
				sender.send("du");//解锁
				iflock=false;
			}
			else
			{
				sender.send("dl");//上锁
				iflock=true;
			}
	
		}

	if(c==shakeCommand)
		{
			if(Shaked==true)
			{
				sender.send("qf");//停止震动
				Shaked=false;
			}
			else
			{
				sender.send("qt5");//开始震动
				Shaked=true;
			}
		}

	if(c==mouseCommand)
		{
			if(ifmouselocked==true)//鼠标能用就锁定它
			{
				sender.send("mt" + mtime.getString());
				ifmouselocked=false;
			}
			else//不能用就开锁
			{
				sender.send("mf");
				ifmouselocked=true;
			}
	
		}


	if(c==cdCommand)
		{
			if(ifcdopened==true)//如果开着就关掉
			{
				sender.send("lf");
				ifcdopened=false;
			}
			else//如果关着就开启
			{
				sender.send("lt");
				ifcdopened=true;
			}
	
		}
	
	if(c==overlookCommand)
		{
			if(overlooked==true)//如果开着就关掉
			{
				sender.send("pf");
				overlooked=false;
				successRet.setText("提示:使用监控已经关闭!");
			}
			else//如果关着就开启
			{
				sender.send("pt");
				overlooked=true;
				successRet.setText("提示:使用监控已经开启!");
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
		si=new StringItem("DOS返回结果:","");
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
			System.out.println("执行结果:"+sa.toString());
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
			if(ifopened==true)//显示器开着的话就关掉它
			{
				sender.send("it");
				ifopened=false;
			}
			else//如果没关着的就开了它
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
/////////////////////////////////////////按钮部分/////////////////////////////////////////
	}
	
//stop函数
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
    			return "操作:登录->成功!";
 		case 'b':
    			return "操作:关机->成功!";
		case 'c':
			return "操作:重启->成功!";
		case 'd':
			return "操作:锁定->成功!";
		case 'e':
 			return "操作:注销->成功!";
		case 'f':
			return "操作:远程桌面->成功!";//查看屏幕!
		case 'g':
			return "操作:DOS命令执行->成功!";//dos执行
		case 'h':
			return "操作:搜索下载->成功!";
		case 'i':
			return "操作:显示器操作->成功!";
		case 'j':
			return "操作:弹出信息框->成功!";
		case 'k':
			return "操作:打开网页->成功!";
		case 'l':
			return "操作:光驱控制->成功!";
		case 'm':
			return "操作:鼠标锁定->成功!";
		case 'n':
			return "操作:U盘文件监控开启->成功!";
		case 'o':
			return "操作:远程唤醒->命令已经发送,正在开机!";
		case 'p':
			return "提示:您的计算机正在被人使用->请自行选择锁定,关机等操作";
		case 'z':
			return "提示:正在获取您的计算机信息";
		default:
     			return "false";
		} 
	}



//自写一个字符串处理函数 类似VB中的Mid函数
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

//自写一个字符串处理函数 类似VB中的Mid函数


//构造一个Magic Packet
public byte[] ConstructMagicPacket(String Smac)
{	
	int i=0,j=0;
	byte[] DataBuff=new byte[1000];
	byte[] ByteMac=new byte[1000];
	DataBuff=hexToByte("ffffffffffff"+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac+Smac);
	return DataBuff;
}
//构造一个Magic Packet


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






