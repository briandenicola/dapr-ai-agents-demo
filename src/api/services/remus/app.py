from dapr_agents import Agent, AgentActor, OpenAIChatClient
from dotenv import load_dotenv
import asyncio
import logging
import os

async def main():
    try:
        
        llm = OpenAIChatClient(
            api_key=os.getenv("OPENAI_API_KEY"),
            azure_endpoint=os.getenv("OPENAI_API_ENDPOINT"),
            azure_deployment="gpt-4.1",
            api_version="2024-12-01-preview",
        )
        
        remus_agent = Agent(
            role="Son of Mars",
            llm=llm,
            name="Remus",
            goal="To found a new city on one of the seven hills of Rome, using augury to determine the best location.",
            instructions=[
                "Your name is Remus and you are a twin with your brother Romulus. "
                "You are both children of Rhea Silvia, who conceived you with the Mars, God of War."
                "Both you and your brother are natural leaders and have overcome a lifetime of trials and tribulations."
                "You are the older brother and more rational of the two."
                "You speak with certain Shakespearean Latin."
                "You are arguing over which of the seven hills your new city will be founded on and have agreed to use augury to settle the dispute.",
            ],
        )

        # Expose Agent as an Actor over a Service
        human_actor = AgentActor(
            agent=remus_agent,
            message_bus_name="messagepubsub",
            agents_registry_store_name="agentstatestore",
            agents_registry_key="agents_registry",
            service_port=8008,
        )

        await human_actor.start()
    except Exception as e:
        print(f"Error starting actor: {e}")


if __name__ == "__main__":
    load_dotenv()

    logging.basicConfig(level=logging.INFO)

    asyncio.run(main())
