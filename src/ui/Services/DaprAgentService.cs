
using System.Reflection.Metadata;
using System.Text.Json;

namespace Dapr.Agents.Demo.Services;


internal class DaprAgentService : IDaprAgentService
{
    internal const string _startWorkFlow = "/start-workflow";

    public string _endpoint { get; }
    public string _question { get; }
    
    internal HttpClient _httpClient;

    public DaprAgentService(string endpoint, string question)
    {
        _endpoint = endpoint;
        _question = question;
        _httpClient = new ();
        _httpClient.BaseAddress = new Uri(_endpoint);
    }
    public async Task<string> GetResults()
    {
        await Task.Delay(1000);
        return "Result";
    }
    public async void SendRequest() 
    {   

        var payload = new
        {
            task = _question
        };

        var stringContent = new StringContent(JsonSerializer.Serialize(payload), System.Text.Encoding.UTF8, "application/json");
        var url = $"{_endpoint}{_startWorkFlow}";
        
        HttpResponseMessage response = await _httpClient.PostAsync(url, stringContent);
        string responseString = await response.Content.ReadAsStringAsync();

    }
    public async Task<string> CheckStatus()
    {
        await Task.Delay(1000);
        return "Status";
    }

}