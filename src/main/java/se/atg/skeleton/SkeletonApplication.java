package se.atg.skeleton;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.cloud.context.config.annotation.RefreshScope;

import java.io.*;
@SpringBootApplication
@RefreshScope
public class SkeletonApplication {

	public static void main(String[] args) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        DataOutputStream requestLoggerStream = new DataOutputStream(byteArrayOutputStream);

		new SpringApplicationBuilder(SkeletonApplication.class)
				.profiles("vault")
				.run(args);
	}

}
