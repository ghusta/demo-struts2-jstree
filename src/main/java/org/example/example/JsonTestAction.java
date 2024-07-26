package org.example.example;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.opensymphony.xwork2.ActionSupport;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.Map;

public class JsonTestAction extends ActionSupport {

    private InputStream inputStream;

    private final ObjectMapper objectMapper;

    public JsonTestAction() {
        objectMapper = JsonMapper.builder()
                .build();
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    @Override
    public String execute() throws Exception {
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("message", "Hello World! This is a text string response from a Struts 2 Action.");
        byte[] valueAsBytes = objectMapper.writeValueAsBytes(map);
        inputStream = new ByteArrayInputStream(valueAsBytes);
        return SUCCESS;
    }
}
