package org.mock.interview_managerment.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.validation.Validator;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
@EnableWebMvc
@EnableJpaAuditing
public class WebMvcConfig implements WebMvcConfigurer {

    @Bean
    public ViewResolver viewResolver() {
        final InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/view/");
        bean.setSuffix(".jsp");
        return bean;
    }

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.viewResolver(viewResolver());
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        //        registry.addResourceHandler("/css/**").addResourceLocations("/assets/css/");
        //        registry.addResourceHandler("/js/**").addResourceLocations("/assets/js/");
        //        registry.addResourceHandler("/images/**").addResourceLocations("/assets/images/");
        //        registry.addResourceHandler("/client/**").addResourceLocations("/assets/client/");
        registry.addResourceHandler("/assets/**").addResourceLocations("/WEB-INF/view/assets/");
        registry.addResourceHandler("candidate/assets/**").addResourceLocations("/WEB-INF/view/assets/");
        registry.addResourceHandler("/interview_schedule/**").addResourceLocations("/WEB-INF/view/interview_schedule/");

        registry.addResourceHandler("/css/**").addResourceLocations("/assets/css/");
        registry.addResourceHandler("/js/**").addResourceLocations("/assets/js/");
        registry.addResourceHandler("/img/**").addResourceLocations("/assets/img/");
        registry.addResourceHandler("/client/**").addResourceLocations("/assets/client/");
        registry.addResourceHandler("/lib/**").addResourceLocations("/assets/lib/");

    }

    @Bean
    public Validator validator() {
        return new LocalValidatorFactoryBean();
    }

}