# fivem-interact
-- (EN)
A basic script for interacting with objects/vehicles/peds for FiveM, based on lua 5.4 and OpenGL Mathematics. 
This code was a quick example, nothing that can't be improved! Feel free to modify as you like!

-- (PT-BR)
Um script básico para a interação com objetos/veículos/peds para FiveM, baseado em lua 5.4 e OpenGL Mathematics.
Este código foi um exemplo rápido, nada que não possa ser melhorado! Fique livre para modificar como preferir!

## How to Install (EN)
* To install is very simple! Just add ```ensure fivem-interact``` in the server settings (server.cfg)! Example:
```
ensure mapmanager
ensure spawnmanager
ensure sessionmanager
ensure fivem
ensure fivem-interact
```
## Como instalar (PT-BR)
* Para instalar é muito simples! Apenas adicione ```ensure fivem-interact``` nas configurações do servidor (server.cfg)! Exemplo:
```
ensure mapmanager
ensure spawnmanager
ensure sessionmanager
ensure fivem
ensure fivem-interact
```

## Use (uso)
```lua
exports["fivem-interact"]:addInteration(entity,function(dist)
    print("The user interacted with the entity! Dist is: "..dist)
end)
```
## Credits:
* key_value : Special thanks especially to key_value, who brought this idea along with the group code example.
* B2K Development Group (https://discord.gg/7YvTPnF)
* Original Code Snippet: https://discord.com/channels/558655512741412864/803773073119379546/872932848523427851
