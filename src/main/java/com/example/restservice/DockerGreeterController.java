package com.example.restservice;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DockerGreeterController {

    @RequestMapping("/")
    public String home() {
        return "Hello Docker World";
    }
}
