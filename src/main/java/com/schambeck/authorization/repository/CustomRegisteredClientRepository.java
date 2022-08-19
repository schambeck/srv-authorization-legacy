package com.schambeck.authorization.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClient;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClientRepository;

@RequiredArgsConstructor
public class CustomRegisteredClientRepository implements RegisteredClientRepository {

    private final RegisteredClientRepository delegate;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void save(RegisteredClient registeredClient) {
        RegisteredClient encodedRegisteredClient = RegisteredClient.from(registeredClient)
                .clientSecret(passwordEncoder.encode(registeredClient.getClientSecret()))
                .build();

        delegate.save(encodedRegisteredClient);
    }

    @Override
    public RegisteredClient findById(String s) {
        return delegate.findById(s);
    }

    @Override
    public RegisteredClient findByClientId(String s) {
        return delegate.findByClientId(s);
    }
}
