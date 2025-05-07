//Console inspired by https://github.com/lohithgn/reviews-redis-rag-sk-dotnet

using Microsoft.Extensions.Configuration;
using Spectre.Console;
using Console = Spectre.Console.AnsiConsole;
using Dapr.Agents.Demo.Models;
using Dapr.Agents.Demo.Services;

namespace Dapr.Agents.Demo.ConsoleApp;

internal class Program
{

    async static Task Main()
    {
        Console.Write(new FigletText("Dapr Agents").Color(Color.Red));
        
        var config = GetConfiguration();
        var agentConfig = config.GetSection("DaprAgent").Get<DaprAgentConfiguration>();

        const string request = "1.\tCall AI Assistant to help choose a hill to build the future Rome on";
        const string status = "2.\tCheck how the conversation is going";
        const string result = "3.\tGet the final result of the conversation";
        const string exit = "4.\tExit this Application";

        DaprAgentService agent = new (
            agentConfig?.Endpoint ?? string.Empty,
            agentConfig?.Question ?? string.Empty);

        while (true)
        {

            var selectedOption = Console.Prompt(
                  new SelectionPrompt<string>()
                      .Title("Select an option to continue")
                      .PageSize(4)
                      .MoreChoicesText("[grey](Move up and down to reveal more options)[/]")
                      .AddChoices([request ,status, result, exit]));

            switch (selectedOption)
            {
                case request:
                    await SendRequest(agent);
                    break;
                case status:
                    await CheckStatus(agent);
                    break;
                case result:
                    await GetResults(agent);
                    break;                
                case exit:
                    return;
            }
        }
    }

    private static IConfigurationRoot GetConfiguration()
    {
        var configuration = new ConfigurationBuilder()
                                            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                                            .AddEnvironmentVariables(prefix: "BJD_");

        var config = configuration.Build();
        return config;
    }

    
    private static async Task SendRequest(IDaprAgentService serviceProvider)
    {
        Console.WriteLine();
        await Console.Status()
               .StartAsync("Processing...", async ctx =>
               {
                   ctx.Spinner(Spinner.Known.Star);
                   ctx.SpinnerStyle(Style.Parse("green"));
                   var progress = new Progress<string>(status => ctx.Status(status));
                   serviceProvider.SendRequest();
                   Console.WriteLine();
               });
    }

    private static async Task CheckStatus(IDaprAgentService serviceProvider)
    {
        Console.WriteLine();
        await Console.Status()
               .StartAsync("Processing...", async ctx =>
               {
                   ctx.Spinner(Spinner.Known.Star);
                   ctx.SpinnerStyle(Style.Parse("green"));
                   var progress = new Progress<string>(status => ctx.Status(status));
                   var response = await serviceProvider.CheckStatus();
                   Console.WriteLine(response.ToString());
               });
    }

    private static async Task GetResults(IDaprAgentService serviceProvider)
    {
        Console.WriteLine();
        await Console.Status()
               .StartAsync("Processing...", async ctx =>
               {
                   ctx.Spinner(Spinner.Known.Star);
                   ctx.SpinnerStyle(Style.Parse("green"));
                   var progress = new Progress<string>(status => ctx.Status(status));
                   var response = await serviceProvider.GetResults();
                   Console.WriteLine(response.ToString());
               });
    }

}