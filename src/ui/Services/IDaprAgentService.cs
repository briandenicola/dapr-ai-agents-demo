namespace Dapr.Agents.Demo.Services;

internal interface IDaprAgentService
{
    Task<string> GetResults();
    Task<string> CheckStatus();
    void SendRequest();
}