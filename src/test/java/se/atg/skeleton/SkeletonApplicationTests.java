package se.atg.skeleton;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit4.SpringRunner;
import se.atg.skeleton.rest.PongController;

import static org.assertj.core.api.Assertions.assertThat;

@RunWith(SpringRunner.class)
@SpringBootTest
@TestPropertySource(properties = {"password=foo"})
public class SkeletonApplicationTests {

	@Autowired
	PongController pongController;

	@Test
	public void contextLoads() {
	    // Sample pong controller to make sure context is loaded correctly...
		assertThat(pongController).isNotNull();
		assertThat(pongController.getSecret()).isEqualTo("foo");
		assertThat(pongController.getWorld()).isEqualTo("\"World\"");
	}
}
