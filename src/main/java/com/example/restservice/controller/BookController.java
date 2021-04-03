package com.example.restservice.controller;

import com.example.restservice.pojo.Book;
import com.example.restservice.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping(path="/books")
public class BookController {

    @Autowired
    private BookRepository bookRepository;

    @PostMapping(path="/add") // Map ONLY POST Requests
    public @ResponseBody String addNewUser (
            @RequestParam String title,
            @RequestParam String author
    ) {
        bookRepository.save(new Book(title, author));
        return "Saved";
    }

    @GetMapping(path="/all")
    public @ResponseBody Iterable<Book> getAllUsers() {
        return bookRepository.findAll();
    }
}
