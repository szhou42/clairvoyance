import javax.microedition.midlet.*;
import javax.microedition.io.*;
import javax.microedition.lcdui.*;
import java.io.*;
//---网络数据传送要另外开线程
public class NetworkDatagramSender extends Thread 
{
    private DatagramConnection dc;
    private String address;
    private byte[] message;
  //---构造函数，需要传入DatagramConnection
    public NetworkDatagramSender(DatagramConnection dc) 
    {
        this.dc = dc;
        start();
    }
  //---数据同步机制
    public synchronized void send(String addr, byte[] msg) 
    {
        address = addr;
        message = msg;
        notify();
    }
  //---数据同步机制
    public synchronized void run() 
    {
        while (true) 
        {
         // 如果Client都还没有要求联机一直等待
            if (message == null) {
                try {
                    wait();
                } catch (InterruptedException e) {
                }
            }
            try {
            	//---有数据了
                Datagram dg = null;
                //该程序由Server与Client端共享，因此需要知道目前是谁在使用
                //因为Server与Client传送数据的方式不同
                //判断方式：无address数据者为Client端
                if (address == null) 
                { //---Client端程序使用
                    dg = dc.newDatagram(message, message.length);
                } else 
                { //---Server端程序使用
                    dg = dc.newDatagram(message, message.length, address);
                }
                dc.send(dg);
            } catch (Exception ioe) {
                ioe.printStackTrace();
            }
            message = null;
        }
    }
}	 
