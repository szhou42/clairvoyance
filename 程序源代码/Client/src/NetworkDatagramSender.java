import javax.microedition.midlet.*;
import javax.microedition.io.*;
import javax.microedition.lcdui.*;
import java.io.*;
//---�������ݴ���Ҫ���⿪�߳�
public class NetworkDatagramSender extends Thread 
{
    private DatagramConnection dc;
    private String address;
    private byte[] message;
  //---���캯������Ҫ����DatagramConnection
    public NetworkDatagramSender(DatagramConnection dc) 
    {
        this.dc = dc;
        start();
    }
  //---����ͬ������
    public synchronized void send(String addr, byte[] msg) 
    {
        address = addr;
        message = msg;
        notify();
    }
  //---����ͬ������
    public synchronized void run() 
    {
        while (true) 
        {
         // ���Client����û��Ҫ������һֱ�ȴ�
            if (message == null) {
                try {
                    wait();
                } catch (InterruptedException e) {
                }
            }
            try {
            	//---��������
                Datagram dg = null;
                //�ó�����Server��Client�˹��������Ҫ֪��Ŀǰ��˭��ʹ��
                //��ΪServer��Client�������ݵķ�ʽ��ͬ
                //�жϷ�ʽ����address������ΪClient��
                if (address == null) 
                { //---Client�˳���ʹ��
                    dg = dc.newDatagram(message, message.length);
                } else 
                { //---Server�˳���ʹ��
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
