# One Inventory integration

Re-upload these files to add One Inventory support to lb-tablet.

## Required files

```
shared/functions.lua
server/custom/functions/items.lua
server/custom/functions/stash.lua
server/custom/functions/registerWeapons.lua
server/custom/functions/uniquePhones/one_inventory.lua
client/custom/functions/items.lua
client/custom/functions/stash.lua
client/custom/frameworks/esx/items.lua
client/custom/frameworks/qb/items.lua
client/custom/frameworks/qbox/items.lua
client/custom/frameworks/qbox/qbox.lua
client/custom/frameworks/standalone/items.lua
server/custom/frameworks/esx/items.lua
server/custom/frameworks/qb/items.lua
server/custom/frameworks/qbox/items.lua
server/custom/frameworks/standalone/items.lua
```

## Config

In `config/config.lua`:

```lua
Config.Item.Inventory = "auto"
```

Or force it:

```lua
Config.Item.Inventory = "one_inventory"
```

Start `one_inventory` before `lb-tablet` in your `server.cfg`.
