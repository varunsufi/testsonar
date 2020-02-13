package se.atg.skeleton.rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.beans.factory.annotation.Value;

/**
 * @author thomas.andolf
 */
@RestController
public class PongController {

    @Autowired
    private Environment env;

    @GetMapping("/ping")
    public String getPong() {
        return "Pong";
    }

    @GetMapping("/hello")
    public String getWorld() {
        return env.getProperty("app.greeting");
    }

    @Value("${password}")
    String password;

    @GetMapping("/secret")
    public String getSecret() {
        return password;
    }

    @GetMapping("/common-services")
    public String getBest() {
        return "Are the best!";
    }

    @GetMapping("/version")
    public String getVersion() {
        return getClass().getPackage().getImplementationVersion();
    }
}
