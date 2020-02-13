package se.atg.skeleton;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Configuration;
import org.springframework.vault.annotation.VaultPropertySource;

/**
 * @author Per Huss (per@pock37.se)
 */
@Configuration
@ConditionalOnProperty(name = "spring.cloud.vault.enabled", havingValue = "true")
@VaultPropertySource("secret/common-services-skeleton")
public class VaultConfig
{
}

