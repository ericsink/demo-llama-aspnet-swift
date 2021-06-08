# Welcome!

This repo is a demo which shows the use of Llama Swift
with ASP.NET Core.

Llama is my exploratory project to compile "other languages"
for .NET using LLVM.  It is at the "proof of concept"
stage.  See my blog for more info:

https://ericsink.com/tocs/llama.html

## Try it

First, let me apologize to folks on a Mac, which means
"almost all Swift developers".  :-(

In principle, everything here should be cross-platform.
Llama generally works on Windows, Mac, and Linux.
But I haven't tried Llama Swift on Mac (or Linux) yet, so it
probably doesn't work there.  I plan to fix this soon.

Anyway, if you are on Windows and have Swift 5.4 installed,
you should be able to just:

```
cd mul_webapi
dotnet run
```

Oh wait, you need .NET 6 Preview 4 as well.  This sample
uses the new serialization APIs in System.Text.Json.

The necessary nuget packages for
this demo are in the `nupkgs` directory, which is configured
using a nuget config file.

You should see the usual ASP.NET server starting up.
The mul.json file contains an example request, and the mul.sh
contains an example of how to send that request to the server
using curl.


