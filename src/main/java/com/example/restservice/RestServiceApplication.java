package com.example.restservice;

import com.example.restservice.pojo.Book;
import com.example.restservice.repository.BookRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class RestServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(RestServiceApplication.class, args);
    }

    @Bean
    public CommandLineRunner demo(BookRepository repository) {
        return (args) -> {
            // save a few customers
            repository.save(new Book("Lord of the Rings", "J.R.R. Tolkien"));
            repository.save(new Book("Sword of Truth", "Terry Goodkind"));
            repository.save(new Book("Harry Potter", "J.K. Rowling"));
        };
    }

}
