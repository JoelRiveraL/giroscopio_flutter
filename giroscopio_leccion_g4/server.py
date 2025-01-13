import asyncio
import websockets
import time
import os
last_command_time = 0
command_cooldown = 1  # Tiempo mínimo entre comandos (en segundos)

async def handler(websocket):
    global last_command_time
    print("Client connected")
    try:
        async for message in websocket:
            current_time = time.time()
            if current_time - last_command_time >= command_cooldown:
                last_command_time = current_time
                if message == 'open_browser':
                    print("Opening browser...")
                    os.system("start chrome")
                elif message == 'open_word':
                    print("Opening Word...")
                    os.system("start winword")
                elif message == 'play_music':
                    print("Playing music...")
                    os.system("start wmplayer")
    except websockets.exceptions.ConnectionClosedError as e:
        print(f"Connection closed: {e}")
    except Exception as e:
        print(f"Unexpected error: {e}")
    finally:
        print("Client disconnected")

async def main():
    # Configurar el servidor con un tiempo de ping mayor
    server = await websockets.serve(
        handler,
        "0.0.0.0",
        8765,
        ping_interval=20,  # Intervalo de ping en segundos
        ping_timeout=10    # Tiempo de espera para el pong
    )
    print("Server started at ws://localhost:8765")
    await server.wait_closed()

asyncio.run(main())
