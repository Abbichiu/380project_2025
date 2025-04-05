package hkmu.wadd.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.HiddenHttpMethodFilter;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig  implements WebMvcConfigurer {
    @Bean
    public HiddenHttpMethodFilter hiddenHttpMethodFilter() {

        System.out.println("HiddenHttpMethodFilter initialized");
        return new HiddenHttpMethodFilter();
    }
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Add resource handlers for static content (if needed)
        registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/");
    }
}