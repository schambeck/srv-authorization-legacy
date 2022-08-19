package com.schambeck.authorization;

import com.schambeck.authorization.domain.UserAccount;
import com.schambeck.authorization.repository.UserAccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClient;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClientRepository;
import org.springframework.security.oauth2.server.authorization.config.ClientSettings;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import java.util.UUID;

import static org.springframework.security.oauth2.core.AuthorizationGrantType.*;
import static org.springframework.security.oauth2.core.ClientAuthenticationMethod.CLIENT_SECRET_BASIC;
import static org.springframework.security.oauth2.core.oidc.OidcScopes.OPENID;

@SpringBootApplication
@RequiredArgsConstructor
public class AuthorizationApplication {

	public static void main(String[] args) {
		SpringApplication.run(AuthorizationApplication.class, args);
	}

	private final UserAccountRepository userAccountRepository;

	private final RegisteredClientRepository registeredClientRepository;

	@Transactional
	@PostConstruct
	public void setupTestData() {
		UserAccount account = userAccountRepository.findByUsername("username");
		if (account == null) {
			account = new UserAccount.Builder()
					.withUsername("username")
					.withPassword(new BCryptPasswordEncoder().encode("password"))
					.build();
			userAccountRepository.save(account);
		}

		RegisteredClient registrationClient = RegisteredClient.withId(UUID.randomUUID().toString())
				.clientId("registration-client")
				.clientSecret("secret")
				.clientAuthenticationMethod(CLIENT_SECRET_BASIC)
				.authorizationGrantType(CLIENT_CREDENTIALS)
				.scope("client.create")
				.build();

		registeredClientRepository.save(registrationClient);

		ClientSettings clientSettings = ClientSettings.builder()
				.requireAuthorizationConsent(true)
				.requireProofKey(false)
				.build();

		RegisteredClient registeredClient = RegisteredClient.withId(UUID.randomUUID().toString())
				.clientSettings(clientSettings)
				.clientId("api-dna-client")
				.clientSecret("secret")
				.clientAuthenticationMethod(CLIENT_SECRET_BASIC)
				.authorizationGrantType(AUTHORIZATION_CODE)
				.authorizationGrantType(REFRESH_TOKEN)
				.redirectUri("http://127.0.0.1:8080/login/oauth2/code/api-dna-client-oidc")
				.scope(OPENID)
				.scope("mutant.read")
				.scope("mutant.write")
				.build();

		registeredClientRepository.save(registeredClient);

	}
}
