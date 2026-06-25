package com.cinema.config;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import jakarta.servlet.MultipartConfigElement;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRegistration;

public class AppInitializer implements WebApplicationInitializer {

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        AnnotationConfigWebApplicationContext context = new AnnotationConfigWebApplicationContext();

        context.register(Config.class);

        DispatcherServlet dispatcher = new DispatcherServlet((WebApplicationContext) context);

        ServletRegistration.Dynamic registration = servletContext.addServlet("dispatcher", dispatcher);
        registration.setLoadOnStartup(1);
        registration.addMapping("/");
        registration.setAsyncSupported(true);

        registration.setMultipartConfig(
            new MultipartConfigElement(
                "/tmp",
                10 * 1024 * 1024,
                20 * 1024 * 1024,
                0
            )
        );
    }
    
}
