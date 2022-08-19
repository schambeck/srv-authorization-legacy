package com.schambeck.authorization.service;

import com.schambeck.authorization.domain.UserAccount;
import com.schambeck.authorization.domain.UserDetailsImpl;
import com.schambeck.authorization.repository.UserAccountRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Objects;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    private final UserAccountRepository userAccountRepository;

    public UserDetailsServiceImpl(UserAccountRepository userAccountRepository) {
        this.userAccountRepository = userAccountRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserAccount userAccount = userAccountRepository.findByUsername(username);
        if (Objects.isNull(userAccount)) {
            throw new UsernameNotFoundException("User not found.");
        }

        return new UserDetailsImpl.Builder()
                .withUsername(userAccount.getUsername())
                .withPassword(userAccount.getPassword())
                .build();
    }

}
