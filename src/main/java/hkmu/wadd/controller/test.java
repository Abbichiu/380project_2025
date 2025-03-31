package hkmu.wadd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class test{

    @GetMapping("/test")
    public String test() {
        return "index"; // Resolves to /WEB-INF/jsp/index.jsp
    }
}