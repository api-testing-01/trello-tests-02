package org.fundationjala.trello.runner;

import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;

@CucumberOptions(
        glue = {"org.fundationjala.trello"},
        features = "src/test/resources/feature",
        plugin = "pretty"
)
public class Runner extends AbstractTestNGCucumberTests {
}
