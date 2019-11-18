package org.fundationjala.trello.cucumber.hooks;

import io.cucumber.java.After;
import io.restassured.specification.RequestSpecification;
import org.fundationjala.trello.ScenarioContext;
import org.fundationjala.trello.api.RequestManager;

import java.util.List;

public class CommonHook {

    private ScenarioContext context;

    public CommonHook(final ScenarioContext context) {
        this.context = context;
    }

    @After(value = "@cleanData")
    public void afterScenario() {
        RequestSpecification requestSpec = (RequestSpecification) context.get("REQUEST_SPEC");
        List<String> endpoints = context.getEndpoints();
        for (String endpoint : endpoints) {
            RequestManager.delete(requestSpec, endpoint);
        }
    }
}
