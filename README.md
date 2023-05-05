# plusplus

A web framework / generator for both the front HTML/JS and C backend API server.

This is BOTH a tool and a library. They are designed to work together.

## Purpose

The last thing the world needs is Yet Another Web Framework. And, yet, this one
(as of June 2023) is somewhat different. It uses the cross compilation function
of nim to create:

* a static website built from HTML/JS/CSS files acting as the web site front end
* one (or more) C-compiled API servers

and it ensures, at compile-time, that:

* all calls from JS to the APIs are correct and matching, including exact JSON models
* any calls between APIs (for DDD or microservice style architectures) are also matching and correct

And it does so from ONE source code base.

Or, to state it from a programmers point of view, when you write a function like:

```nim
xyzSite.GET(foobarRoute, []):
  proc foobar(id: int): BlingItem =
    # stuff goes here
```

When this exact same code is seen by:

* the `web frontend`: it compiles this proc to javascript AJAX code to be invoked by the HTML
* the `xyz API`: it compiles this proc as the proper server response for the route
* a different `other API`: it compiles this proc as an HTTP dependency to be called.

Same code. Three behaviors. No need to worry about them calling each other correctly; the URLs will match, the JSON objects will match, the parameters will match.

This web framework is designed to deployed in cloud environments such as AWS or with cloud-oriented tools like Kubernetes.

## Install

Install via nimble:

```bash
nimble install plusplus
```
