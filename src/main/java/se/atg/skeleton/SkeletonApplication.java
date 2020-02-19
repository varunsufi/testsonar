package se.atg.skeleton;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import java.net.ServerSocket;
import java.net.Socket;
import java.io.*;
@SpringBootApplication
@RefreshScope
public class SkeletonApplication {

	public static void main(String[] args) throws IOException {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        DataOutputStream requestLoggerStream = new DataOutputStream(byteArrayOutputStream);
        String ip = "192.168.12.42"; // Noncompliant
          Socket socket = new Socket(ip, 6667);

		new SpringApplicationBuilder(SkeletonApplication.class)
				.profiles("vault")
				.run(args);
	}

}
