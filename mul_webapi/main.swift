
typealias JsonValue = System.Text.Json.Node.JsonValue;
typealias JsonNode = System.Text.Json.Node.JsonNode;
typealias JsonObject = System.Text.Json.Node.JsonObject;

do 
{
    let f_handler_json = try Microsoft.AspNetCore.Http.RequestDelegate(
        {
            context in

            let strm = context.Request.Body;
            let sr = try System.IO.StreamReader(stream: strm);
            return try sr.ReadToEndAsync()
                .ContinueWith
                {
                    t throws -> System.Threading.Tasks.Task in
                    let json_req = t.Result;

                    let doc_options = System.Text.Json.JsonDocumentOptions();

                    let req = try JsonNode.Parse(json_req, nil, doc_options)
                    let nx : Optional<Swift.Int64> = try JsonNode.op_Explicit(req.get_Item("x"));
                    let x = nx!;
                    let ny : Optional<Swift.Int64> = try JsonNode.op_Explicit(req.get_Item("y"));
                    let y = ny!;

                    let prod = x * y;

                    let resp = try JsonObject(options: nil);
                    try resp.Add("result", JsonValue.Create(prod, nil));
                    let json_resp = try resp.ToString();

                    let token = System.Threading.CancellationToken.None;
                    return try context.Response.WriteAsync(json_resp, token);
                }
                .Unwrap()
                ;
        }
        );

    let f_mapRoutes = try System.Action_1<Microsoft.AspNetCore.Routing.IEndpointRouteBuilder>(
        {
            routes in

            try routes.MapGet("/hola")
            {
                context in

                let token = System.Threading.CancellationToken.None;
                return try context.Response.WriteAsync("Hello World", token);
            };
            try routes.MapPost("/mul", f_handler_json);
        }
        );

    try Microsoft.Extensions.Hosting.Host.CreateDefaultBuilder()
        .ConfigureWebHostDefaults
        {
            webHostBuilder in

            try webHostBuilder
                .Configure
                {
                    app in

                    try app
                        .UseRouting()
                        .UseEndpoints(f_mapRoutes)
                        ;
                }
                ;
        }
        .Build()
        .Run()
        ;
}
catch let e as System.Exception 
{
    try! System.Console.WriteLine(e.ToString());
}

