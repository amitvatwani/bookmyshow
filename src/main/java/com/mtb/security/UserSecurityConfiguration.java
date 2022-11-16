package com.mtb.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class UserSecurityConfiguration extends WebSecurityConfigurerAdapter {
 
    @Autowired
    private UserDetailsService userDetailsService;
//      @Override public void configure(WebSecurity web) throws Exception {
//      web.ignoring().antMatchers("/resources/**"); }
     
 
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable().authorizeRequests()
                .antMatchers("/ticket/**").hasAnyRole("USER", "ADMIN", "THEATREOWNER")
                .antMatchers("/getSeatLayout").hasAnyRole("USER", "ADMIN", "THEATREOWNER")
                .antMatchers("/viewProfile").hasAnyRole("USER", "ADMIN", "THEATREOWNER")
                .antMatchers("/viewTicketsByUser").hasAnyRole("USER", "ADMIN", "THEATREOWNER")
                .antMatchers("/admin/**").hasAnyRole("ADMIN")
                .antMatchers("/theatre/theatreForm").hasAnyRole("USER")
                .antMatchers("/theatre/addNewTheatre").hasAnyRole("USER")
                .antMatchers("/theatre/**").hasAnyRole("THEATREOWNER")
                .antMatchers("/**").permitAll()
                .anyRequest().authenticated()
                .and().formLogin().loginPage("/userLogin").permitAll()
                .defaultSuccessUrl("/loginValidation")
                .and().logout().invalidateHttpSession(true).clearAuthentication(true)
                .logoutRequestMatcher(new AntPathRequestMatcher("/logoutUser")).logoutSuccessUrl("/").permitAll();
 
    }
 
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception { // TODO Auto-generated method stub
        
        
        auth.authenticationProvider(authProvider());
    }
 
    /*
     * @Autowired public void configureGlobal(AuthenticationManagerBuilder
     * authenticationMgr) throws Exception {
     * authenticationMgr.inMemoryAuthentication().withUser("employee").password(
     * "employee").authorities("ROLE_USER")
     * .and().withUser("jitendra").password("admin").authorities("ROLE_USER",
     * "ROLE_ADMIN"); }
     */
 
    @Bean
    AuthenticationProvider authProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(userDetailsService);
        provider.setPasswordEncoder(passwordEncoder()); //
        // provider.setPasswordEncoder(new BCryptPasswordEncoder());
        return provider;
    }
 
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
 
}
