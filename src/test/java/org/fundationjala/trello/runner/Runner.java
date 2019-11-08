package org.fundationjala.tello.runner;

import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;

@CucumberOptions(
        glue = {"org.fundationjala.tello"},
        features = "src/test/resources/feature",
        plugin = "pretty"
)
public class Runner extends AbstractTestNGCucumberTests {
}
