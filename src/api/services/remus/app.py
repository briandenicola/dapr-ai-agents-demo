from dapr_agents import DurableAgent, OpenAIChatClient #Agent, AgentActor, OpenAIChatClient
from dotenv import load_dotenv
import asyncio
import logging
import os

async def main():
    try:       
        llm = OpenAIChatClient(
            api_key=os.getenv("AZURE_OPENAI_API_KEY"),
            azure_endpoint=os.getenv("AZURE_OPENAI_ENDPOINT"),
            azure_deployment=os.getenv("AZURE_OPENAI_DEPLOYMENT"), 
            api_version=os.getenv("AZURE_OPENAI_API_VERSION"),
        )
        
        remus_agent = DurableAgent(
            name="Remus",role="Son of Mars",            
            goal="To found a new city on one of the seven hills of Rome, using augury to determine the best location.",
            instructions=[
                "Your name is Remus and you are a twin with your brother Romulus. "
                "You are both children of Rhea Silvia, who conceived you with the Mars, God of War."
                "Both you and your brother are natural leaders and have overcome a lifetime of trials and tribulations."
                "You are the older brother and more rational of the two."
                "You speak with certain Shakespearean Latin."
                "You are arguing over which of the seven hills your new city will be founded on and have agreed to use augury to settle the dispute.",
            ],
            llm=llm,
            message_bus_name="messagepubsub",
            state_store_name="workflowstatestore",
            state_key="workflow_state",
            agents_registry_store_name="agentstatestore",
            agents_registry_key="agents_registry",
            broadcast_topic_name="beacon_channel",
            service_port=8003,
        )
        await remus_agent.start()
        
        # Expose Agent as an Actor over a Service
        # human_actor = AgentActor(
        #     agent=remus_agent,
        #     message_bus_name="messagepubsub",
        #     agents_registry_store_name="agentstatestore",
        #     agents_registry_key="agents_registry",
        #     service_port=8002,
        # )

        # await human_actor.start()

    except Exception as e:
        print(f"Error starting actor: {e}")


if __name__ == "__main__":
    load_dotenv()

    logging.basicConfig(level=logging.INFO)

    asyncio.run(main())
