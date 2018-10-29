# LISA18: Test Driven Infrastructure

## Introduction

Test Driven Infrastructure (_Compliance as Code_) is the process to design the infrastructure through tests.  

The idea is that you would first experiment, model, and build out your infrastructure, and then build tests to certify that infrastructure works as designed. With this baseline, you can then create an infrastructure from nothing.

## Topics

In this material, we will build web-database services in two change configuration systems: Chef and Ansible, and then use InSpec to verify that these were created as desired.  We will turn three categories of tests:

* Contract Tests (Promise) - can the service respond as expected
* Conformance Test - a platform should meet the needs to host the application, e.g. apache modules required, mysql databases created, etc.
* Security Tests - follow best practices to secure the application

## Implementation

Tools Used:
 * [InSpec](https://www.inspec.io/) - infrastructure compliance test tool
 * [Test Kitchen](https://kitchen.ci/) - test harness to converge and verify results
 * [Chef](https://www.chef.io/chef/) - change configuration management that uses agents apply desired state
 * [Ansible](https://www.ansible.com/) - remote execution tool that does change configuration, infrastructure as code, and device configuration.
