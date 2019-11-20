package org.fundationjala.trello.api;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.util.HashMap;
import java.util.Map;

public final class RequestManager {

    private RequestManager() {
    }

    public static Response doRequest(final String httpMethod, final RequestSpecification requestSpecification,
                                     final String endpoint, final String jsonBody) {
        Map<String, IRequest> requestMap = new HashMap<>();
        requestMap.put("POST", () -> RequestManager.post(requestSpecification, endpoint, jsonBody));
        requestMap.put("PUT", () -> RequestManager.put(requestSpecification, endpoint, jsonBody));
        requestMap.put("PATCH", () -> RequestManager.patch(requestSpecification, endpoint, jsonBody));

        return requestMap.get(httpMethod).executeRequest();
    }

    public static Response doRequest(final String httpMethod, final RequestSpecification requestSpecification,
                                     final String endpoint, final Map<String, String> body) {

        Map<String, IRequest> requestMap = new HashMap<>();
        requestMap.put("POST", () -> RequestManager.post(requestSpecification, endpoint, body));
        requestMap.put("PUT", () -> RequestManager.put(requestSpecification, endpoint, body));
        requestMap.put("PATCH", () -> RequestManager.patch(requestSpecification, endpoint, body));

        return requestMap.get(httpMethod).executeRequest();
    }

    public static Response doRequest(final String httpMethod, final RequestSpecification requestSpecification,
                                     final String endpoint) {

        Map<String, IRequest> requestMap = new HashMap<>();
        requestMap.put("GET", () -> RequestManager.get(requestSpecification, endpoint));
        requestMap.put("DELETE", () -> RequestManager.delete(requestSpecification, endpoint));

        return requestMap.get(httpMethod).executeRequest();
    }

    public static Response post(final RequestSpecification requestSpec, final String endpoint,
                                final String body) {
        final Response response = RestAssured.given(requestSpec)
                .contentType(ContentType.JSON)
                .when()
                .body(body)
                .post(endpoint);
        return getResponseWithLogger(response);
    }

    public static Response post(final RequestSpecification requestSpec, final String endpoint,
                                final Map<String, String> body) {
        final Response response = RestAssured.given(requestSpec)
                .params(body)
                .when()
                .post(endpoint);
        return getResponseWithLogger(response);
    }

    public static Response put(final RequestSpecification requestSpec, final String endpoint,
                                final String body) {
        final Response response = RestAssured.given(requestSpec)
                .contentType(ContentType.JSON)
                .when()
                .body(body)
                .put(endpoint);
        return getResponseWithLogger(response);
    }


    public static Response patch(final RequestSpecification requestSpec, final String endpoint,
                               final String body) {
        final Response response = RestAssured.given(requestSpec)
                .contentType(ContentType.JSON)
                .when()
                .body(body)
                .patch(endpoint);
        return getResponseWithLogger(response);
    }

    public static Response patch(final RequestSpecification requestSpec, final String endpoint,
                                 final Map<String, String> body) {
        final Response response = RestAssured.given(requestSpec)
                .params(body)
                .when()
                .patch(endpoint);
        return getResponseWithLogger(response);
    }

    public static Response put(final RequestSpecification requestSpec, final String endpoint,
                               final Map<String, String> body) {
        final Response response = RestAssured.given(requestSpec)
                .params(body)
                .when()
                .put(endpoint);
        return getResponseWithLogger(response);
    }

    public static Response delete(final RequestSpecification requestSpec, final String endpoint) {
        final Response response = RestAssured.given(requestSpec)
                .when()
                .delete(endpoint);
        return getResponseWithLogger(response);
    }

    public static Response get(final RequestSpecification requestSpec, final String endpoint) {
        final Response response = RestAssured.given(requestSpec)
                .when()
                .get(endpoint);
        return getResponseWithLogger(response);
    }

    private static Response getResponseWithLogger(final Response response) {
        response.then()
                .log().status()
                .log().body();
        return response;
    }
}
