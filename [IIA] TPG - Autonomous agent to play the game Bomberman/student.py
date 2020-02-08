import json
import asyncio
import websockets
import getpass
import os

from mapa import Map
from student_lib.consts import RESEND_ATTEMPTS
from student_lib.agent import Agent


async def agent_loop(server_address="localhost:8000", agent_name="student"):
    async with websockets.connect(f"ws://{server_address}/player") as websocket:

        # Receive information about static game properties
        await websocket.send(json.dumps({"cmd": "join", "name": agent_name}))
        msg = await websocket.recv()
        game_properties = json.loads(msg)

        # You can create your own map representation or use the game representation:
        mapa = Map(size=game_properties["size"], mapa=game_properties["map"])

        agent = Agent(mapa.map, {})
        key = ""
        last_position = [1, 1]
        last_lives = None
        last_level = 1
        powerups = {}
        resent = 0

        final_level = None
        try:
            import game
            final_level = len(game.LEVEL_ENEMIES)
        except:
            pass

        while True:
            try:
                state = json.loads(
                    await websocket.recv(),
                )  # receive game state, this must be called timely or your game will get out of sync with the server

                while websocket.messages:
                    state = json.loads(await websocket.recv())

                try:
                    current_level = state['level']
                    if current_level == final_level and len(state['enemies']) == 0:
                        raise KeyError
                except KeyError:
                    return 0

                if last_level != current_level:
                    for powerup in powerups:
                        if not powerups[powerup]:
                            del powerups[powerup]
                            break
                    agent = Agent(mapa.map, powerups)
                    key = ""
                    last_position = [1, 1]
                    last_level = current_level
                    resent = 0


                elif last_lives is not None and state['lives'] != last_lives:
                    agent = Agent(mapa.map, powerups)
                    key = ""
                    last_position = [1, 1]

                elif state['bomberman'] == last_position and key in ["w", "a", "s", "d"] and resent <= RESEND_ATTEMPTS:
                    resent += 1

                else:
                    resent = 0
                    key, powerups = agent.get_next_key(state)

                last_lives = state['lives']

                await websocket.send(
                    json.dumps({"cmd": "key", "key": key})
                )  # send key command to server - you must implement this send in the AI agent

            except websockets.exceptions.ConnectionClosedOK:
                return
            except KeyError:
                return
            except:
                return


# DO NOT CHANGE THE LINES BELLOW
# You can change the default values using the command line, example:
# $ NAME='bombastico' python3 client.py
loop = asyncio.get_event_loop()
SERVER = os.environ.get("SERVER", "localhost")
PORT = os.environ.get("PORT", "8000")
NAME = os.environ.get("NAME", getpass.getuser())
loop.run_until_complete(agent_loop(f"{SERVER}:{PORT}", NAME))
