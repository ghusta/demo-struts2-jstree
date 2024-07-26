package org.example.example;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.opensymphony.xwork2.ActionSupport;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

public class JsonTreeAction extends ActionSupport {

    private InputStream inputStream;

    private final ObjectMapper objectMapper;

    public JsonTreeAction() {
        objectMapper = JsonMapper.builder()
                .build();
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    @Override
    public String execute() throws Exception {
        // simulation duree calcul 2000 ms
        Thread.sleep(2000);
        String jsonTree = """
                [
                    { "id" : "ajson1", "parent" : "#", "text" : "Simple root node" },
                    { "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
                    { "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
                    { "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" }
                ]
                """;
        inputStream = new ByteArrayInputStream(jsonTree.getBytes(StandardCharsets.UTF_8));
        return SUCCESS;
    }
}
