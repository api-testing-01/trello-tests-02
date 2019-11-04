package org.fundationjala.tello.runner;

import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;

@CucumberOptions(
        glue = {"org.fundacionjala.tello"},
        features = "src/test/resources/features",
        plugin = "pretty"
)
public class Runner extends AbstractTestNGCucumberTests {
}
