import asyncio
import websockets
import os  # Para ejecutar comandos del sistema

async def handler(websocket):
    print("Client connected")
    async for message in websocket:
        if message == 'open_browser':
            print("Opening browser...")
            os.system("start chrome")  # Cambia "chrome" por el navegador que desees
        elif message == 'open_word':
            print("Opening Word...")
            os.system("start winword")  # Comando para abrir Microsoft Word
        elif message == 'play_music':
            print("Playing music...")
            os.system("start wmplayer")  # Comando para abrir Windows Media Player
        else:
            print(f"Unknown command: {message}")

async def main():
    # Inicia el servidor WebSocket
    server = await websockets.serve(handler, "0.0.0.0", 8765)
    print("Server started at ws://localhost:8765")
    await server.wait_closed()

# Ejecutar el servidor
asyncio.run(main())
