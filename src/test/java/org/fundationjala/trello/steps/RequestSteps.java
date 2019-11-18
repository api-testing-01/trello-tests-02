package org.fundationjala.trello.steps;

import io.cucumber.java.en.Given;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.fundationjala.trello.RequestSpecFactory;
import org.fundationjala.trello.ScenarioContext;
public class RequestSteps {

    private RequestSpecification requestSpecification;
    private Response response;
    private ScenarioContext context;

    public RequestSteps(final ScenarioContext context) {
        this.context = context;
    }

    @Given("I use the {string} service and the {string} account")
    public void iUseTheService(final String serviceName, final String accountName) {
        requestSpecification = RequestSpecFactory.getRequestSpec(serviceName, accountName);
        context.set("REQUEST_SPEC", requestSpecification);
    }
}
